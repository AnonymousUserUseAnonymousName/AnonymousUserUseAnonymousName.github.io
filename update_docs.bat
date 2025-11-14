@echo off
REM Quick script to rebuild and deploy documentation (Windows)

echo 🔄 Updating documentation...

REM Navigate to documentation directory
cd /d "%~dp0documentation"

REM Check if virtual environment exists
if exist "venv" (
    echo 🔌 Activating virtual environment...
    call venv\Scripts\activate.bat
)

REM Rebuild documentation
echo 🏗️  Rebuilding documentation from source files...
make current-docs

REM Check if build was successful
if not exist "_build\current\index.html" (
    echo ❌ Build failed! index.html not found.
    exit /b 1
)

REM Go back to repository root
cd ..

REM Deploy to docs/ folder
echo 📦 Deploying to docs/ folder...
if exist "docs" rmdir /s /q docs
mkdir docs
xcopy /E /I documentation\_build\current\* docs\

echo ✅ Documentation updated successfully!
echo.
echo 📁 Updated files are in: docs\
echo.
echo Next steps:
echo   1. Review changes: git status
echo   2. Commit: git add documentation\source\ docs\
echo   3. Push: git commit -m "Update documentation" ^&^& git push

