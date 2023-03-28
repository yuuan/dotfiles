$DotFiles = Split-Path -Parent $PSScriptRoot

function InstallPwsh {
	New-Item -Force -Type SymbolicLink $Profile.CurrentUserAllHosts -Value ($DotFiles + '\pwsh\CurrentUserAllHosts.ps1')
	New-Item -Force -Type SymbolicLink $Profile.CurrentUserCurrentHost -Value ($DotFiles + '\pwsh\CurrentUserCurrentHost.ps1')
}

function InstallScoop {
	if (Get-Command "scoop") {
		echo 'Scoop is already installed.'
		return
	}

	Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
	irm get.scoop.sh | iex

	scoop bucket add extras
}

function InstallScoopNeoVim {
	scoop install wget gzip make cmake gcc ripgrep fd
	scoop install fzf
	scoop install deno
	scoop install neovim
	scoop list
}

function InstallNeoVim {
	$Config = $env:LOCALAPPDATA + '\nvim'
	New-Item -Force -ItemType Directory $Config
	New-Item -Force -Type SymbolicLink ($Config + '\init.lua') -Value ($DotFiles + '\nvim\init.lua')
	New-Item -Force -Type SymbolicLink ($Config + '\lua') -Value ($DotFiles + '\nvim\lua')
	New-Item -Force -Type SymbolicLink ($Config + '\ftplugin') -Value ($DotFiles + '\nvim\ftplugin')
	New-Item -Force -Type SymbolicLink ($Config + '\snippets') -Value ($DotFiles + '\nvim\snippets')
}

foreach ($Target in $Args) {
	switch -Regex ($Target) {
		"pwsh" {
			InstallPwsh
			break
		}
		"scoop" {
			InstallScoop
			break
		}
		"scoop-(neovim|nvim)" {
			InstallScoopNeoVim
			break
		}
		"neovim|nvim" {
			InstallNeoVim
			break
		}
	}
}
