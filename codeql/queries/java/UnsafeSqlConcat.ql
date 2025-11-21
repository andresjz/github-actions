/**
 * @name SQL Injection via String Concatenation
 * @description Detects SQL queries built using string concatenation.
 * @kind problem
 * @problem.severity error
 * @id java/sql-injection-concatenation
 * @tags security
 */

import java

predicate isQueryVariable(Expr e, AddExpr concat) {
  exists(VarAccess va, LocalVariableDeclExpr decl |
    va = e and
    decl.getVariable() = va.getVariable() and
    concat = decl.getInit()
  )
}

from MethodCall call, AddExpr concat
where
  call.getMethod().hasName("executeQuery") and
  call.getMethod().getDeclaringType().hasQualifiedName("java.sql", "Statement") and
  (
    // Caso 1: concatenación directa como argumento
    concat = call.getArgument(0)
    or
    // Caso 2: variable que contiene concatenación
    isQueryVariable(call.getArgument(0), concat)
  ) and
  // Verificar que contiene palabras SQL
  exists(StringLiteral lit |
    lit = concat.getAnOperand() and
    (
      lit.getValue().matches("%SELECT%") or
      lit.getValue().matches("%INSERT%") or
      lit.getValue().matches("%UPDATE%") or
      lit.getValue().matches("%DELETE%")
    )
  )
  
select call, "Potential SQL injection: query uses string concatenation. Use PreparedStatement instead."
