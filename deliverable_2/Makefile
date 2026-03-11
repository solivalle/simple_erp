.PHONY: setup run migrate seed install clean

PYTHON=python3
VENV=venv
PIP=$(VENV)/bin/pip
PY=$(VENV)/bin/python

setup: install env migrate seed
	@echo "Proyecto configurado correctamente."

install:
	@echo "Creando entorno virtual..."
	$(PYTHON) -m venv $(VENV)
	@echo "Instalando dependencias..."
	$(PIP) install -r requirements.txt

env:
	@if [ ! -f .env ]; then cp .env.example .env; fi
	@echo "Archivo .env configurado."

migrate:
	@echo "Ejecutando migraciones..."
	$(PY) manage.py migrate

seed:
	@echo "Cargando datos iniciales..."
	@if [ -f initial_data.json ]; then $(PY) manage.py loaddata initial_data.json; fi

run:
	$(PY) manage.py runserver

clean:
	rm -rf $(VENV)