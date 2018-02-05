@echo off

set "CURRENT_DIR=%~dp0"
cd %CURRENT_DIR%

echo %CURRENT_DIR%
if not exist "var" (
	mkdir var
)

set pidfile=var/app.pid
set logfile=var/app.log

set class_path=.;%JAVA_HOME%\lib\dt.jar;%JAVA_HOME%\lib\tools.jar;classes;@project.build.finalName@.jar
java -version
echo classpath  %class_path%

:start
java -classpath "%class_path%"@project.groupId@.Application > %logfile%

:end