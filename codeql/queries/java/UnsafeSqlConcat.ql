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
  call.getMethod().getDeclaringType().hasQualifiedName("java.sql", "Statement")
  
select call, "Potential SQL injection: executeQuery called on Statement. Use PreparedStatement instead."
