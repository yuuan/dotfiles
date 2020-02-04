# ----------------------------------------
# `nvm` でバージョンを `peco` で選択
# ----------------------------------------

if which nvm &> /dev/null; then

	function nvm-install {
		local version=$(nvm ls-remote | fzf-tmux --prompt "version" | awk '{print $1}')
		[[ -n "$version" ]] && nvm install "$version"
	}

	function nvm-use {
		local version=$(nvm_ls | fzf-tmux --prompt "version")
		[[ -n "$version" ]] && nvm use "$version"
	}

fi
