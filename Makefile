.PHONY: install run test lint format clean help

PYTHON ?= python
VENV = .venv

ifeq ($(OS),Windows_NT)
    VENV_PY = $(VENV)/Scripts/python.exe
else
    VENV_PY = $(VENV)/bin/python
endif

help:
	@echo "Available targets:"
	@echo "  install   Create venv and install dependencies"
	@echo "  run       Run the Tkinter app"
	@echo "  test      Run pytest"
	@echo "  lint      Run Ruff checks"
	@echo "  format    Format code with Ruff"
	@echo "  clean     Remove caches and venv"

install:
	$(PYTHON) -m venv $(VENV)
	$(VENV_PY) -m pip install --upgrade pip
	$(VENV_PY) -m pip install -r requirements.txt

run:
	$(VENV_PY) main_gui.py

test:
	$(VENV_PY) -m pytest -q

lint:
	$(VENV_PY) -m ruff check .

format:
	$(VENV_PY) -m ruff format .

clean:
	$(PYTHON) -c "import shutil, pathlib; dirs=[pathlib.Path('.venv'), pathlib.Path('__pycache__'), pathlib.Path('.pytest_cache'), pathlib.Path('.ruff_cache')]; [shutil.rmtree(d, ignore_errors=True) for d in dirs]"