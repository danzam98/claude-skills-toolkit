@echo off
setlocal enabledelayedexpansion

REM Claude Skills Toolkit Installer (Windows)

set "SKILLS_DIR=%USERPROFILE%\.claude\skills"
set "SOURCE_DIR=%~dp0skills"
set "FORCE=0"
set "INSTALL_ALL=0"
set "SKILL_COUNT=0"

REM Parse arguments
:parse_args
if "%~1"=="" goto :done_args
if /i "%~1"=="--all" set "INSTALL_ALL=1" & shift & goto :parse_args
if /i "%~1"=="-a" set "INSTALL_ALL=1" & shift & goto :parse_args
if /i "%~1"=="--force" set "FORCE=1" & shift & goto :parse_args
if /i "%~1"=="-f" set "FORCE=1" & shift & goto :parse_args
if /i "%~1"=="--list" goto :list_skills
if /i "%~1"=="-l" goto :list_skills
if /i "%~1"=="--help" goto :show_help
if /i "%~1"=="-h" goto :show_help
REM It's a skill name
set /a SKILL_COUNT+=1
set "SKILL_%SKILL_COUNT%=%~1"
shift
goto :parse_args

:done_args

REM If no skills specified, default to all
if %SKILL_COUNT%==0 set "INSTALL_ALL=1"

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

if "%INSTALL_ALL%"=="1" (
  echo Installing all skills...
  echo.
  for /d %%s in ("%SOURCE_DIR%\*") do (
    call :install_skill "%%s" "%%~nxs"
  )
) else (
  echo Installing selected skills...
  echo.
  for /l %%i in (1,1,%SKILL_COUNT%) do (
    call set "SKILL_NAME=%%SKILL_%%i%%"
    call :install_skill "%SOURCE_DIR%\!SKILL_NAME!" "!SKILL_NAME!"
  )
)

goto :summary

:install_skill
set "SKILL_DIR=%~1"
set "SKILL_NAME=%~2"
set "TARGET_DIR=%SKILLS_DIR%\%SKILL_NAME%"

if not exist "%SKILL_DIR%" (
  echo   Error: Skill '%SKILL_NAME%' not found
  exit /b 1
)

if exist "%TARGET_DIR%" (
  if "%FORCE%"=="1" (
    rmdir /s /q "%TARGET_DIR%"
    xcopy /e /i /q "%SKILL_DIR%" "%TARGET_DIR%" > nul
    echo   ~ %SKILL_NAME% (overwritten)
    set /a OVERWRITTEN_COUNT+=1
  ) else (
    set /p "RESPONSE=Skill '%SKILL_NAME%' already exists. Overwrite? [y/N] "
    if /i "!RESPONSE!"=="y" (
      rmdir /s /q "%TARGET_DIR%"
      xcopy /e /i /q "%SKILL_DIR%" "%TARGET_DIR%" > nul
      echo   ~ %SKILL_NAME% (overwritten)
      set /a OVERWRITTEN_COUNT+=1
    ) else (
      echo   - %SKILL_NAME% (skipped)
      set /a SKIPPED_COUNT+=1
    )
  )
) else (
  xcopy /e /i /q "%SKILL_DIR%" "%TARGET_DIR%" > nul
  echo   + %SKILL_NAME%
  set /a INSTALLED_COUNT+=1
)
exit /b 0

:summary
echo.
echo Installation Summary
echo ====================
echo Installed: %INSTALLED_COUNT%
echo Overwritten: %OVERWRITTEN_COUNT%
echo Skipped: %SKIPPED_COUNT%
echo.
echo Skills installed to: %SKILLS_DIR%
echo.
echo Usage: /skill-name (e.g., /fresh-eyes, /bug-hunt)
echo Restart Claude Code to load the new skills.
echo.
pause
exit /b 0

:list_skills
echo Available skills:
for /d %%s in ("%SOURCE_DIR%\*") do (
  echo   - %%~nxs
)
exit /b 0

:show_help
echo Claude Skills Toolkit Installer
echo.
echo Usage: install.bat [OPTIONS] [SKILL_NAMES...]
echo.
echo Options:
echo   --all, -a       Install all skills (default if no skills specified)
echo   --list, -l      List available skills
echo   --force, -f     Overwrite existing skills without prompting
echo   --help, -h      Show this help message
echo.
echo Examples:
echo   install.bat                     Install all skills (interactive)
echo   install.bat --all --force       Install all skills (overwrite existing)
echo   install.bat fresh-eyes bug-hunt Install specific skills
echo   install.bat -f peer-review      Install specific skill (overwrite if exists)
exit /b 0
