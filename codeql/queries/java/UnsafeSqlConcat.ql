/**
 * @name SQL Injection via String Concatenation
 * @description Detects SQL queries built using string concatenation.
 * @kind problem
 * @problem.severity error
 * @id java/sql-injection-concatenation
 * @tags security
 */

import java

from MethodAccess call, AddExpr concat
where
  // executeQuery de Statement
  call.getMethod().hasName("executeQuery") and
  call.getMethod().getDeclaringType().hasQualifiedName("java.sql", "Statement") and
  
  // El argumento (directamente o a través de una variable) es una concatenación
  (
    concat = call.getArgument(0)
    or
    exists(Variable v |
      v.getAnAccess() = call.getArgument(0) and
      concat = v.getAnAssignedValue()
    )
  ) and
  
  // La concatenación incluye un literal SQL
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
