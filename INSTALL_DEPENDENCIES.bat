@echo off
setlocal
chcp 65001 >nul
cd /d "%~dp0"
title ClassMind AI - Install Dependencies
echo ============================================
echo   ClassMind AI - تجهيز الاعتماديات
echo ============================================
where node >nul 2>nul
if errorlevel 1 (
  echo [خطأ] Node.js غير موجود. ثبّت Node.js 22 LTS x64 أولاً.
  echo يمكن تنزيله من الموقع الرسمي: https://nodejs.org/
  pause
  exit /b 1
)
where npm >nul 2>nul
if errorlevel 1 (
  echo [خطأ] npm غير موجود ضمن PATH. أعد تثبيت Node.js مع npm.
  pause
  exit /b 1
)
node --version
npm --version
echo.
echo سيتم تثبيت الإصدارات المحددة في package.json.
echo هذه الخطوة تحتاج اتصالاً بالإنترنت أول مرة، ما لم تكن ذاكرة npm المؤقتة مكتملة.
call npm install
if errorlevel 1 (
  echo [خطأ] فشل npm install. راجع الاتصال ورسالة الخطأ أعلاه.
  pause
  exit /b 1
)
call npm run check
if errorlevel 1 (
  echo [خطأ] فشل فحص ملفات JavaScript.
  pause
  exit /b 1
)
echo.
echo [نجاح] تم تثبيت الاعتماديات وفحص ملفات المشروع.
echo ملاحظة: هذا لا يضمن وحده أن جميع أدوات بناء Windows أصبحت مخزنة للعمل دون إنترنت.
pause
exit /b 0
