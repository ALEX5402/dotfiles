function fish {
    wsl -e fish @args
}

function git {
    wsl git $args
}

# Install-Module -Name PSReadLine -Force -Scope CurrentUser // we have to run this before doing anything to set to install the module for autocomplete and old memory show like zsh
# Force load the newest version of PSReadLine before setting options
Import-Module PSReadLine




# Enable fish-style inline autocomplete based on your history
Set-PSReadLineOption -PredictionSource History
Set-PSReadLineOption -PredictionViewStyle InlineView
