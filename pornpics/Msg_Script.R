system_command <- paste("WScript", '"Msg_Script.vbs"', '"Hello my World, welcome to my graden"', sep = " ")
system(command = system_command, wait = TRUE)
