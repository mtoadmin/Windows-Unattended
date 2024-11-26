copy RunAsTool_x64.exe %TEMP%
copy RunAsTool.ini %TEMP%
copy import.rnt %TEMP%


%TEMP%\RunAsTool_x64.exe /U=Admin /P=password /I=%TEMP%\Import.rnt

timeout /t 20

del %TEMP%\RunAsTool_x64.exe 
del %TEMP%\RunAsTool.ini 
del %TEMP%\import.rnt 
