@echo off
setlocal
chcp 65001 >nul
cd /d "%~dp0"
title ClassMind AI - Prepare Offline Build
echo ===================================================
echo تجهيز ذاكرة الاعتماديات للبناء دون إنترنت لاحقاً
echo ===================================================
where node >nul 2>nul
if errorlevel 1 (echo [خطأ] ثبّت Node.js 22 LTS x64 أولاً. & pause & exit /b 1)
echo هذه الخطوة تحتاج اتصال إنترنت.
call npm install
if errorlevel 1 (echo [خطأ] فشل npm install. & pause & exit /b 1)
call npm run check
if errorlevel 1 (echo [خطأ] فشل فحص الكود. & pause & exit /b 1)
echo.
echo الآن سيجري بناء النسختين مرة واحدة لتحميل أدوات البناء الإضافية وتخزينها مؤقتاً.
echo هذا يساعد على البناء دون إنترنت لاحقاً على نفس جهاز Windows وبنفس المستخدم.
call npm run build:win:both
if errorlevel 1 (
  echo [تنبيه] لم يكتمل البناء التحضيري. قد تكون بعض أدوات البناء لم تُنزّل.
  echo أعد تشغيل هذا الملف مع الإنترنت حتى ينجح البناء بالكامل.
  pause
  exit /b 1
)
echo.
echo [نجاح] اكتمل البناء التحضيري. احتفظ بالمجلد كاملاً بما فيه node_modules وذاكرة npm.
echo ملاحظة مهمة: Node.js نفسه غير مرفق بهذه الحزمة، كما أن ذاكرة الأدوات قد تختلف بين الأجهزة.
echo لا تحذف node_modules ولا مجلدات كاش electron-builder إذا كنت تريد إعادة البناء دون إنترنت.
pause
exit /b 0
