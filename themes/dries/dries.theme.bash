#!/usr/bin/env bash

export GIT_PS1_SHOWDIRTYSTATE=true
export GIT_PS1_SHOWUNTRACKEDFILES=true
export GIT_PS1_SHOWSTASHSTATE=true

# Emoji-based theme to display source control management and
# virtual environment info beside the ordinary bash prompt.

# Theme inspired by:
#  - Naming your Terminal tabs in OSX Lion - http://thelucid.com/2012/01/04/naming-your-terminal-tabs-in-osx-lion/
#  - Bash_it sexy theme


# virtualenv prompts
VIRTUALENV_CHAR="ⓔ "
VIRTUALENV_THEME_PROMPT_PREFIX=""
VIRTUALENV_THEME_PROMPT_SUFFIX=""

# SCM prompts
SCM_NONE_CHAR=""
SCM_GIT_CHAR="[±] "
SCM_GIT_BEHIND_CHAR="${red}↓${white}"
SCM_GIT_AHEAD_CHAR="${green}↑${white}"
SCM_GIT_UNTRACKED_CHAR="${green}⌀${white}"
SCM_GIT_UNSTAGED_CHAR="${green}•${white}"
SCM_GIT_STAGED_CHAR="${yellow}+${white}"

SCM_THEME_PROMPT_DIRTY=""
SCM_THEME_PROMPT_CLEAN=""
SCM_THEME_PROMPT_PREFIX=""
SCM_THEME_PROMPT_SUFFIX=""

# Git status prompts
GIT_THEME_PROMPT_DIRTY=" ${red}✗${normal}"
GIT_THEME_PROMPT_CLEAN=" ${green}✓${normal}"
GIT_THEME_PROMPT_PREFIX=""
GIT_THEME_PROMPT_SUFFIX=""

# ICONS =======================================================================

icon_start="${white}┌${normal}"
icon_user=""
icon_host=" @ "
icon_directory=" in "
icon_branch=""
icon_end="${white}└❯ ${normal}"

# extra spaces ensure legiblity in prompt

# FUNCTIONS ===================================================================

# Display virtual environment info
function virtualenv_prompt {
  if [[ -n "$VIRTUAL_ENV" ]]; then
    virtualenv=`basename "$VIRTUAL_ENV"`
    echo -e "$VIRTUALENV_CHAR$virtualenv "
  fi
}

# Rename tab
function tabname {
  printf "\e]1;$1\a"
}

# Rename window
function winname {
  printf "\e]2;$1\a"
}

export PROMPT_DIRTRIM=3

function prompt_command() {
    PS1="\n${icon_start} ${white}\t${normal} | $(virtualenv_prompt)${blue}\u${normal}${icon_host}${cyan}\h${normal}${icon_directory}${green}\w${normal}\$([[ -n \$(git branch 2> /dev/null) ]] && echo \" on ${icon_branch}\")${red}$(scm_prompt_info)${normal}\n${icon_end}"
    PS2="${icon_end}"
}

PROMPT_COMMAND=prompt_command;
