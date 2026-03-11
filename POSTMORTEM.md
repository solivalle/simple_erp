# Postmortem – simple_erp Project

## What Was Broken

El repositorio original no podía ejecutarse correctamente sin investigación manual significativa.  
Faltaban instrucciones claras de instalación, dependencias del sistema no estaban documentadas y la configuración de base de datos y variables de entorno debía deducirse manualmente. Como resultado, un nuevo ingeniero encontraría múltiples bloqueos antes de lograr ejecutar el sistema localmente.

---

## What We Built

Para eliminar los bloqueos detectados durante el análisis de fricción se crearon los siguientes artefactos:

**setup.sh**

Script de bootstrap del entorno de desarrollo.  
Este script verifica que Python esté instalado, crea un entorno virtual, instala las dependencias del proyecto, configura el archivo `.env` y ejecuta las migraciones de Django.

Elimina los siguientes problemas:

- dependencias no instaladas
- entorno virtual faltante
- migraciones no ejecutadas
- archivo `.env` inexistente

---

**Makefile**

Archivo que automatiza tareas comunes del proyecto mediante comandos simples.

Incluye comandos como:

- `make setup`
- `make run`
- `make clean`

El comando `make setup` instala dependencias, configura variables de entorno, ejecuta migraciones y carga datos iniciales si existen.

Esto reduce significativamente la fricción para nuevos desarrolladores.

---

**docker-compose.yml**

Archivo que permite ejecutar el stack completo del sistema utilizando contenedores.

Levanta automáticamente:

- aplicación Django
- base de datos PostgreSQL

Esto elimina la necesidad de instalar PostgreSQL manualmente y asegura que todos los desarrolladores utilicen el mismo entorno de ejecución.

---

**Documentación de Setup**

Se creó documentación detallada explicando:

- cómo ejecutar el proyecto
- qué hace cada artefacto
- qué variables de entorno son necesarias
- el flujo completo de inicialización del sistema

Esto elimina suposiciones implícitas en el proceso de onboarding.

---

## Cost of the Original State

Durante el análisis se estimó que un nuevo ingeniero podría perder aproximadamente **3 horas** intentando configurar el proyecto antes de ejecutarlo correctamente.

Si una organización incorpora **5 ingenieros nuevos por mes**, el tiempo total perdido sería:

15 horas × $100 = $1,500 por mes

Esto equivale a **$18,000 al año** en tiempo de ingeniería perdido únicamente por problemas de configuración y documentación.

---

## What We Would Do Next

La mejora con mayor retorno de inversión sería agregar un **pipeline de CI (Continuous Integration)** que valide automáticamente que el proyecto pueda construirse y ejecutarse desde cero.

Por ejemplo, un pipeline en GitHub Actions que:

1. construya el contenedor Docker
2. instale dependencias
3. ejecute migraciones
4. corra pruebas automatizadas

Esto garantizaría que el proyecto siempre permanezca en un estado ejecutable y evitaría que futuros cambios vuelvan a introducir problemas de configuración o dependencias rotas.