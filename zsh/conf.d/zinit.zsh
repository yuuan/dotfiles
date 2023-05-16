# ----------------------------------------
# Setup Zinit
# ----------------------------------------
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust

# ----------------------------------------
# Plugins
# ----------------------------------------

zinit ice depth=1
zinit light romkatv/powerlevel10k

## zsh-completions
zinit light zsh-users/zsh-completions

## zsh-syntax-highlighting
zinit light zsh-users/zsh-syntax-highlighting

## zsh-autosuggestions
zinit light zsh-users/zsh-autosuggestions

## fzf
zinit ice from="gh-r" as="program"
zinit light junegunn/fzf

## fzf-tmux
zinit ice lucid wait'0c' as="program" id-as="junegunn/fzf-tmux" pick="bin/fzf-tmux"
zinit light junegunn/fzf

## peco
zinit ice from="gh-r" as="program"
zinit light peco/peco

### peco-tmux
zinit ice lucid wait'0c' as="program" mv="peco-tmux.sh -> peco-tmux" pick="peco-tmux" atpull='!git reset --hard'
zinit light b4b4r07/peco-tmux.sh

## enhancd
zinit ice lucid wait'0c' atload'zicompinit; zicdreplay' pick="init.sh"
zinit light b4b4r07/enhancd

## history
zinit ice lucid wait'0c' pick="misc/zsh/init.zsh" if='[ -n "$commands[history]" -a "$TERM_PROGRAM" != vscode ]'
zinit load b4b4r07/history
