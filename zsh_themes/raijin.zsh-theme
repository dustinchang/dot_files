#If a bad command is run and can't execute, then arrow turns red until a successful command is run
# local ARROW="%(?:%{$fg_bold[yellow]%}❯ :%{$fg_bold[red]%}❯ )"
local ARROW="%(?:%{$fg_bold[green]%}❯ :%{$fg_bold[red]%}❯ )"
#Determine if current directory is within a git managed directory.
#If so, check if there is any git status's to display, if not, just display the git branch
function check_git_prompt_info() {
  #Check if in a git directory
  if git rev-parse --git-dir > /dev/null 2>&1; then
    #If no status diff for git (clean), then just print git branch
    if [[ -z $(git_prompt_status) ]]; then
      echo "$(git_prompt_info)"
    else #else print [] with git status's inside
      echo "$(git_prompt_info) [$(git_prompt_status)%{$fg[cyan]%}]"
    fi
  fi
}

#Prompt output, if want a RHS promt use RPROMPT
PROMPT='%{$fg_bold[cyan]%}%n%{$reset_color%} %{$fg[blue]%}%~ $(git_prompt_info) $(git_prompt_status)
%{$reset_color%}${ARROW}%{$reset_color%}'

#Format for git_prompt_info()
# ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[black]%}on %{$fg[white]%}λ %{$fg[cyan]%}"
ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[white]%}λ %{$fg[yellow]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX=""
ZSH_THEME_GIT_PROMPT_DIRTY=""
ZSH_THEME_GIT_PROMPT_CLEAN=""

# Format for git_prompt_status()
ZSH_THEME_GIT_PROMPT_ADDED="%{$fg_bold[green]%}+%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_MODIFIED="%{$fg[blue]%}!%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DELETED="%{$fg_bold[red]%}-%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_RENAMED="%{$fg_bold[red]%}>%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_UNMERGED="%{$fg[yellow]%}#%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[blue]%}?%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_STASHED="%{$fg[blue]%}$%{$reset_color%}"

#Colors
#Normal : Bright(bold)
#Background 31, 31, 31
#Selection 130, 255, 150
#Black 85, 85, 85 : 85, 85, 85
#Red : 233, 86, 112
#Green : 60, 230, 60 or 80, 255, 80
#Yellow 237, 255, 0 : 243, 255, 0
#Blue 0, 150, 130 : 0, 150, 150
#Magenta(use as orange) 215, 140, 40 : #Used to get rid of last number color and the changing color when cycling through directories, don't use orange for raijin though, only darkstar theme
#Cyan 45, 255, 180 : 0, 255, 178
#White
