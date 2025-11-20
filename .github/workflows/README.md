# GitHub Actions: Ruta de Aprendizaje CI/CD

Este proyecto incluye varios workflows de GitHub Actions pensados para enseñar CI/CD de forma incremental. Se recomienda revisarlos en este orden:

1. **01-lint-and-format.yml – Lint y formateo en PR**  
   - **Evento**: `pull_request` sobre `main`.  
   - **Objetivo**: Primer contacto con GitHub Actions. Revisa el código automáticamente con ESLint y Prettier cuando se abre o actualiza un PR.  
   - **Conceptos clave**: jobs, `runs-on`, `actions/checkout`, `actions/setup-node`, ejecutar `npm run lint` y `npm run prettier-check`.

2. **02-conditional-tests.yml – Tests condicionales**  
   - **Evento**: `pull_request` sobre `main`.  
   - **Objetivo**: Introducir condiciones (`if`) en jobs. Solo ejecuta los tests si se cumplen ciertas condiciones en el PR.  
   - **Conceptos clave**: expresión `if` a nivel de job, uso de `github.event` y `github.ref`.

3. **03-tests-with-slack-notification.yml – Tests con notificación a Slack**  
   - **Evento**: `pull_request` sobre `main`.  
   - **Objetivo**: Mostrar cómo integrar GitHub Actions con herramientas externas (Slack). Ejecuta tests y, si fallan, envía una notificación a un webhook de Slack.  
   - **Conceptos clave**: `continue-on-error`, uso de `steps.<id>.outcome`, secreto `SLACK_WEBHOOK_URL`, comando `curl`.

4. **04-codeql-advanced.yml – Análisis de seguridad con CodeQL**  
   - **Eventos**: `push`, `pull_request` sobre `main` y `schedule` (cron semanal).  
   - **Objetivo**: Introducir el escaneo de seguridad y calidad de código a nivel más avanzado.  
   - **Conceptos clave**: matrices (`strategy.matrix`), permisos (`permissions`), acción `github/codeql-action`, queries personalizadas desde `./codeql/queries`.

5. **05-cross-repo-trigger.yml – Orquestación entre repositorios**  
   - **Evento**: `push` sobre `main`.  
   - **Objetivo**: Enseñar cómo un repo puede disparar workflows en otro repo, habilitando orquestación multi-repo.  
   - **Conceptos clave**: `curl` a la API de GitHub, endpoint `repository_dispatch`, uso de un token personal (`PAT_TOKEN`) como secreto.

6. **06-release-semantic-versioning.yml – Lanzamiento y versionado**  
   - **Evento**: `push` sobre `main`.  
   - **Objetivo**: Cerrar el ciclo CI/CD creando tags y releases a partir de la versión de `package.json`.  
   - **Conceptos clave**: leer archivos con Node, exportar variables con `GITHUB_ENV`, autenticarse con `GITHUB_TOKEN`, crear tags y releases, usar `CHANGELOG.md` como cuerpo de la release.

## Uso sugerido para enseñar

- **Primero**: explicar la estructura básica de un workflow usando `01-lint-and-format.yml`.  
- **Luego**: mostrar cómo hacer el pipeline más inteligente con condiciones (`02-conditional-tests.yml`).  
- **Después**: añadir integración con herramientas externas (`03-tests-with-slack-notification.yml`).  
- **Más avanzado**: introducir seguridad y calidad con CodeQL (`04-codeql-advanced.yml`).  
- **Orquestación**: ver cómo coordinar repositorios diferentes (`05-cross-repo-trigger.yml`).  
- **Finalmente**: cerrar el ciclo con un flujo de release automatizado (`06-release-semantic-versioning.yml`).

Este README está pensado como guía rápida; puedes ampliarlo con ejemplos de ejecuciones reales, capturas de pantalla del tab de Actions y ejercicios para el alumnado.
