# Running the Project

Este documento explica cómo ejecutar el proyecto utilizando los tres artefactos creados para eliminar los problemas de configuración detectados:

- `setup.sh`
- `Makefile`
- `docker-compose.yml`

Cada uno automatiza diferentes partes del proceso de instalación y ejecución del sistema.

---

# 1. setup.sh

## Propósito

El archivo `setup.sh` es un script de **bootstrap del entorno de desarrollo**.  
Su objetivo es preparar automáticamente el entorno necesario para ejecutar el proyecto.

Este script elimina varios bloqueos comunes:

- Python no instalado
- entorno virtual faltante
- dependencias no instaladas
- archivo `.env` inexistente
- migraciones no ejecutadas

---

## Cómo ejecutarlo

Primero dar permisos de ejecución:

chmod +x setup.sh

Luego ejecutarlo:

./setup.sh

---

## Flujo de ejecución

Cuando se ejecuta `setup.sh`, el script realiza los siguientes pasos:

### 1. Verificación de Python

El script verifica si `python3` está instalado en el sistema.

Si Python no está instalado, el script termina mostrando un mensaje de error claro.

---

### 2. Creación del entorno virtual

Si la carpeta `venv` no existe, el script ejecuta:

python3 -m venv venv

Esto crea un entorno virtual aislado para el proyecto.

---

### 3. Activación del entorno virtual

El script activa el entorno virtual para que las dependencias se instalen dentro del proyecto.

source venv/bin/activate

---

### 4. Instalación de dependencias

Se instalan las dependencias definidas en el proyecto:

pip install -r requirements.txt

Esto instala librerías necesarias como Django y psycopg2.

---

### 5. Verificación de PostgreSQL

El script verifica si el cliente `psql` está disponible.

Si no está instalado, muestra una advertencia indicando que PostgreSQL debe instalarse.

---

### 6. Configuración del archivo de entorno

Si el archivo `.env` no existe, se crea automáticamente:

cp .env.example .env

Esto asegura que las variables de entorno necesarias estén definidas.

---

### 7. Ejecución de migraciones

El script ejecuta:

python manage.py migrate

Esto crea todas las tablas necesarias en la base de datos.

---

### 8. Finalización

El script muestra instrucciones para iniciar el servidor de desarrollo.

---

# 2. Makefile

## Propósito

El `Makefile` permite ejecutar múltiples pasos del proyecto usando **comandos simples**.

Esto simplifica el proceso de setup para nuevos desarrolladores.

---

## Comando principal

make setup

---

## Flujo de ejecución

El comando `make setup` ejecuta automáticamente varias tareas.

### Paso 1 – install

Crea el entorno virtual e instala dependencias.

python3 -m venv venv
pip install -r requirements.txt

---

### Paso 2 – env

Verifica si existe el archivo `.env`.

Si no existe, lo crea automáticamente:

cp .env.example .env

---

### Paso 3 – migrate

Ejecuta las migraciones de Django:

python manage.py migrate

Esto crea las tablas necesarias en PostgreSQL.

---

## Otros comandos útiles

Ejecutar el servidor:

make run

Eliminar el entorno virtual:

make clean

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

# Flujo recomendado para nuevos desarrolladores

Existen dos formas de ejecutar el proyecto.

---

## Opción 1 (Recomendada)

Usar Docker para ejecutar todo el sistema.

docker compose up

Esto levanta automáticamente:

- base de datos
- aplicación
- red entre servicios

---

## Opción 2 (Ejecución local)

Paso 1

./setup.sh

Paso 2

make run

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
