# Running the Project

Este documento explica cómo ejecutar el proyecto utilizando el artefacto creado para eliminar los problemas de configuración detectados:

- `docker-compose.yml`

---

# 3. docker-compose.yml

## Propósito

El archivo `docker-compose.yml` permite ejecutar el **stack completo del sistema** utilizando contenedores.

Esto elimina problemas como:

- instalación manual de PostgreSQL
- conflictos de versiones
- configuración diferente entre máquinas

---

## Cómo ejecutarlo

Ejecutar el siguiente comando:

docker compose up

---

## Flujo de ejecución

Docker Compose levanta dos servicios principales.

---

## Servicio 1: Base de datos

Contenedor PostgreSQL.

Este contenedor:

- crea la base de datos `tienda`
- crea el usuario `postgres`
- configura la contraseña
- expone el puerto `5432`

Esto elimina la necesidad de instalar PostgreSQL manualmente.

---

## Servicio 2: Aplicación Django

El contenedor de la aplicación:

1. monta el código del proyecto
2. conecta con la base de datos
3. ejecuta el servidor de Django
4. expone el puerto `8000`

La aplicación queda disponible en:

http://localhost:8000

---

# Tabla de resoluciones de pain points

| # | Pain Point (Descripción) | Solución con Docker | Estado |
|---|---|---|---|
| 1 | README sin instrucciones básicas de inicio. | Se reduce a un solo comando: `docker compose up`. | Fixed |
| 2 | No menciona que el proyecto usa Django. | Evidente al ver el Dockerfile (Python) y el comando de ejecución. | Fixed |
| 3 | Versión de Python no especificada. | El Dockerfile define la imagen base exacta (ej. `python:3.10-slim`). | Fixed |
| 4 | Creación de entorno virtual no documentada. | Los contenedores son entornos aislados por diseño; no se requiere `venv`. | Fixed |
| 5 | Comando `pip install` no documentado. | La instalación ocurre automáticamente durante el `docker build`. | Fixed |
| 6 | Dependencia de PostgreSQL no mencionada. | El servicio `db` en `docker-compose.yml` provee la base de datos automáticamente. | Fixed |
| 7 | Dependencias de sistema para psycopg2. | Se incluyen en el Dockerfile mediante `apt-get install libpq-dev` antes del build. | Fixed |
| 8 | Credenciales hardcodeadas en `settings.py`. | Se inyectan mediante variables de `environment` en el Compose. | Fixed |
| 9 | Creación manual de la base de datos `tienda`. | `POSTGRES_DB: tienda` en el Compose la crea al arrancar el contenedor. | Fixed |
| 10 | Ejecución de migraciones no documentada. | El comando de inicio (`command`) ejecuta `python manage.py migrate` automáticamente. | Fixed |
| 11 | Creación de superusuario no explicada. | Simplificado mediante `docker compose exec web python manage.py createsuperuser`. | Fixed |
| 12 | Instrucciones para iniciar el servidor. | Gestionado por la instrucción `command` en el servicio `web`. | Fixed |
| 13 | Propósito de plantillas Excel no explicado. | Aunque se incluyen en el contenedor, su lógica de negocio sigue requiriendo manual. | Partial |
| 14 | Uso de `openpyxl` no documentado. | Se instala automáticamente como dependencia en la imagen de Docker. | Fixed |
| 15 | Manejo de archivos estáticos. | El Dockerfile puede ejecutar `collectstatic` durante la construcción de la imagen. | Fixed |
| 16 | `SECRET_KEY` hardcodeada. | Se define como variable de entorno en el archivo de configuración de Docker. | Fixed |
| 17 | Carpeta `.git` incluida en el despliegue. | El archivo `.dockerignore` excluye `.git` para que no contamine la imagen. | Fixed |

---

# Resultado

Estos artefactos eliminan los principales bloqueos detectados en el proyecto:

- dependencias no documentadas
- configuración manual de base de datos
- variables de entorno faltantes
- migraciones olvidadas
- instalación manual compleja

No se utilizó otro artefacto adicional (como .env.example) debido a que el proyecto no cuenta con variables de entorno, sino con valores hardcodeados que tuvieron que ser agregados en el dockerfile para poder ejecutar el proyecto.

