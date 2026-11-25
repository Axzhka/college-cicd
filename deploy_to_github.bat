@echo off
chcp 65001 >nul
echo ========================================================
echo   Автоматическая настройка Git и отправка в GitHub
echo ========================================================
echo.

set /p REPO_URL="Вставьте ссылку на ваш GitHub репозиторий (Ctrl+V) и нажмите Enter: "
if "%REPO_URL%"=="" (
    echo Ошибка: ссылка не может быть пустой!
    pause
    exit /b
)

echo.
set /p USER_NAME="Введите ваше имя или никнейм для Git (например, Alikhan): "
set /p USER_EMAIL="Введите ваш email для Git (например, alikhan@example.com): "

git config user.name "%USER_NAME%"
git config user.email "%USER_EMAIL%"

echo.
echo Добавление файлов и создание коммита...
git add .
git commit -m "feat: initial commit with CI/CD"

echo.
echo Настройка ветки main и привязка к GitHub...
git branch -M main
git remote remove origin 2>nul
git remote add origin %REPO_URL%

echo.
echo Отправка на GitHub...
git push -u origin main

if %ERRORLEVEL% equ 0 (
    echo.
    echo ========================================================
    echo   УСПЕХ! Проект отправлен на GitHub!
    echo ========================================================
    echo.
    echo Теперь осталось только включить GitHub Pages:
    echo 1. Откройте репозиторий на сайте GitHub
    echo 2. Зайдите в Settings -^> Pages
    echo 3. В 'Source' выберите 'GitHub Actions'
    echo.
) else (
    echo.
    echo [!] Произошла ошибка при отправке. Проверьте ссылку и авторизацию.
)

pause
