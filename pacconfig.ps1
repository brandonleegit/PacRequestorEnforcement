# Script to check for the existence of the PacRequestorEnforcement registry key and create it
# It will also allow changing the configured value to reflect the settings defined from Microsoft
# Disable - 0
# Deployment Mode - 1
# Enforcement Mode - 2
# Brandon Lee www.virtualizationhowto.com - v1.0

try { 
         
    Write-Host "Checking the registry for the presence of the PacRequestorEnforcement" -ForegroundColor Yellow 
    $regkeypath = 'HKLM:\SYSTEM\CurrentControlSet\Services\Kdc'
    $valuename = 'PACRequestorEnforcement'
    $check = (Get-ItemProperty $regkeypath).PSObject.Properties.Name -contains $valuename
         
    if ($check -ne $null -and $check -ne 'true') { 
        try { 
             
            Write-Warning "Your Domain Controller does not have the PACRequestorEnforcement Registry Key. Would you like to add it and set value to 1?" -WarningAction Inquire 

            $Name = "PacRequestorEnforcement"

            $value = "1"

            New-ItemProperty -Path $regkeypath -Name $name -Value $value -PropertyType DWORD -Force | Out-Null            
            Write-Host "Your Domain Controller now has the PacRequestorEnforcement registry key" -ForegroundColor Green 

        } 
        catch { 
            Write-Host "You chose not to implement the PacRequestorEnforcement registry key" -ForegroundColor Red 
        } 
    }     
    else { 

        $pacvalue = (Get-ItemProperty -Path $regkeypath -Name $valuename).$valuename 


        Write-Host "Your Domain Controller already has the PacRequestorEnforcement DWORD and is set to $pacvalue" -ForegroundColor Green

        if ($pacvalue -eq "2") {

            Write-Warning "Your Domain Controller has the PacRequestorEnforcement DWORD set to 2. Would you like to set the value back to 1 for audit-only" -WarningAction Inquire
        
            $Name = "PacRequestorEnforcement"

            $value = "1"

            New-ItemProperty -Path $regkeypath -Name $name -Value $value -PropertyType DWORD -Force | Out-Null            
            Write-Host "Your Domain Controller now has the PacRequestorEnforcement DWORD set to 1 - Deployment/Audit mode" -ForegroundColor Green

        }

        if ($pacvalue -eq "1") {

            Write-Warning "Your Domain Controller has the PacRequestorEnforcement DWORD set to 1. Would you like to set the value to 2 for enforcement mode?. Make sure you are doing this consistently across your DCs." -WarningAction Inquire
        
            $Name = "PacRequestorEnforcement"

            $value = "2"

            New-ItemProperty -Path $regkeypath -Name $name -Value $value -PropertyType DWORD -Force | Out-Null            
            Write-Host "Your Domain Controller now has the PacRequestorEnforcement DWORD set to 2 - Enforcement mode" -ForegroundColor Yellow


        }


    }    
    
    
     
} 
         
catch { 
    Write-Host "Error running the script" -ForegroundColor Red 
}