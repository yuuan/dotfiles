#!/bin/zsh -eu

local PHP_DOC_URI="http://jp2.php.net/get/php_manual_ja.tar.gz/from/this/mirror"
local VIM_DOCS_DIR="$HOME/.vim/docs"

mkdir -p $VIM_DOCS_DIR

\wget "${PHP_DOC_URI}" -O "${VIM_DOCS_DIR}/php_manual_ja.tar.gz" \
	&& pushd "${VIM_DOCS_DIR}" \
	&& \tar xvfz "php_manual_ja.tar.gz" \
	&& popd \
	&& ls -laF "${VIM_DOCS_DIR}/php-chunked-xhtml" | \less -R
