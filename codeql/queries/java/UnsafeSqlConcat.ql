/**
 * @name SQL Injection via String Concatenation
 * @description Detects SQL queries built using string concatenation.
 * @kind problem
 * @problem.severity error
 * @id java/sql-injection-concatenation
 * @tags security
 */

import java

from MethodCall call, LocalVariableDecl queryVar, AddExpr concat
where
  // El método es executeQuery de Statement
  call.getMethod().hasName("executeQuery") and
  call.getMethod().getDeclaringType().hasQualifiedName("java.sql", "Statement") and
  
  // El argumento es un acceso a una variable local
  queryVar.getAnAccess() = call.getArgument(0) and
  
  // Esa variable se inicializa con una concatenación
  concat = queryVar.getInitializer() and
  
  // La concatenación contiene un literal SQL
  exists(StringLiteral lit |
    lit = concat.getAnOperand() and
    (
      lit.getValue().matches("%SELECT%") or
      lit.getValue().matches("%INSERT%") or
      lit.getValue().matches("%UPDATE%") or
      lit.getValue().matches("%DELETE%")
    )
  )
  
select call, 
  "SQL injection risk: query variable '" + queryVar.getName() + 
  "' is built using string concatenation. Use PreparedStatement instead."
