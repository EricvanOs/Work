Function Show-MachineInfo {
    [cmdletbinding()]
    [alias("smi")]
    Param(
    [Parameter(Position = 0)]
    [Alias("cn")]
    [ValidateNotNullorEmpty()]
    [string]$Computername = $env:COMPUTERNAME
    )
    $form = New-Object System.Windows.Window
    $form.Title = "TMMachine Info"
    $form.Width = 300
    $form.Height = 350
    $stack = New-Object System.Windows.Controls.StackPanel
    $txtInput = New-Object System.Windows.Controls.TextBox
    $txtInput.Width = 100
    $txtInput.HorizontalAlignment = "left"
    $txtInput.Text = $Computername
    $stack.AddChild($txtInput)
    $txtResults = New-Object System.Windows.Controls.TextBlock
    $txtResults.FontFamily = "Consolas"
    $txtResults.HorizontalAlignment = "left"
    $txtResults.Height = 200
    $stack.AddChild($txtResults)
    $btnRun = New-Object System.Windows.Controls.Button
    $btnRun.Content = "_Run"
    $btnRun.Width = 60
    $btnRun.HorizontalAlignment = "Center"
    $OK = {
    #get machine info from the name in the text box.
    #we're trimming the value in case there are extra spaces
    $data = Get-MachineInfo -Computername ($txtInput.text).trim()
    #set the value of the txtResults to the data as a string
    $txtResults.text = $data | Out-String
    }
    $btnRun.Add_click($OK)
    $stack.AddChild($btnRun)
    $btnQuit = New-Object System.Windows.Controls.Button
    $btnQuit.Content = "_Quit"
    $btnQuit.Width = 60
    $btnQuit.HorizontalAlignment = "center"
    $btnQuit.Add_click({$form.close()})
    $stack.AddChild($btnQuit)
    $form.AddChild($stack)
    $form.add_Loaded($ok)
    [void]($form.ShowDialog())
    }
    
    
    Show-MachineInfo -Computername Mnemosyne