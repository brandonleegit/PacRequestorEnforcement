# PacRequestorEnforcement Registry key with PowerShell

PowerShell script to automatically create the PacRequestorEnforcement registry key and configure the DWORD value using the following settings:

- Deployment Mode - DWORD value is set to 1
- Enforcement Mode - DWORD value is set to 2

## Instructions

Run the script from your domain controller and answer the prompts. It will first check to see if the DWORD value exists and will create the DWORD entry with a value of 1. If the script is ran again, it will read the current value of the DWORD and allow the administrator to change the value from either a 1 to 2 or from 2 to 1.
