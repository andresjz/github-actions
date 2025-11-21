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
  exists(Type t |
    call.getQualifier().getType() = t and
    t.getErasure().hasQualifiedName("java.sql", "Statement")
  )
}

predicate usesParamInConcat(AddExpr concat) {
  exists(Parameter param, VariableAccess va |
    va.getVariable() = param and
    concat.getAnOperand() = va
  )
}

from MethodAccess call, AddExpr concat
where
  isStatementExecuteQuery(call) and
  call.getArgument(0) = concat and
  concat.getAnOperand() instanceof StringLiteral and
  usesParamInConcat(concat)
select call, "Evita concatenar parámetros directamente en consultas SQL."

