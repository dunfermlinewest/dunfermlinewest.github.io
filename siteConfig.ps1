<# This form was created using POSHGUI.com  a free online gui designer for PowerShell
.NAME
    Slideshow script
#>

Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.Application]::EnableVisualStyles()

#region begin GUI{ 

$SlidesForm                      = New-Object system.Windows.Forms.Form
$SlidesForm.ClientSize           = '495,200'
$SlidesForm.text                 = "Jekyll website config"
$SlidesForm.TopMost              = $false

$label1                          = New-Object system.Windows.Forms.Label
$label1.text                     = "Website folder"
$label1.AutoSize                 = $true
$label1.width                    = 25
$label1.height                   = 10
$label1.location                 = New-Object System.Drawing.Point(19,15)
$label1.Font                     = 'Microsoft Sans Serif,10'

$FileNameTextBox                 = New-Object system.Windows.Forms.TextBox
$FileNameTextBox.multiline       = $false
$FileNameTextBox.width           = 100
$FileNameTextBox.height          = 20
$FileNameTextBox.location        = New-Object System.Drawing.Point(121,10)
$FileNameTextBox.Font            = 'Microsoft Sans Serif,10'

$FileDialogButton                = New-Object system.Windows.Forms.Button
$FileDialogButton.text           = "Choose"
$FileDialogButton.width          = 60
$FileDialogButton.height         = 30
$FileDialogButton.location       = New-Object System.Drawing.Point(238,5)
$FileDialogButton.Font           = 'Microsoft Sans Serif,10'

$labelDescription                          = New-Object system.Windows.Forms.Label
$labelDescription.text                     = "Ready..."
$labelDescription.AutoSize                 = $true
$labelDescription.width                    = 25
$labelDescription.height                   = 10
$labelDescription.location                 = New-Object System.Drawing.Point(19,140)
$labelDescription.Font                     = 'Microsoft Sans Serif,10'

$labelID                          = New-Object system.Windows.Forms.Label
$labelID.text                     = ""
$labelID.AutoSize                 = $true
$labelID.width                    = 25
$labelID.height                   = 10
$labelID.location                 = New-Object System.Drawing.Point(50,140)
$labelID.Font                     = 'Microsoft Sans Serif,10'

$RunButton                       = New-Object system.Windows.Forms.Button
$RunButton.text                  = "Preview Website"
$RunButton.width                 = 200
$RunButton.height                = 30
$RunButton.location              = New-Object System.Drawing.Point(19,160)
$RunButton.Font                  = 'Microsoft Sans Serif,10'

$closeButton                       = New-Object system.Windows.Forms.Button
$closeButton.text                  = "Close Website"
$closeButton.width                 = 200
$closeButton.height                = 30
$closeButton.location              = New-Object System.Drawing.Point(238,160)
$closeButton.Font                  = 'Microsoft Sans Serif,10'


$PortLabel                       = New-Object system.Windows.Forms.Label
$PortLabel.text                  = "Port"
$PortLabel.AutoSize              = $true
$PortLabel.width                 = 25
$PortLabel.height                = 10
$PortLabel.location              = New-Object System.Drawing.Point(72,49)
$PortLabel.Font                  = 'Microsoft Sans Serif,10'

$Portextbox                      = New-Object system.Windows.Forms.TextBox
$Portextbox.multiline            = $false
$Portextbox.text                 = "8000"
$Portextbox.width                = 100
$Portextbox.height               = 20
$Portextbox.location             = New-Object System.Drawing.Point(120,44)
$Portextbox.Font                 = 'Microsoft Sans Serif,10'

$SlidesForm.controls.AddRange(@($label1,$FileNameTextBox,$FileDialogButton, $labelDescription, $labelID, $RunButton, $closeButton, $PortLabel,$Portextbox))

#region gui events {
$FileDialogButton.Add_Click({ $FileNameTextBox.Text = folderChooser  })
$FileNameTextBox.Add_DragEnter({ $FileNameTextBox.Text = fileDropped($_) })
$FileNameTextBox.Add_TextChanged({ 
    Set-Location -Path $FileNameTextBox.Text  
    $dir = Get-Location
    Write-Host "Current Directory changed to " + $dir
})
$RunButton.Add_Click({ startJekyll })
$closeButton.Add_Click({ stopJekyll })
#endregion events }

#endregion GUI }


#Write your logic code here

$FileNameTextBox.Text = Get-Location
$jekyllProcess

function folderChooser() {
    $fileName = "No File" 
    $openFileDialog = New-Object windows.forms.FolderBrowserDialog
    $openFileDialog.SelectedPath = [System.IO.Directory]::GetCurrentDirectory()   
    $OpenFileDialog.ShowDialog() | Out-Null
    return $OpenFileDialog.selectedPath
}

function fileChooser() {
    $fileName = "No File"

    $openFileDialog = New-Object windows.forms.openfiledialog   
    $openFileDialog.initialDirectory = [System.IO.Directory]::GetCurrentDirectory()  
    $openFileDialog.title = "Select slideshow"   
    $openFileDialog.filter = "Markdown|*.md|All Files|*.*" 
    $OpenFileDialog.ShowDialog() | Out-Null
    return $OpenFileDialog.filename
}

function fileDropped($eventdata) {
   foreach ($file in $eventdata.Data.GetFileDropList()){
      return $file
   }
}

function openChrome() {
    $labelDescription.Text = "Opening Chrome"

    $chromePath = "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe"   
    $argumentList = "--app=http:/127.0.0.1:" + $Portextbox.Text
    Start-Process -FilePath $chromePath -ArgumentList $argumentList

    $argumentList = $FileNameTextBox.Text + " -p " + $Portextbox.Text + " -s -c-1"
    Start-Process -FilePath "http-server" -ArgumentList $argumentList -Wait -NoNewWindow

    [void]$SlidesForm.Close()
}

function startJekyll() {
    $argumentList = "exec Jekyll serve --port " + $Portextbox.Text
    Write-Host "Starting Jekyl with arguments " + $argumentList

    #$jekyllProcess = (Start-Process -FilePath "bundle " -ArgumentList $argumentList -PassThru).id
    $jekyllProcess = (Start-Process -FilePath "bundle " -ArgumentList $argumentList -PassThru -NoNewWindow).id

    Write-Host "Process ID " + $jekyllProcess

    $labelDescription.Text = "Loading your website at process "
    $labelID.Text = $jekyllProcess

    $chromePath = "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe"   
    $argumentList = "http:/127.0.0.1:" + $Portextbox.Text
    Start-Process -FilePath $chromePath -ArgumentList $argumentList
    #Add-Type -AssemblyName Microsoft.VisualBasic 
    #[Microsoft.VisualBasic.Interaction]::AppActivate([Int32]$ID)
    #[System.Windows.Forms.SendKeys]::SendWait("YES~")
    #[System.Windows.Forms.SendKeys]::SendWait("myuid~")
    #[System.Windows.Forms.SendKeys]::SendWait("SuperSecretPassword~")

    #[void]$SlidesForm.Close()
}

function stopJekyll() {
    $labelDescription.Text = "Stopping your website "
    Stop-Process -Id $labelID.Text
    $labelID.Text = ""
    
}

[void]$SlidesForm.ShowDialog()