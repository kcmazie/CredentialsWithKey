<!---
<head>
<meta name="google-site-verification" content="SiI2B_QvkFxrKW8YNvNf7w7gTIhzZsP9-yemxArYWwI" />
</head>
-->
[![Minimum Supported PowerShell Version][powershell-minimum]][powershell-github]&nbsp;&nbsp;
[![GPLv3 license](https://img.shields.io/badge/License-GPLv3-blue.svg)](http://perso.crans.org/besson/LICENSE.html)&nbsp;&nbsp;
[![made-with-VSCode](https://img.shields.io/badge/Made%20with-VSCode-1f425f.svg)](https://code.visualstudio.com/)&nbsp;&nbsp;
![GitHub watchers](https://img.shields.io/github/watchers/kcmazie/Cisco-Device-Inventory?style=plastic)

[powershell-minimum]: https://img.shields.io/badge/PowerShell-5.1+-blue.svg 
[powershell-github]:  https://github.com/PowerShell/PowerShell
<span style="background-color:black">
# $${\color{Cyan}Powershell \space "CredentialsWithKey.ps1"}$$

#### $${\color{orange}Original \space Author \space : \space \color{white}Kenneth \space C. \space Mazie \space \color{lightblue}(kcmjr \space AT \space kcmjr.com)}$$

## $${\color{grey}Description:}$$ 
Creates and stores AES encrypted credential files for import into scripts.  This script has two functions.  First it prompts for admin user credentials and generates a random key.
The credentials are then encrypted using the key as a salt and AES encryption.  The key and encrypted
credential are both stored in text file in the script local folder (this can be changed).  It's recommended that
the file names be altered and stored in different location.  Once created the credentials can be called
by scripts requiring admin credentials.  Using this method you can set all your scripts to automatically 
run using the stored credentials without prompting.  If the files already exist the script will decrypt 
them when prompted and display the results on screen.

## $${\color{grey}Notes:}$$ 
* Normal operation is with no command line options.
* Powershell 5.1 is the minimal version required.

## $${\color{grey}Arguments:}$$ 
Command line options for testing: 
* None
 
### $${\color{grey}Screenshots:}$$ 
[Screen Output](https://github.com/kcmazie/CredentialWithKey/blob/main/Screen1.jpg "Screen Output")

### $${\color{grey}Warnings:}$$ 
* NOTE!!!  This is basic obfuscation.  Anyone with experieince with PowerShell might be able to recover the credentials.  This is mainly to keep passwords out of clear text.

### $${\color{grey}Enhancements:}$$ 
Some possible future enhancements are:
* None at this time

### $${\color{grey}Legal:}$$ 
Public Domain. Modify and redistribute freely. No rights reserved. 
SCRIPT PROVIDED "AS IS" WITHOUT WARRANTIES OR GUARANTEES OF ANY KIND. USE AT YOUR OWN RISK. NO TECHNICAL SUPPORT PROVIDED.

That being said, please let me know if you find bugs, have improved the script, or would like to help. 

### $${\color{grey}Credits:}$$  
Code snippets and/or ideas came from many sources including but not limited to the following: 
* Code snippets and/or ideas came from too many sources to list...
  
### $${\color{grey}Version \\& Change History:}$$ 
* Last Update by  : Kenneth C. Mazie 
  * Initial Release : v1.00 - 09-09-17 - Original release
  * Change History  : v1.10 - 03-02-18 - Minor adjustments.
                    : v1.20 - 05-08-23 - Minor adjustments for publishing. 
 </span>
