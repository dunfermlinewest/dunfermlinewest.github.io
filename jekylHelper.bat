powershell -noprofile -command "&{ start-process powershell -ArgumentList '-noprofile -file %CD%\siteConfig.ps1' -verb RunAs}"
