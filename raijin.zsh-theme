#%{$fg[magenta]%}%n%{$reset_color%} at %{$fg[yellow]%}%m%{$reset_color%}

+vi-git-untracked(){
    if [[ $(git rev-parse --is-inside-work-tree 2> /dev/null) == 'true' ]] && \
        git status --porcelain | grep '??' &> /dev/null ; then
        hook_com[staged]+='%F{yellow}?'
    fi
}

function +vi-git-stash() {
    local -a stashes

    if [[ -s ${hook_com[base]}/.git/refs/stash ]] ; then
        stashes=$(git stash list 2>/dev/null | wc -l)
        hook_com[misc]+="%F{cyan}$"
    fi
}

autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' branchformat '%b%F{1}:%F{3}%r'
zstyle ':vcs_info:*' unstagedstr '%F{167}!'   # display this when there are unstaged changes
zstyle ':vcs_info:*' stagedstr '%F{green}+'  # display this when there are staged changes
#zstyle ':vcs_info:*' actionformats '%F{5}%F{5}[%F{2}%b%F{3}|%F{1}%a%c%u%F{5}]%f '
zstyle ':vcs_info:*' formats '%F{5}%F{2}%b%c%u%f %c%m'
zstyle ':vcs_info:git*+set-message:*' hooks git-untracked git-stash

#zstyle ':vcs_info:git*' actionformats "%b %m%u%c "
theme_precmd () { vcs_info }



setopt prompt_subst
PROMPT='$fg[cyan]%n: $fg[yellow]%~
➜ ${vcs_info_msg_0_} $reset_color'

autoload -U add-zsh-hook
add-zsh-hook precmd theme_precmd