SET deploydir=D:\Dokumente\Promotion\code\modelica-deploy\SHM
if exist %deploydir% del /s /q %deploydir%
xcopy /E /Y ..\SHM %deploydir%