/**
 * @name SQL Injection via String Concatenation
 * @description Detects SQL queries built using string concatenation with variables,
 *              which can lead to SQL injection vulnerabilities.
 * @kind path-problem
 * @problem.severity error
 * @security-severity 8.8
 * @precision high
 * @id java/sql-injection-concatenation
 * @tags security
 *       external/cwe/cwe-089
 */

import java
import semmle.code.java.dataflow.TaintTracking
import DataFlow::PathGraph

/**
 * A taint-tracking configuration for SQL injection via concatenation
 */
class SqlInjectionConfig extends TaintTracking::Configuration {
  SqlInjectionConfig() { this = "SqlInjectionConfig" }

  override predicate isSource(DataFlow::Node source) {
    // Parámetros de métodos son fuentes potenciales
    source.asParameter().getType() instanceof TypeString
  }

  override predicate isSink(DataFlow::Node sink) {
    exists(MethodAccess call |
      // executeQuery de Statement
      call.getMethod().hasName("executeQuery") and
      call.getMethod().getDeclaringType().hasQualifiedName("java.sql", "Statement") and
      sink.asExpr() = call.getArgument(0)
    )
  }

  override predicate isAdditionalTaintStep(DataFlow::Node node1, DataFlow::Node node2) {
    // La concatenación propaga el taint
    exists(AddExpr add |
      add.getAnOperand() = node1.asExpr() and
      add = node2.asExpr()
    )
  }
}

from SqlInjectionConfig config, DataFlow::PathNode source, DataFlow::PathNode sink
where config.hasFlowPath(source, sink)
select sink.getNode(), source, sink,
  "SQL query is built using $@ which may be user-controlled, leading to SQL injection.",
  source.getNode(), "this parameter"