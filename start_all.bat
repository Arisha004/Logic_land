@echo off
title LogicLand
echo.
echo  =============================================
echo    LogicLand - Full Stack Start
echo  =============================================
echo.

set ROOT=%~dp0

:: Install Python packages if not already done
if not exist "%ROOT%py_packages\fastapi" (
    echo [1/2] Installing backend packages (first time only)...
    if not exist "%ROOT%py_packages" mkdir "%ROOT%py_packages"
    pip install fastapi uvicorn sqlalchemy psycopg2-binary "python-jose[cryptography]" "passlib[bcrypt]" "pydantic[email]" python-multipart python-dotenv langchain-anthropic langchain-core --target "%ROOT%py_packages" --quiet
    echo [OK] Done
) else (
    echo [1/2] Backend packages already installed
)

:: Install npm packages if missing
if not exist "%ROOT%frontend\node_modules" (
    echo [2/2] Installing frontend packages (first time only)...
    cd /d "%ROOT%frontend"
    npm install
) else (
    echo [2/2] Frontend packages already installed
)

echo.
echo Starting both servers in separate windows...
echo.

:: Start backend in its own window using the dedicated script
start "LogicLand Backend" cmd /k "%ROOT%run_backend.bat"

timeout /t 6 /nobreak >nul

:: Start frontend in its own window
start "LogicLand Frontend" cmd /k "%ROOT%run_frontend.bat"

echo.
echo  =============================================
echo   Both servers starting in new windows!
echo.
echo   App:      http://localhost:3000
echo   API:      http://localhost:8000/docs
echo   Demo:     demo@logicland.io / Demo1234!
echo.
echo   Wait ~20 seconds for Next.js to compile.
echo  =============================================
echo.
timeout /t 20 /nobreak >nul
start http://localhost:3000
pause
