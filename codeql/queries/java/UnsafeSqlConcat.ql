/**
 * @name SQL Injection via String Concatenation
 * @description Detects SQL queries built using string concatenation.
 * @kind problem
 * @problem.severity error
 * @id java/sql-injection-concatenation
 * @tags security
 */

import java

from MethodCall call
where
  call.getMethod().hasName("executeQuery") and
  call.getMethod().getDeclaringType().hasQualifiedName("java.sql", "Statement") and
  exists(AddExpr concat |
    // Buscar concatenaciones en el mismo método
    concat.getEnclosingCallable() = call.getEnclosingCallable() and
    // Que contengan SELECT, INSERT, etc
    exists(StringLiteral lit |
      lit = concat.getAnOperand() and
      (
        lit.getValue().matches("%SELECT%") or
        lit.getValue().matches("%INSERT%") or
        lit.getValue().matches("%UPDATE%") or
        lit.getValue().matches("%DELETE%")
      )
    )
  )
  
select call, "Potential SQL injection: this method contains string concatenation with SQL keywords. Use PreparedStatement instead."
