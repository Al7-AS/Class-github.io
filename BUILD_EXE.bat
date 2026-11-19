@echo off
setlocal
chcp 65001 >nul
cd /d "%~dp0"
title ClassMind AI - Build Windows EXE
echo ============================================
echo   ClassMind AI - بناء نسخة Windows
echo ============================================
where node >nul 2>nul
if errorlevel 1 (echo [خطأ] Node.js غير موجود. & pause & exit /b 1)
if not exist "node_modules\electron\dist\electron.exe" (
  echo [خطأ] ملفات Electron غير موجودة داخل node_modules.
  echo شغّل INSTALL_DEPENDENCIES.bat أثناء توفر الإنترنت أولاً.
  pause
  exit /b 1
)
if not exist "node_modules\electron-builder\out\cli\cli.js" (
  echo [خطأ] electron-builder غير مثبت بالكامل.
  echo شغّل INSTALL_DEPENDENCIES.bat أثناء توفر الإنترنت أولاً.
  pause
  exit /b 1
)
call npm run check
if errorlevel 1 (echo [خطأ] فشل فحص الكود. & pause & exit /b 1)
echo.
echo [1/2] بناء EXE محمول + مثبت Windows (x64)...
call npm run build:win:both
if errorlevel 1 (
  echo.
  echo [خطأ] فشل البناء. إذا ظهر خطأ تنزيل، فقد تكون أدوات NSIS أو winCodeSign غير مخزنة.
  echo اتصل بالإنترنت وشغّل PREPARE_OFFLINE.bat ثم أعد المحاولة دون إنترنت.
  pause
  exit /b 1
)
if not exist "dist\ClassMind-AI-7.2.0-Portable.exe" (
  echo [تحذير] لم يظهر اسم الملف المحمول المتوقع؛ افحص مجلد dist.
)
if not exist "dist" (echo [خطأ] مجلد dist غير موجود بعد البناء. & pause & exit /b 1)
echo.
echo [نجاح] انتهت عملية البناء. افحص ملفات EXE داخل:
echo "%~dp0dist"
dir /b "dist\*.exe" 2>nul
pause
exit /b 0
