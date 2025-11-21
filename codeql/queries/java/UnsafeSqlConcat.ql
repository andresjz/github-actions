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
  call.getArgument(0) instanceof AddExpr
  
select call, "Potential SQL injection: query uses string concatenation. Use PreparedStatement instead."
