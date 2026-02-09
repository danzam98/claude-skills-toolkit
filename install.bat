@echo off
setlocal enabledelayedexpansion

REM Claude Skills Toolkit Installer (Windows)

set "SKILLS_DIR=%USERPROFILE%\.claude\skills"
set "SOURCE_DIR=%~dp0skills"

echo Claude Skills Toolkit Installer
echo ================================
echo.

REM Create skills directory if it doesn't exist
if not exist "%SKILLS_DIR%" (
  echo Creating %SKILLS_DIR%...
  mkdir "%SKILLS_DIR%"
)

REM Track installation results
set INSTALLED_COUNT=0
set SKIPPED_COUNT=0
set OVERWRITTEN_COUNT=0

REM Install each skill
for /d %%s in ("%SOURCE_DIR%\*") do (
  set "SKILL_NAME=%%~nxs"
  set "TARGET_DIR=%SKILLS_DIR%\%%~nxs"

  if exist "!TARGET_DIR!" (
    REM Skill already exists - ask user
    set /p "RESPONSE=Skill '!SKILL_NAME!' already exists. Overwrite? [y/N] "
    if /i "!RESPONSE!"=="y" (
      rmdir /s /q "!TARGET_DIR!"
      xcopy /e /i /q "%%s" "!TARGET_DIR!" > nul
      echo   Overwritten: !SKILL_NAME!
      set /a OVERWRITTEN_COUNT+=1
    ) else (
      echo   Skipped: !SKILL_NAME!
      set /a SKIPPED_COUNT+=1
    )
  ) else (
    REM New installation
    xcopy /e /i /q "%%s" "!TARGET_DIR!" > nul
    echo   Installed: !SKILL_NAME!
    set /a INSTALLED_COUNT+=1
  )
)

echo.
echo Installation Summary
echo ====================
echo Installed: !INSTALLED_COUNT!
echo Overwritten: !OVERWRITTEN_COUNT!
echo Skipped: !SKIPPED_COUNT!
echo.
echo Skills installed to: %SKILLS_DIR%
echo.
echo Usage: /skill-name (e.g., /fresh-eyes, /bug-hunt)
echo Restart Claude Code to load the new skills.
echo.
pause
