# ~/.bashrc
# Portable, multi-distro bashrc — store in repo, reuse as needed.
# Tested baseline: Debian 13. Designed to degrade gracefully elsewhere.

# ----------------------------------------------------------------------
# 0. Bail if not running interactively
# ----------------------------------------------------------------------
case $- in
    *i*) ;;
      *) return;;
esac

# ----------------------------------------------------------------------
# 1. Shell options
# ----------------------------------------------------------------------
shopt -s checkwinsize        # update LINES/COLUMNS after each command
shopt -s histappend          # append to history, don't overwrite
shopt -s cmdhist             # multiline commands as single history entry
shopt -s no_empty_cmd_completion
[[ ${BASH_VERSINFO[0]} -ge 4 ]] && shopt -s autocd globstar dirspell 2>/dev/null

# ----------------------------------------------------------------------
# 2. History
# ----------------------------------------------------------------------
HISTSIZE=10000
HISTFILESIZE=20000
HISTCONTROL=ignoreboth       # ignore dupes and lines starting with space
HISTTIMEFORMAT='%F %T  '     # timestamp every entry
HISTIGNORE='ls:ll:cd:pwd:exit:clear:history'

# ----------------------------------------------------------------------
# 3. Environment
# ----------------------------------------------------------------------
# Prefer a sane editor, fall back gracefully
if command -v nvim >/dev/null 2>&1; then
    export EDITOR='nvim' VISUAL='nvim'
elif command -v vim >/dev/null 2>&1; then
    export EDITOR='vim' VISUAL='vim'
else
    export EDITOR='nano' VISUAL='nano'
fi

export PAGER='less'
export LESS='-R -F -X -i'    # raw colors, quit-if-one-screen, no init, smartcase
export LANG="${LANG:-en_US.UTF-8}"

# Add ~/.local/bin and ~/bin to PATH if present and not already there
for dir in "$HOME/.local/bin" "$HOME/bin"; do
    [[ -d "$dir" && ":$PATH:" != *":$dir:"* ]] && PATH="$dir:$PATH"
done
unset dir

# ----------------------------------------------------------------------
# 4. Color support (your original setup, made portable)
# ----------------------------------------------------------------------
if command -v dircolors >/dev/null 2>&1; then
    if [[ -r ~/.dircolors ]]; then
        eval "$(dircolors -b ~/.dircolors)"
    else
        eval "$(dircolors -b)"
    fi
    export LS_OPTIONS='--color=auto'
else
    # BSD/macOS-style ls doesn't support --color; use -G instead
    export LS_OPTIONS=''
    export CLICOLOR=1
fi

# ----------------------------------------------------------------------
# 5. Aliases
# ----------------------------------------------------------------------
# Listing (keeps your originals)
alias ls='ls $LS_OPTIONS'
alias ll='ls $LS_OPTIONS -alh'
alias lt='ls $LS_OPTIONS -alht'    # sort by time, your old "ll"
alias la='ls $LS_OPTIONS -A'
alias l='ls $LS_OPTIONS -CF'

# Safety nets
alias rm='rm -I --preserve-root'   # prompt past 3 files
alias cp='cp -i'
alias mv='mv -i'
alias ln='ln -i'
alias chmod='chmod --preserve-root'
alias chown='chown --preserve-root'

# Navigation
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias -- -='cd -'

# Colorized grep
alias grep='grep --color=auto'
alias egrep='grep -E --color=auto'
alias fgrep='grep -F --color=auto'

# Quality-of-life
alias df='df -h'
alias du='du -h'
alias free='free -h 2>/dev/null || free'
alias mkdir='mkdir -pv'
alias path='echo -e "${PATH//:/\\n}"'
alias now='date +"%F %T %Z"'
alias ports='ss -tulanp 2>/dev/null || netstat -tulanp'
alias myip='curl -fsS ifconfig.me 2>/dev/null; echo'
alias reload='source ~/.bashrc && echo "bashrc reloaded"'

# ----------------------------------------------------------------------
# 6. Functions
# ----------------------------------------------------------------------
# Make a directory and cd into it
mkcd() { mkdir -pv "$1" && cd "$1" || return; }

# Universal extractor
extract() {
    [[ -f "$1" ]] || { echo "extract: '$1' is not a file" >&2; return 1; }
    case "$1" in
        *.tar.bz2|*.tbz2) tar xjf "$1"   ;;
        *.tar.gz|*.tgz)   tar xzf "$1"   ;;
        *.tar.xz)         tar xJf "$1"   ;;
        *.tar)            tar xf  "$1"   ;;
        *.bz2)            bunzip2 "$1"   ;;
        *.gz)             gunzip  "$1"   ;;
        *.zip)            unzip   "$1"   ;;
        *.rar)            unrar x "$1"   ;;
        *.7z)             7z x    "$1"   ;;
        *.Z)              uncompress "$1";;
        *) echo "extract: don't know how to handle '$1'" >&2; return 1 ;;
    esac
}

# Quick backup of a file with timestamp
bak() { cp -a "$1" "$1.$(date +%Y%m%d-%H%M%S).bak"; }

# Search history
h() { history | grep -i --color=auto "$*"; }

# ----------------------------------------------------------------------
# 7. Prompt
# ----------------------------------------------------------------------
# Color the hostname red when running as root, show git branch if available
__git_branch() {
    command -v git >/dev/null 2>&1 || return
    local b
    b=$(git symbolic-ref --short HEAD 2>/dev/null) || return
    printf ' (%s)' "$b"
}

if [[ ${EUID} -eq 0 ]]; then
    __user_color='\[\e[1;31m\]'   # red for root
else
    __user_color='\[\e[1;32m\]'   # green for normal user
fi

PS1="${__user_color}\u@\h\[\e[0m\]:\[\e[1;34m\]\w\[\e[0;33m\]\$(__git_branch)\[\e[0m\]\$ "
unset __user_color

# ----------------------------------------------------------------------
# 8. Completion
# ----------------------------------------------------------------------
if ! shopt -oq posix; then
    if [[ -f /usr/share/bash-completion/bash_completion ]]; then
        . /usr/share/bash-completion/bash_completion
    elif [[ -f /etc/bash_completion ]]; then
        . /etc/bash_completion
    fi
fi

# ----------------------------------------------------------------------
# 9. Local, machine-specific overrides (NOT committed to repo)
# ----------------------------------------------------------------------
# Put per-machine secrets/paths/aliases in ~/.bashrc.local
[[ -r ~/.bashrc.local ]] && . ~/.bashrc.local
