/**
 * @name MagicSum with 13 Check
 * @description This query checks if the magicSum function is called with 13 as a parameter.
 * @kind problem
 * @problem.severity error
 * @id js/magic-sum-13-check
 * @tags security
 */

import javascript

predicate isMagicSum(CallExpr call) {
  call.getCalleeName() = "magicSum"
}

predicate isCalledWith13(CallExpr call) {
  exists(Expr arg |
    arg = call.getAnArgument() and
    arg.getIntValue() = 13
  )
}

from CallExpr call
where isMagicSum(call) and isCalledWith13(call)
select call, "The magicSum function should not be called with 13 as a parameter."