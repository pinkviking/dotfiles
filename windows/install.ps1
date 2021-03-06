if ( ! (Test-Path ".\install.ps1" )) {
	echo "Run script in inside 'dotfiles/windows' directory"
	exit 1
}

if ( ! (Test-Path "~\AppData\Local\nvim\autoload\plug.vim"))
{
    $null = md ~\AppData\Local\nvim\autoload
    $uri = 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    (New-Object Net.WebClient).DownloadFile(
      $uri,
      $ExecutionContext.SessionState.Path.GetUnresolvedProviderPathFromPSPath(
        "~\AppData\Local\nvim\autoload\plug.vim"
      )
    )
}

$nvimdir = "C:\Users\$env:username\AppData\Local\nvim"

$plugged = "$nvimdir\plugged"
if ( ! (Test-Path $plugged )) { $null = md -p C:\Users\$env:username\AppData\Local\nvim\plugged }

((Get-Content -Path ..\nvim\init.vim) -replace "~/.config","~/AppData/Local" ) | `
	Set-Content -Path .\init.vim

$initvim = (Resolve-Path .\init.vim).Path
$vimplugins = (Resolve-Path ..\nvim\plugins).Path

del $nvimdir/init.vim -ErrorAction SilentlyContinue
copy $initvim $nvimdir   # Can't create symlink without admin rights
del $nvimdir/plugins -Recurse -ErrorAction SilentlyContinue
copy $vimplugins $nvimdir -Recurse

