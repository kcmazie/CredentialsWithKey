<#------------------------------------------------------------------------------ 
         File Name : CredentialsWithKey.ps1 
   Original Author : Kenneth C. Mazie (kcmjr AT kcmjr.com) 
                   : 
       Description : Creates and stores AES encrypted credential file for import into scripts. 
                   : 
             Notes : Normal operation is with no command line options.  
                   : 
         Arguments : Command line options for testing: None                   
                   : 
          Warnings : Although this stores credentials in an encrypted state, a talented hacker can reverse engineer the 
                   : files so be aware there is still a risk in using this method.
                   : 
             Legal : Public Domain. Modify and redistribute freely. No rights reserved. 
                   : SCRIPT PROVIDED "AS IS" WITHOUT WARRANTIES OR GUARANTEES OF 
                   : ANY KIND. USE AT YOUR OWN RISK. NO TECHNICAL SUPPORT PROVIDED. 
                   : That being said, please let me know if you find bugs or improve the script. 
                   : 
           Credits : Code snippets and/or ideas came from many sources including but 
                   : not limited to the following: n/a 
                   : 
    Last Update by : Kenneth C. Mazie 
   Version History : v1.00 - 09-09-17 - Original 
    Change History : v1.10 - 03-02-18 - Minor adjustments.
                   : v1.20 - 05-08-23 - Minor adjustments for publishing.
                   : v1.30 - 02-06-26 - Minor adjustment to file names and location.  Files now 
                   :                    are generated in the same location as the script.    
                   : v0.00 - 00-00-00
                   :  
------------------------------------------------------------------------------#>

#Requires -Version 5.1

Clear-Host 
$PasswordFile = "$PSScriptRoot\AESP.txt"
$KeyFile = "$PSSCriptRoot\AESK.txt"

Function RandomKey {   #-[[ function creates a random byte string of specified length ]--
	$Script:Length = 32 #16,24, or 32
	 $Script:RKey = @()
     For ($i=1; $i -le $Script:Length; $i++) {
     [Byte]$RByte = Get-Random -Minimum 0 -Maximum 256
     $Script:RKey += $RByte
     }
	Return $Script:RKey
}

If ((Test-Path $PasswordFile) -and (Test-Path $KeyFile)){
    Write-host "--[ Detected existing output files.                          ]--" -ForegroundColor Yellow
    Write-Host "--[ Press G to generate new files, or D to decode existing.  ]--" -ForegroundColor Yellow
    Write-host "--[ Any other key exits...                                   ]--" -ForegroundColor Yellow
    $Choice = (Read-Host).ToUpper()
}Else{
    $Choice = "G"
}

If ($Choice -eq "G"){
    Write-host "`n--[ Generating new credential files... ]-----------------" -ForegroundColor White
    #----------[ Creating AES key with random data and export to file ]-------------
    $ByteArray = RandomKey
    #$RndKey = New-Object Byte[] 16   # You can use 16, 24, or 32 for AES
    [Security.Cryptography.RNGCryptoServiceProvider]::Create().GetBytes($ByteArray)
    $Base64String = [System.Convert]::ToBase64String($ByteArray);
    $Base64String | out-file $KeyFile
    $CredPrompt = $Host.ui.PromptForCredential("Credential Creator","Please enter your Domain\UserID and Password.","","")

    $UN = $CredPrompt.GetNetworkCredential().Username
    $DN = $CredPrompt.GetNetworkCredential().Domain
    $PW = $CredPrompt.GetNetworkCredential().Password | ConvertTo-SecureString -AsPlainText -Force

    write-host "UserName Entered                         :"$UN -ForegroundColor Red 
    write-host "Domain Entered                           :"$DN -ForegroundColor Red 
    write-host "Password Entered                         :"$CredPrompt.GetNetworkCredential().Password -ForegroundColor Red 
    write-host "Byte Array length (Bytes)                :"$Length -ForegroundColor Magenta
    write-host "Byte Array (AES Key)                     :"$ByteArray -ForegroundColor Magenta
    Write-Host "Byte Array as base64 string to file      :"$Base64String -ForegroundColor Cyan 

    #-------------[ Creating SecureString object ]----------------------------------
    $Base64String = (Get-Content $KeyFile)
    $ByteArray = [System.Convert]::FromBase64String($Base64String);
    $PW | ConvertFrom-SecureString -key $ByteArray | Out-File $PasswordFile
    Write-Host "AES Encrypted Password to file           :"(Get-Content $PasswordFile) -ForegroundColor Green 
}

If (($Choice -eq "G") -or ($Choice -eq "D")){
    Write-host "`n--[ Decoding credential files... ]-----------------------"-ForegroundColor White
    #------------[ Creating PSCredential object ]-----------------------------------
    $Base64String = (Get-Content $KeyFile)
    $ByteArray = [System.Convert]::FromBase64String($Base64String)
    write-host "Decoded AES Encryption Key               :"$ByteArray -ForegroundColor Magenta

    #------------------[ Decrypted Result ]-----------------------------------------
    $Credential = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $DN"\"$UN, (Get-Content $PasswordFile | ConvertTo-SecureString -Key $ByteArray)
    write-host "Decrypted User ID                        :"$Credential.GetNetworkCredential().Username -ForegroundColor yellow 
    write-host "Decrypted User Domain                    :"$Credential.GetNetworkCredential().Domain -ForegroundColor yellow 
    write-host "Decrypted Password                       :"$Credential.GetNetworkCredential().Password -ForegroundColor yellow 
}

Write-host "`n--[ Coded Files... ]-------------------------------------" -ForegroundColor White
Write-host "Obfuscated key File                      :"$KeyFile -ForegroundColor Green
Write-host "Secured password file                    :"$PasswordFile -ForegroundColor Green
Write-host `n`n"---[ Completed... ]---" -ForegroundColor Red
