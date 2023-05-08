# CredentialsWithKey
Creates and stores AES encrypted credential file for import into scripts.

The script has two functions.  First it prompts for admin user credentials and generates a random key.
The credentials are then encrypted using the key as a salt and AES encryption.  The key and encrypted
credential are both stored in text file in the script local folder (this can be changed).  It's recommended that
the file names be altered and stored in different location.  Once created the credentials can be called
by scripts requiring admin credentials.  Using this method you can set all your scripts to automatically 
run using the stored credentials without prompting.  If the files already exist the script will decrypt 
them when prompted and display the results on screen.
