# ----------------------------------------
# PHP のためのエイリアスの設定
# ----------------------------------------

function phpfix {
	local dryrun options=${${@:#-f}:#--force}
	[[ "${options}" = "${@}" ]] && dryrun="--dry-run"
	php-cs-fixer fix --diff --ansi ${options:-} ${dryrun:-} | less -R -F
}

alias artisan="php artisan"
