/**
 * @name MagicSum with 13 Check
 * @description This query checks if the magicSum function is called with 13 as a parameter.
 * @kind problem
 * @problem.severity error
 * @id js/magic-sum-13-check
 * @tags security
 */

import javascript

predicate isMagicSum(FunctionCall call) {
  call.getCallee().getName() = "magicSum"
}

predicate isCalledWith13(FunctionCall call) {
  exists(int i |
    call.getArgument(i).getValue() = "13"
  )
}

from FunctionCall call
where isMagicSum(call) and isCalledWith13(call)
select call, "The magicSum function should not be called with 13 as a parameter."