
Dim iURL 
Dim objShell

iURL = "favorites.html"

set objShell = CreateObject("WScript.Shell")
objShell.run(iURL)
