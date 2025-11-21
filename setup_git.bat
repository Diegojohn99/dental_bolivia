@echo off
echo 🚀 Preparando repositorio Git para Dental Bolivia...
echo.

echo 📁 Inicializando repositorio Git...
git init

echo 📝 Añadiendo archivos al repositorio...
git add .

echo 💾 Creando commit inicial...
git commit -m "Initial commit - Sistema Dental Bolivia completo"

echo 🌿 Configurando rama principal...
git branch -M main

echo.
echo ✅ Repositorio Git preparado exitosamente!
echo.
echo 📋 Próximos pasos:
echo 1. Crea un repositorio en GitHub
echo 2. Ejecuta: git remote add origin https://github.com/tu-usuario/dental-bolivia.git
echo 3. Ejecuta: git push -u origin main
echo 4. Ve a render.com y conecta tu repositorio
echo 5. Sigue las instrucciones en README_DEPLOY.md
echo.
pause
