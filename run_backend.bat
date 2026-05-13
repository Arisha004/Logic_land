@echo off
title LogicLand Backend
echo  ================================
echo   LogicLand Backend Starting...
echo  ================================
echo.

cd /d "%~dp0backend"
set PYTHONPATH=%~dp0py_packages

echo PYTHONPATH set to: %PYTHONPATH%
echo.
echo Starting FastAPI on http://localhost:8000
echo Press Ctrl+C to stop
echo.

python -m uvicorn main:app --host 0.0.0.0 --port 8000 --reload
pause
