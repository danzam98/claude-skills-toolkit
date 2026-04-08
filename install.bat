@echo off
setlocal enabledelayedexpansion

REM Claude + Codex Skills Toolkit Installer (Windows)
REM
REM Installs skills to Claude Code (%USERPROFILE%\.claude\skills) and/or
REM Codex CLI (%USERPROFILE%\.codex\skills). Both CLIs use the same SKILL.md
REM directory format, so the same source files work in both.

set "CLAUDE_SKILLS_DIR=%USERPROFILE%\.claude\skills"
set "CODEX_SKILLS_DIR=%USERPROFILE%\.codex\skills"
set "SOURCE_DIR=%~dp0skills"
set "FORCE=0"
set "INSTALL_ALL=0"
set "SKILL_COUNT=0"
set "TARGET_CHOICE=both"

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
if /i "%~1"=="--target" set "TARGET_CHOICE=%~2" & shift & shift & goto :parse_args
if /i "%~1"=="--target=claude" set "TARGET_CHOICE=claude" & shift & goto :parse_args
if /i "%~1"=="--target=codex" set "TARGET_CHOICE=codex" & shift & goto :parse_args
if /i "%~1"=="--target=both" set "TARGET_CHOICE=both" & shift & goto :parse_args
REM It's a skill name
set /a SKILL_COUNT+=1
set "SKILL_%SKILL_COUNT%=%~1"
shift
goto :parse_args

:done_args

REM Resolve target list
set "USE_CLAUDE=0"
set "USE_CODEX=0"
if /i "%TARGET_CHOICE%"=="claude" set "USE_CLAUDE=1"
if /i "%TARGET_CHOICE%"=="codex" set "USE_CODEX=1"
if /i "%TARGET_CHOICE%"=="both" set "USE_CLAUDE=1" & set "USE_CODEX=1"
if "%USE_CLAUDE%"=="0" if "%USE_CODEX%"=="0" (
  echo Error: --target must be one of: claude, codex, both
  exit /b 1
)

REM If no skills specified, default to all
if %SKILL_COUNT%==0 set "INSTALL_ALL=1"

echo Claude + Codex Skills Toolkit Installer
echo ========================================
set "TARGET_LABEL="
if "%USE_CLAUDE%"=="1" set "TARGET_LABEL=!TARGET_LABEL! claude"
if "%USE_CODEX%"=="1" set "TARGET_LABEL=!TARGET_LABEL! codex"
echo Targets:!TARGET_LABEL!
echo.

REM Create needed target dirs
if "%USE_CLAUDE%"=="1" if not exist "%CLAUDE_SKILLS_DIR%" mkdir "%CLAUDE_SKILLS_DIR%"
if "%USE_CODEX%"=="1" if not exist "%CODEX_SKILLS_DIR%" mkdir "%CODEX_SKILLS_DIR%"

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
if not exist "%SKILL_DIR%" (
  echo   Error: Skill '%SKILL_NAME%' not found
  exit /b 1
)
if "%USE_CLAUDE%"=="1" call :install_to_target "%SKILL_DIR%" "%SKILL_NAME%" "%CLAUDE_SKILLS_DIR%" "claude"
if "%USE_CODEX%"=="1" call :install_to_target "%SKILL_DIR%" "%SKILL_NAME%" "%CODEX_SKILLS_DIR%" "codex"
exit /b 0

:install_to_target
set "_SKILL_DIR=%~1"
set "_SKILL_NAME=%~2"
set "_TARGET_ROOT=%~3"
set "_TARGET_LABEL=%~4"
set "_TARGET_DIR=%_TARGET_ROOT%\%_SKILL_NAME%"

if exist "%_TARGET_DIR%" (
  if "%FORCE%"=="1" (
    rmdir /s /q "%_TARGET_DIR%"
    xcopy /e /i /q "%_SKILL_DIR%" "%_TARGET_DIR%" > nul
    echo   ~ %_SKILL_NAME% [%_TARGET_LABEL%] (overwritten)
    set /a OVERWRITTEN_COUNT+=1
  ) else (
    set /p "RESPONSE=Skill '%_SKILL_NAME%' already exists in %_TARGET_LABEL%. Overwrite? [y/N] "
    if /i "!RESPONSE!"=="y" (
      rmdir /s /q "%_TARGET_DIR%"
      xcopy /e /i /q "%_SKILL_DIR%" "%_TARGET_DIR%" > nul
      echo   ~ %_SKILL_NAME% [%_TARGET_LABEL%] (overwritten)
      set /a OVERWRITTEN_COUNT+=1
    ) else (
      echo   - %_SKILL_NAME% [%_TARGET_LABEL%] (skipped)
      set /a SKIPPED_COUNT+=1
    )
  )
) else (
  xcopy /e /i /q "%_SKILL_DIR%" "%_TARGET_DIR%" > nul
  echo   + %_SKILL_NAME% [%_TARGET_LABEL%]
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
if "%USE_CLAUDE%"=="1" echo Claude Code skills: %CLAUDE_SKILLS_DIR%
if "%USE_CODEX%"=="1" echo Codex CLI skills:   %CODEX_SKILLS_DIR%
echo.
echo Usage: /skill-name (e.g., /fresh-eyes, /bug-hunt)
echo Restart Claude Code or Codex CLI to load the new skills.
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
echo Claude + Codex Skills Toolkit Installer
echo.
echo Usage: install.bat [OPTIONS] [SKILL_NAMES...]
echo.
echo Options:
echo   --all, -a              Install all skills (default if no skills specified)
echo   --list, -l             List available skills
echo   --force, -f            Overwrite existing skills without prompting
echo   --target TARGET        Where to install: claude, codex, or both (default: both)
echo   --help, -h             Show this help message
echo.
echo Examples:
echo   install.bat                                Install all skills to Claude + Codex
echo   install.bat --all --force                  Install all, overwrite existing
echo   install.bat --target=claude fresh-eyes     Install only to Claude Code
echo   install.bat --target=codex bug-hunt        Install only to Codex CLI
echo   install.bat -f peer-review                 Install with overwrite
exit /b 0
