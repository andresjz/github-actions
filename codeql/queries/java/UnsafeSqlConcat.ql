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
  exists(RefType stmtType |
    call.getQualifier().getType() = stmtType and
    stmtType.hasQualifiedName("java.sql", "Statement")
  )
}

predicate concatUsesParameter(AddExpr concat) {
  exists(ParameterAccess pa |
    concat.getAnOperand() = pa
  )
}

predicate concatHasStringLiteral(AddExpr concat) {
  exists(StringLiteral lit |
    concat.getAnOperand() = lit
  )
}

from MethodAccess call, AddExpr concat
where
  isStatementExecuteQuery(call) and
  concat = call.getArgument(0) and
  concatHasStringLiteral(concat) and
  concatUsesParameter(concat)
select call, "Evita concatenar parámetros directamente en consultas SQL."

