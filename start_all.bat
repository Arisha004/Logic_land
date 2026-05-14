@echo off
title LogicLand
echo.
echo  =============================================
echo    LogicLand - Full Stack Start
echo  =============================================
echo.
set ROOT=%~dp0

if not exist "%ROOT%py_packages\fastapi" (
    echo [1/2] Installing backend packages (first time)...
    if not exist "%ROOT%py_packages" mkdir "%ROOT%py_packages"
    pip install fastapi uvicorn sqlalchemy psycopg2-binary "python-jose[cryptography]" "passlib[bcrypt]" "pydantic[email]" python-multipart python-dotenv langchain-anthropic langchain-core --target "%ROOT%py_packages" --quiet
) else (
    echo [1/2] Backend packages ready
)

if not exist "%ROOT%frontend\node_modules" (
    echo [2/2] Installing frontend packages...
    cd /d "%ROOT%frontend"
    npm install
) else (
    echo [2/2] Frontend packages ready
)

echo.
echo Starting both servers...
start "LogicLand Backend" cmd /k "%ROOT%run_backend.bat"
timeout /t 6 /nobreak >nul
start "LogicLand Frontend" cmd /k "%ROOT%run_frontend.bat"

echo.
echo  =============================================
echo   App:      http://localhost:3000
echo   API:      http://localhost:8000/docs
echo   Demo:     demo@logicland.io / Demo1234!
echo   Opens in 20 seconds...
echo  =============================================
timeout /t 20 /nobreak >nul
start http://localhost:3000
pause
