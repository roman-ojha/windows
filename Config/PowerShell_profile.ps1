# Install added modules Then 'Import-Module' into Microsoft.PowerShell_profile.ps1
# Some references: https://www.jondjones.com/tactics/productivity/customise-your-powershell-prompt-like-a-boss/#:~:text=Customise%20Your%20Powershell%20Prompt%20Like%20A%20Boss%201,Status%20Info%20...%205%20Prettify%20The%20Terminal%20

# oh-my-posh init pwsh --config ~\AppData\Local\Programs\oh-my-posh\themes\craver.omp.json | Invoke-Expression
# oh-my-posh init pwsh --config ~\AppData\Local\Programs\oh-my-posh\themes\json.omp.json | Invoke-Expression
# oh-my-posh init pwsh --config ~\AppData\Local\Programs\oh-my-posh\themes\marcduiker.omp.json | Invoke-Expression
oh-my-posh init pwsh --config ~\AppData\Local\Programs\oh-my-posh\themes\emodipt-extend.omp.json | Invoke-Expression

Import-Module posh-git

# Alias
# Now we can use 'vim' command as well to run neovim
Set-Alias -Name vim -Value nvim
Set-Alias g git
Set-Alias lg lazygit

# Terminal Icon plugin
Import-Module -Name Terminal-Icons

# Fuzzy finder plugin: https://github.com/junegunn/fzf
# Export 'FZF_DEFAULT_OPTS' to set the default options
$env:FZF_DEFAULT_OPTS = '--height 60% --layout=reverse --border --preview "bat --color=always --style=header,grid --line-range :500 {}"'

# Bat Plugin: https://github.com/sharkdp/bat


if ($host.Name -eq 'ConsoleHost' -or $host.Name -eq 'Visual Studio Code Host' ) {

  Import-Module PSReadline
  Set-PSReadLineOption -EditMode Windows
  Set-PSReadLineOption -PredictionSource History

  Set-PSReadlineOption -Color @{
    "Command"          = [ConsoleColor]::Green
    "Parameter"        = [ConsoleColor]::Gray
    "Operator"         = [ConsoleColor]::Magenta
    "Variable"         = [ConsoleColor]::Yellow
    "String"           = [ConsoleColor]::Yellow
    "Number"           = [ConsoleColor]::Yellow
    "Type"             = [ConsoleColor]::Cyan
    "Comment"          = [ConsoleColor]::DarkCyan
    "InlinePrediction" = '#70A99F'
  }

  Set-PSReadLineKeyHandler -Function AcceptSuggestion -Key 'Ctrl+Spacebar'
  Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward
  Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward 

  Set-PSReadLineKeyHandler -Key Ctrl+Shift+b `
                       -BriefDescription BuildCurrentDirectory `
                       -LongDescription "Build the current directory" `
                       -ScriptBlock {
    [Microsoft.PowerShell.PSConsoleReadLine]::RevertLine()
    [Microsoft.PowerShell.PSConsoleReadLine]::Insert("dotnet build")
    [Microsoft.PowerShell.PSConsoleReadLine]::AcceptLine()
  }
}

