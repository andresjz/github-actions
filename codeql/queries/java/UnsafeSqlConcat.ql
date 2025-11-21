/**
 * @name SQL concatenation in executeQuery
 * @description Flags SQL statements built por concatenación con parámetros.
 * @kind problem
 * @problem.severity warning
 * @id java/unsafe-sql-concat
 * @tags security
 */

import java

predicate isStatementExecuteQuery(MethodAccess call) {
  call.getMethod().hasName("executeQuery") and
  call.getMethod().getDeclaringType().hasQualifiedName("java.sql", "Statement")
}

predicate literalAndParameter(AddExpr concat) {
  (
    concat.getLeftOperand() instanceof StringLiteral and
    concat.getRightOperand() instanceof ParameterAccess
  ) or
  (
    concat.getRightOperand() instanceof StringLiteral and
    concat.getLeftOperand() instanceof ParameterAccess
  )
}

from MethodAccess call, AddExpr concat
where
  isStatementExecuteQuery(call) and
  concat = call.getArgument(0) and
  literalAndParameter(concat)
select call, "Evita concatenar parámetros directamente en consultas SQL."

