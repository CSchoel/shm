SET deploydir=D:\Dokumente\Promotion\code\modelica-deploy\SHM
if exist %deploydir% del %deploydir%
xcopy /E ..\SHM %deploydir%