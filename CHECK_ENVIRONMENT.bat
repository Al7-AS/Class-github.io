@echo off
setlocal
chcp 65001 >nul
cd /d "%~dp0"
title ClassMind AI - Environment Check
echo ============================================
echo   فحص بيئة البناء
echo ============================================
where node >nul 2>nul
if errorlevel 1 (echo [فشل] Node.js غير مثبت.) else (echo [موجود] Node.js & node --version)
where npm >nul 2>nul
if errorlevel 1 (echo [فشل] npm غير موجود.) else (echo [موجود] npm & npm --version)
if exist "package.json" (echo [موجود] package.json) else (echo [فشل] package.json غير موجود)
if exist "src\main.js" (echo [موجود] Electron main.js) else (echo [فشل] src\main.js غير موجود)
if exist "src\preload.js" (echo [موجود] preload.js) else (echo [فشل] preload.js غير موجود)
if exist "node_modules\electron\dist\electron.exe" (echo [موجود] Electron Windows binary) else (echo [ناقص] Electron binary - يلزم تثبيت/تجهيز الاعتماديات)
if exist "node_modules\electron-builder\out\cli\cli.js" (echo [موجود] electron-builder) else (echo [ناقص] electron-builder)
if exist "dist" (echo [موجود] مجلد dist & dir /b "dist\*.exe" 2>nul) else (echo [معلومة] لم يتم إنشاء dist بعد)
echo.
echo فحص نحوي لملفات JavaScript إن كان Node متاحاً:
where node >nul 2>nul
if not errorlevel 1 (
  call npm run check
  if errorlevel 1 (echo [فشل] فحص JavaScript.) else (echo [نجاح] فحص JavaScript.)
)
pause
