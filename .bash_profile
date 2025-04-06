#Git Completion
if [ -f ~/.git-completion.bash ]; then
  . ~/.git-completion.bash
fi

#Terminal Colors
export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced
#0D2D37 for background color

#To get Git branch name in the Terminal
##export GITAWAREPROMPT=~/.bash/git-aware-prompt
##source "${GITAWAREPROMPT}/main.sh"
##export PS1="\u@\h \w \[$txtcyn\]\$git_branch\[$txtwht\]\$git_dirty\[$txtrst\]\$ "

#sml
export PATH="$PATH:/usr/local/Cellar/smlnj-110.77/bin"

#NodeJS (Mac) - need access to dir for commands
export PATH=$PATH:/usr/local/bin

#alias
alias ..="cd .."
alias ....="cd ../.."
alias ......="cd ../../.."
alias spro='sublime ~/.bash_profile'
alias vpro='vim ~/.bash_profile'
alias szrc='sublime ~/.zshrc'
alias vzrc='vim ~/.zshrc'
alias vrc='vim ~/.vimrc'
alias vszrc="vscode ~/.zshrc"
alias s='git status'
alias b='git branch'
alias a='git add'
alias c='git commit -m'
alias pull='git pull'
alias gslist='git stash list'
alias gssave='git stash save'
alias gsapply='git stash apply'
alias pyserv='python -m SimpleHTTPServer'
alias sublime="open -a /Applications/Sublime\ Text\ 2.app"
alias showFiles='defaults write com.apple.finder AppleShowAllFiles YES'
alias hideFiles='defaults write com.apple.finder AppleShowAllFiles NO'
alias mongod="sudo /Applications/mongodb-osx-x86_64-3.0.4/bin/mongod"
alias mongo="sudo /Applications/mongodb-osx-x86_64-3.0.4/bin/mongo"
# Screen aliases
# ctrl+a, d to detach
alias screenList='screen -ls'
alias dustin="screen -r dustin"
alias retachScreen="screen -r"
alias cdustin="screen -S dustin"
alias createScreen="screen -S"

#Inspiration dot files
# https://github.com/alrra/dotfiles/blob/master/shell/bash_prompt
# https://github.com/mathiasbynens/dotfiles
enable_color_support() {

    if [[ $COLORTERM == gnome-* && $TERM == xterm ]] \
        && infocmp gnome-256color &> /dev/null; then
        export TERM='gnome-256color'
    elif infocmp xterm-256color &> /dev/null; then
        export TERM='xterm-256color'
    fi

    if [ "$OS" == "osx" ]; then
        alias ls='ls -G' # or CLICOLOR=1

    elif [ "$OS" == "ubuntu" ]; then
        if [ -x /usr/bin/dircolors ]; then

            test -r ~/.dircolors \
                && eval "$(dircolors -b ~/.dircolors)" \
                || eval "$(dircolors -b)"

            alias dir='dir --color=auto'
            alias egrep='egrep --color=auto'
            alias fgrep='fgrep --color=auto'
            alias grep='grep --color=auto'
            alias ls='ls --color=auto'
            alias vdir='vdir --color=auto'

        fi
    fi

}
get_git_repository_details() {

    local branchName=''
    local tmp=''

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Check if the current directory is in a Git repository
    [ "$(git rev-parse &>/dev/null; printf $?)" -ne 0 ] && return

    # Check if in `.git/` directory (some of the following
    # checks don't make sense/won't work in the `.git` directory)
    [ "$(git rev-parse --is-inside-git-dir)" == "true" ] && return

    # Check for uncommitted changes in the index
    if ! $(git diff --quiet --ignore-submodules --cached); then
        tmp="$tmp+";
    fi

    # Check for unstaged changes
    if ! $(git diff-files --quiet --ignore-submodules --); then
        tmp="$tmp!";
    fi

    # Check for untracked files
    if [ -n "$(git ls-files --others --exclude-standard)" ]; then
        tmp="$tmp?";
    fi

    # Check for stashed files
    if $(git rev-parse --verify refs/stash &>/dev/null); then
        tmp="$tmp$";
    fi

    [ -n "$tmp" ] && tmp=" [$tmp]"


    branchName="$( printf "$( git rev-parse --abbrev-ref HEAD 2> /dev/null \
        || git rev-parse --short HEAD 2> /dev/null \
        || printf " (unknown)" )" | tr -d "\n" )"


    printf "%s" "$1$branchName$tmp"

}
set_prompts() {

    local black='' blue='' bold='' cyan='' green='' orange='' \
          purple='' red='' reset='' white='' yellow=''

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    if [ -x /usr/bin/tput ] && tput setaf 1 &> /dev/null; then

        tput sgr0 # Reset colors

        bold=$(tput bold)
        reset=$(tput sgr0)

        # Solarized colors
        # https://github.com/altercation/solarized/tree/master/iterm2-colors-solarized#the-values

        black=$(tput setaf 0)
        blue=$(tput setaf 33)
        cyan=$(tput setaf 37)
        green=$(tput setaf 64)
        orange=$(tput setaf 166)
        purple=$(tput setaf 61) #125)
        red=$(tput setaf 124)
        white=$(tput setaf 15)
        yellow=$(tput setaf 136)
        violet=$(tput setaf 125) #61)

    else

        bold=''
        reset="\e[0m"

        black="\e[1;30m"
        blue="\e[1;34m"
        cyan="\e[1;36m"
        green="\e[1;32m"
        orange="\e[1;33m"
        purple="\e[1;35m"
        red="\e[1;31m"
        white="\e[1;37m"
        yellow="\e[1;33m"

    fi

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Prompt Statement variables
    # http://ss64.com/bash/syntax-prompt.html

    # ------------------------------------------------------------------
    # | PS1 - Default interactive prompt                               |
    # ------------------------------------------------------------------

    PS1="\[\033]0;\w\007\]"         # Terminal title (set to the
                                    # current working directory)
    PS1+="\[$bold\]"
    PS1+="\[$orange\]\u"            # Username
    PS1+="\[$white\]@"
    # DON'T SHOW THE HOST PS1+="\[$yellow\]\h"            # Host
    PS1+="\[$white\]: "
    PS1+="\[$green\]\w"             # Working directory
    PS1+="\$(get_git_repository_details \"$white on $cyan\")"
    PS1+="\n"
    PS1+="\[$reset$white\]\$ \[$reset\]"

    export PS1

    # ------------------------------------------------------------------
    # | PS2 - Continuation interactive prompt                          |
    # ------------------------------------------------------------------

    PS2='⚡ '

    export PS2

    # ------------------------------------------------------------------
    # | PS4 - Debug prompt                                             |
    # ------------------------------------------------------------------

    # e.g:
    #
    # The GNU `date` command has the `%N` interpreted sequence while
    # other implementations don't (on OS X `gdate` can be used instead
    # of the native `date` if the `coreutils` package was installed)
    #
    # local dateCmd=""
    #
    # if [ "$(date +%N)" != "N" ] || \
    #    [ ! -x "$(command -v 'gdate')" ]; then
    #    dateCmd="date +%s.%N"
    # else
    #    dateCmd="gdate +%s.%N"
    # fi
    #
    # PS4="+$( tput cr && tput cuf 6 &&
    #          printf "$yellow %s $green%6s $reset" "$($dateCmd)" "[$LINENO]" )"
    #
    # PS4 output:
    #
    #   ++    1357074705.875970000  [123] '[' 1 == 0 ']'
    #   └──┬─┘└────┬───┘ └───┬───┘ └──┬─┘ └──────┬─────┘
    #      │       │         │        │          │
    #      │       │         │        │          └─ command
    #      │       │         │        └─ line number
    #      │       │         └─ nanoseconds
    #      │       └─ seconds since 1970-01-01 00:00:00 UTC
    #      └─ depth-level of the subshell

    PS4="+$( tput cr && tput cuf 6 && printf "%s $reset" )"

    export PS4

}
main() {
    enable_color_support
    set_prompts
}

main

unset -f enable_color_support
unset -f set_prompts
