<#
.Synopsis
   Create a crypted password file securely.
.DESCRIPTION
   This script prompts the user for credentials and saves the encrypted password to the specified file path.
   It is intended for use in automation where elevated credentials are required.
.EXAMPLE
   New-CryptedPasswordFile -Filepath .\CryptedPasswordfilename.txt
.NOTES

        ===========================================================================
        Created with:     SAPIEN Technologies, Inc., PowerShell Studio 2021 v5.8.183
        Created on:       1/27/2021 10:35 AM
        Updated on:       4/14/2025
        Created by:       Christian Damberg, Sebastian Thörngren
        Updated by:       Christian Damberg
        Organization:     Cygate AB
        Filename:         New-CryptedPasswordFile.ps1
        ===========================================================================
#>
function New-CryptedPasswordFile
{
    [CmdletBinding()]
    [Alias()]
    [OutputType([void])]
    Param
    (
        # Path to save the crypted password file
        [Parameter(Mandatory=$true,
                   ValueFromPipelineByPropertyName=$true,
                   Position=0)]
        [ValidateNotNullOrEmpty()]
        [string]$Filepath
    )

    Begin
    {
        # Log the start of the operation
        Write-Verbose "Starting the New-CryptedPasswordFile function."
    }
    Process
    {
        try {
            # Prompt the user for credentials
            $credential = Get-Credential

            # Validate output path
            if (!(Test-Path -Path (Split-Path -Path $Filepath -Parent))) {
                throw "The directory for the file path '$Filepath' does not exist."
            }

            # Encrypt the password and save it to the specified file
            $credential.Password | ConvertFrom-SecureString | Set-Content -Path $Filepath -Force

            # Log success
            Write-Verbose "Encrypted password successfully saved to $Filepath."

        } catch {
            # Handle errors gracefully
            Write-Error "An error occurred: $_"
        }
    }
    End
    {
        # Log the end of the operation
        Write-Verbose "Completed the New-CryptedPasswordFile function."
    }
}

# Example Usage
# Uncomment the following line to test the function
# New-CryptedPasswordFile -Filepath .\CryptedPasswordfilename.txt
