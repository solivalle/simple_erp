# Friction Points – simple_erp Project

Este documento identifica todos los puntos donde un ingeniero nuevo podría quedarse atascado al intentar configurar, ejecutar o trabajar con el proyecto **simple_erp**.  
Cada punto está etiquetado según el tipo de fricción detectado.

## Lista de Friction Points

1. **[MISSING_DOC]** El `README.md` no contiene instrucciones básicas para iniciar el proyecto. No explica cómo clonar el repositorio, instalar dependencias, configurar la base de datos o ejecutar el servidor.

2. **[MISSING_DOC]** El README no menciona que el proyecto está construido con **Django**, lo que dificulta entender cómo se debe ejecutar o estructurar la aplicación.

3. **[VERSION_HELL]** No se especifica la versión de Python requerida. El proyecto usa `Django==4.2.2`, que requiere Python ≥ 3.8, pero esto no se menciona en la documentación.

4. **[MISSING_DOC]** El proyecto no explica que deberías crear un entorno virtual de Python antes de instalar dependencias, lo cual es una práctica estándar en casi todos los proyectos Python.

5. **[MISSING_DOC]** No se documenta el comando necesario para instalar las dependencias del proyecto usando el archivo `requirements.txt` (pip install -r requirements.txt).

6. **[IMPLICIT_DEP]** El proyecto depende de **PostgreSQL** como base de datos (`django.db.backends.postgresql`), pero el README no menciona que PostgreSQL debe estar instalado.

7. **[IMPLICIT_DEP]** El paquete `psycopg2` requiere dependencias de postgres (por ejemplo `libpq-dev` o `postgresql`), pero estas dependencias no están documentadas.

8. **[ENV_GAP]** Las credenciales de la base de datos están hardcodeadas en `settings.py` (`NAME=tienda`, `USER=postgres`, `PASSWORD=my_pass`, `HOST=127.0.0.1`, `PORT=5432`). No se documenta que el desarrollador debe crear una base de datos con esa configuración exacta.

9. **[MISSING_DOC]** No se explica que el usuario debe crear manualmente la base de datos `tienda` antes de ejecutar el proyecto.

10. **[MISSING_DOC]** No se documenta el paso de ejecutar las migraciones de Django (`python manage.py migrate`) para crear las tablas necesarias en la base de datos.

11. **[MISSING_DOC]** El proyecto incluye el panel de administración de Django, pero no se explica cómo crear un superusuario (`python manage.py createsuperuser`).

12. **[MISSING_DOC]** El README no explica cómo iniciar el servidor usando `python manage.py runserver`.

13. **[MISSING_DOC]** El repositorio contiene archivos de plantilla Excel (`23AKP08_PLANTILLA.xlsx`, `23AKP08PL_PLANTILLA.xlsx`), pero no se explica su propósito ni cómo se utilizan dentro del sistema.

14. **[IMPLICIT_DEP]** El proyecto utiliza la librería `openpyxl` para manipular archivos Excel, pero esta funcionalidad no está documentada.

15. **[MISSING_DOC]** No hay documentación sobre el manejo de archivos estáticos ni si es necesario ejecutar `python manage.py collectstatic` en entornos de producción.

16. **[ENV_GAP]** El archivo `settings.py` contiene un `SECRET_KEY` hardcodeado en el código fuente en lugar de utilizar variables de entorno.

17. **[SILENT_FAIL]** El proyecto fue distribuido incluyendo la carpeta `.git` dentro del archivo comprimido, lo cual puede generar confusión y no es necesario para ejecutar el proyecto.

## Conclusión

El proyecto presenta múltiples puntos de fricción que dificultan el onboarding de nuevos desarrolladores. Los principales problemas son:

- Falta de documentación en el README.
- Dependencias críticas no documentadas.
- Configuraciones sensibles hardcodeadas en el código.
- Pasos fundamentales de Django no descritos.
