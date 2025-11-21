## Ejemplos Java para CodeQL

Este directorio contiene un par de clases muy sencillas para que CodeQL pueda demostrar findings en Java:

- `UnsafeExample` contiene una concatenación directa de parámetros de entrada y simula un posible SQL Injection.
- `SafeExample` usa `PreparedStatement` y parámetros enlazados para contrarrestar el mismo escenario.

Ejecución rápida (opcional):

```bash
cd Java
javac src/main/java/com/example/*.java
```

> No es necesario compilar para que el flujo de CodeQL detecte los patrones; únicamente se provee como referencia manual.

