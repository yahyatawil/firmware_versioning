:: Autohr: Yahya Tawil
:: How to use:
:: Add this file to you Arduino project directory and add the following line to platform.txt from Arduino core files
:: recipe.hooks.sketch.prebuild.1.pattern = {build.source.path}\fw_ver.bat GIT {build.path} {build.source.path}
:: recipe.hooks.savehex.postsavehex.2.pattern = {build.source.path}\fw_ver.bat SAVE {build.path} {build.source.path}

@echo off

:: arg1 -> "GIT" print version, commit number, brnach name and commit date , "SAVE" copy the .hex file from temp build directory to project directory
set arg1=%1
:: arg2 -> path to temp build directory
set arg2=%2
:: arg3 -> path to project source files
set arg3=%3

cd %arg3%

FOR /F "tokens=* USEBACKQ" %%F IN (`git describe --match^=NeVeRmAtCh --always --abbrev^=7`) DO (
SET commit=%%F
)

FOR /F "tokens=* USEBACKQ" %%F IN (`git show -s --format^=%%cd --date^=format:%%y_%%m_%%d %commit%`) DO (
SET date=%%F
)

FOR /F "tokens=* USEBACKQ" %%F IN (`git rev-parse --abbrev-ref HEAD`) DO (
SET branch=%%F
)

FOR /F "tokens=* USEBACKQ" %%F IN (`git describe --abbrev^=0`) DO (
SET ver=%%F
)
::Export to version.h
ECHO #define FW_VER "%ver%" > version.h
ECHO #define COMMIT_NUMBER "%commit%" >> version.h
ECHO #define COMMIT_DATE "%date%" >> version.h
ECHO #define COMMIT_BRANCH "%branch%" >> version.h

IF "%arg1%"=="GIT" (
@echo on
@echo version:%ver% Commit:%commit% Branch:%branch% Date:%date% 
@echo off
)


IF "%arg1%"=="SAVE" (
@echo on
@echo Save fw_%ver%_%branch%_%date%_%commit%.hex to %arg3%
COPY "%arg2%\fw.ino.hex" "fw_%ver%_%branch%_%date%_%commit%.hex"
)