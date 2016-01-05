# ----------------------------------------
# 環境変数 `PATH` の設定
# ----------------------------------------

# TODO: ホントは `.zshenv` に移動した方がいい

# for composer

if [ -d ~/.composer/vendor/bin ]; then
	export PATH="$PATH:$HOME/.composer/vendor/bin"
fi
