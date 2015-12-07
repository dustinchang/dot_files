#Present a notification symbol if any untracked changes, %c to format
+vi-git-untracked(){
    if [[ $(git rev-parse --is-inside-work-tree 2> /dev/null) == 'true' ]] && \
        git status --porcelain | grep '??' &> /dev/null ; then
        hook_com[staged]+='%F{10}?'
    fi
}

#Present a notification symbol if any stashed changes, %m to format
function +vi-git-stash() {
    local -a stashes

    if [[ -s ${hook_com[base]}/.git/refs/stash ]] ; then
        stashes=$(git stash list 2>/dev/null | wc -l)
        hook_com[misc]+="%F{10}$"
    fi
}

autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' unstagedstr '%F{10}!'   # display this when there are unstaged changes, %u to format
zstyle ':vcs_info:*' stagedstr '%F{10}+'  # display this when there are staged changes, %c to format
#zstyle ':vcs_info:*' actionformats '%F{5}%F{5}[%F{2}%b%F{3}|%F{1}%a%c%u%F{5}]%f '
zstyle ':vcs_info:*' formats '%F{015}on %F{9} %F{49}%b [%u%c%m%F{49}]'
zstyle ':vcs_info:git*+set-message:*' hooks git-untracked git-stash
theme_precmd () { vcs_info }

autoload -U colors && colors
setopt prompt_subst
PROMPT='%F{010}⬢ %F{190}%n: %F{29}%~ ${vcs_info_msg_0_}
%F{10}❯%{$reset_color%}'

autoload -U add-zsh-hook
add-zsh-hook precmd theme_precmd