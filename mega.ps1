#Env
$env:FZF_DEFAULT_COMMAND = "rg --files --hidden"

#Color options
Set-PSReadLineOption -Colors @{ 
    Operator = 'Red'
    Parameter = 'Yellow' 
}

#Utility
function la {
    Get-ChildItem -Force @args
}

function fg {
    param(
        [string]$query
    )

    if (-not $query) {
        $query = Read-Host "Search text"
    }

    rg --line-number --no-heading --color=always --hidden --follow --glob "!.git/*" $query |
        fzf --ansi --delimiter : --preview 'rg --color=always -C 5 ".*" {1} | more' --preview-window 'up:60%:wrap'
}

#Navigation
function ch {
    cd $HOME
}

function nh {
    Set-Location "C:\Users\blooper\AppData\Local\nvim"
}

function l4 {
    Set-Location "C:\Users\blooper\Link4"
    nvim
}

function c {
& 'C:\Program Files\Google\Chrome\Application\chrome.exe'
}

#PS config
function src {
    . $PROFILE
}

function prof {
    nvim $PROFILE
}

#Alias
Set-Alias ff fzf
Set-Alias lg lazygit
