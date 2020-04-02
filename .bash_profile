# ~/.bash_profile

[[ -s ~/.bashrc ]] && source ~/.bashrc

export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced

NORM=$(tput sgr0)
BOLD='\e[1m'
DIM='\e[2m'
UNDERLINED='\e[4m'
INVERTED='\e[7m'

REDTEXT='\e[31m'
ORANGETEXT='\e[38;5;208m'
YELLOWTEXT='\e[33m'
GREENTEXT='\e[32m'
CYANTEXT='\e[36m'
BLUETEXT='\e[34m'
PURPLETEXT='\e[38;5;98m'
MAGENTATEXT='\e[38;5;165m'
BLACKTEXT='\e[30m'
WHITETEXT='\e[97m'
DEFAULTTEXT='\e[39m'

REDBACK='\e[41m'
ORANGEBACK='\e[48;5;208m'
YELLOWBACK='\e[43m'
GREENBACK='\e[42m'
CYANBACK='\e[46m'
BLUEBACK='\e[44m'
PURPLEBACK='\e[48;5;98m'
MAGENTABACK='\e[48;5;165m'
BLACKBACK='\e[40m'
WHITEBACK='\e[107m'
DEFAULTBACK='\e[49m'

function test_colours {
  echo -e ""
  echo -e " ${REDBACK}${BLACKTEXT}   REDBACK   ${NORM}           ${BLACKBACK}${REDTEXT}   REDTEXT   ${NORM}"
  echo -e " ${ORANGEBACK}${BLACKTEXT} ORANGEBACK  ${NORM}           ${BLACKBACK}${ORANGETEXT} ORANGETEXT  ${NORM}"
  echo -e " ${YELLOWBACK}${BLACKTEXT} YELLOWBACK  ${NORM}           ${BLACKBACK}${YELLOWTEXT} YELLOWTEXT  ${NORM}"
  echo -e " ${GREENBACK}${BLACKTEXT}  GREENBACK  ${NORM}           ${BLACKBACK}${GREENTEXT}  GREENTEXT  ${NORM}"
  echo -e " ${CYANBACK}${BLACKTEXT}  CYANBACK   ${NORM}           ${BLACKBACK}${CYANTEXT}  CYANTEXT   ${NORM}"
  echo -e " ${BLUEBACK}${BLACKTEXT}  BLUEBACK   ${NORM}           ${BLACKBACK}${BLUETEXT}  BLUETEXT   ${NORM}"
  echo -e " ${PURPLEBACK}${BLACKTEXT} PURPLEBACK  ${NORM}           ${BLACKBACK}${PURPLETEXT} PURPLETEXT  ${NORM}"
  echo -e " ${MAGENTABACK}${BLACKTEXT} MAGENTABACK ${NORM}           ${BLACKBACK}${MAGENTATEXT} MAGENTATEXT ${NORM}"
  echo -e " ${BLACKBACK}${WHITETEXT}  BLACKBACK  ${NORM}           ${WHITEBACK}${BLACKTEXT}  BLACKTEXT  ${NORM}"
  echo -e " ${WHITEBACK}${BLACKTEXT}  WHITEBACK  ${NORM}           ${BLACKBACK}${WHITETEXT}  WHITETEXT  ${NORM}"
  echo -e ""
  echo -e ""
  echo -e " ${NORM}${WHITETEXT}NORMAL${NORM}  |  ${BOLD}${WHITETEXT}BOLD${NORM}  |  ${DIM}${WHITETEXT}DIM${NORM}  |  ${UNDERLINED}${WHITETEXT}UNDERLINED${NORM}  |  ${INVERTED}${WHITETEXT}INVERTED${NORM}"
  echo -e ""
}

function parse_git_branch {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

function branch_name {
  git branch --no-color | grep -E '^\*' | awk '{print $2}' \
    || echo "default_value"
}

export PS1="\n\[\033[1;33m\]\u \[\033[0;33m\]\w -\[\033[1;33m\]\$(parse_git_branch) \n \[\033[1;32m\]\A \[\033[0;32m\][\#] → $NORM"
export PS2="\[\033[0;32m\] | → $NORM"

alias ls='ls -l'
alias ..='cd ../'
alias home="cd ~"
alias cls='clear'

function edit {
  echo -e "${REDTEXT}>>> vim ~/.bash_profile${NORM}"
  vim ~/.bash_profile
}
function apply {
  echo -e "${REDTEXT}>>> source ~/.bash_profile${NORM}"
  source ~/.bash_profile
}
function gcommit {
  if [ $# -eq 0 ]
  then
    echo -e "${REDTEXT}${BOLD}Enter a commit message:${NORM}"
    commit_message=
    while [[ $commit_message = "" ]]; do
      read commit_message
    done
    echo -e "${REDTEXT}>>> git commit -a -m ${BOLD}$commit_message${NORM}"
    git commit -a -m "$commit_message"
  else
    echo -e "${REDTEXT}>>> git commit -a -m $1${NORM}"
    git commit -a -m $1
  fi
}
function gpush {
  echo -e "${REDTEXT}>>> git add ${BOLD}*${NORM}"
  git add *
  if [[ -n $(git status -s) ]]
  then
    echo -e "${REDTEXT}${BOLD}Enter a commit message:${NORM}"
    commit_message=
    while [[ $commit_message = "" ]]; do
      read commit_message
    done
    echo -e "${REDTEXT}>>> git commit -a -m ${BOLD}$commit_message${NORM}"
    git commit -a -m "$commit_message"
  fi
  if [ $# -eq 0 ]
  then
    echo -e "${REDTEXT}>>> git push origin ${BOLD}`branch_name`${NORM}"
    git push origin `branch_name`
  else
    echo -e "${REDTEXT}>>> git push origin ${BOLD}$1${NORM}"
    git push origin $1
  fi
}
function gpull {
  if [ $# -eq 0 ]
  then
    echo -e "${REDTEXT}>>> git pull origin ${BOLD}`branch_name`${NORM}"
    git pull origin `branch_name`
  else
    echo -e "${REDTEXT}>>> git pull origin ${BOLD}$1${NORM}"
    git pull origin $1
  fi
}
function gfetch {
  echo -e "${REDTEXT}>>> git fetch${NORM}"
  git fetch
}
function gstatus {
  echo -e "${REDTEXT}>>> git status${NORM}"
  git status
}
function gadd {
  if [ $# -eq 0 ]
  then
    echo -e "${REDTEXT}>>> git add ${BOLD}*${NORM}"
    git add *
  else
    echo -e "${REDTEXT}>>> git add ${BOLD}$1${NORM}"
    git add $1
  fi
}
function gdiff {
  echo -e "${REDTEXT}>>> git diff${NORM}"
  git diff
}
function gcheck {
  if [ $# -eq 0 ]
  then
    echo -e "${REDTEXT}${BOLD}Must supply a branch name${NORM}"
  else
    echo -e "${REDTEXT}>>> git checkout ${BOLD}$1${NORM}"
    git checkout $1
  fi 
}
function gbranch {
  echo -e "${REDTEXT}>>> git branch${NORM}"
  git branch
}
function gnewbranch {
  if [ $# -eq 0 ]
  then
    echo -e "${REDTEXT}${BOLD}Must supply a name for new branch${NORM}"
  else
    echo -e "${REDTEXT}>>> git checkout -b ${BOLD}$1 ${NORM}`branch_name`${NORM}"
    git checkout -b $1 `branch_name`
  fi  
}
function gmerge {
  if [ $# -eq 0 ]
  then
    echo -e "${REDTEXT}${BOLD}Must supply a branch to merge from${NORM}"
  else
    echo -e "${REDTEXT}>>> git merge ${BOLD}$1${NORM}"
    git merge $1
  fi
}
function glog {
  echo -e "${REDTEXT}>>> git log${NORM}"
  git log
}
function gclean {
  echo -e "${REDTEXT}>>> git checkout .${NORM}"
  git checkout .
}
function greset {
  echo -e "${REDTEXT}>>> git reset --hard origin/${BOLD}$1${NORM}"
  git reset --hard origin/$1
}
function gdelete {
  echo -e "${REDTEXT}>>> git branch -D ${BOLD}$1${NORM}"
  git branch -D $1
}
function gprune {
  echo -e "${REDTEXT}>>> git remote prune origin --dry-run${NORM}"
  git remote prune origin --dry-run
  if [[ -z $(git remote prune origin --dry-run) ]]
  then
    echo -e "${REDTEXT}${BOLD}Nothing to prune.${NORM}"
  else
    echo -e "${REDTEXT}${BOLD}Prune these branches?${NORM}"
    read input
    if [[ $input == y* || $input = Y* ]]
    then
      echo -e "${REDTEXT}>>> git remote prune origin${NORM}"
      git remote prune origin
    else
      echo -e "${REDTEXT}${BOLD}Canceling prune...${NORM}"
    fi
  fi
}
function gpurge {
  echo -e "${REDTEXT}${BOLD}This will attempt to remove all local branches except 'dev'. Continue?${NORM}"
  read input
  if [[ $input == y* || $input = Y* ]]
  then
    echo -e "${REDTEXT}>>> git branch | grep -v 'dev' | xargs git branch -d${NORM}"
    git branch | grep -v "dev" | xargs git branch -d
  else
    echo -e "${REDTEXT}${BOLD}Canceling purge...${NORM}"
  fi
}

function help {
  echo -e " ${REDBACK}${BLACKTEXT} COMMAND ${NORM}           ${REDBACK}${BLACKTEXT} FUNCTION ${NORM}${REDTEXT}"
  echo " ls           →      ls -l"
  echo " ..           →      cd ../"
  echo " home         →      cd ~"
  echo " cls          →      clear"
  echo " edit         →      vim ~/.bash_profile"
  echo " apply        →      source ~/.bash_profile"
  echo " gcommit      →      git commit -a -m"
  echo " gpush        →      git push origin"
  echo " gpull        →      git pull origin"
  echo " gfetch       →      git fetch"
  echo " gstatus      →      git status"
  echo " gadd         →      git sadd"
  echo " gdiff        →      git diff"
  echo " gcheck       →      git checkout"
  echo " gnewbranch   →      git checkout -b"
  echo " gmerge       →      git merge"
  echo " gbranch      →      git branch"
  echo " glog         →      git log"
  echo " gclean       →      git checkout ."
  echo " greset       →      git reset --hard origin/"
  echo " gdelete      →      git branch -D"
  echo " gprune       →      git remote prune origin"
  echo " gpurge       →      git branch | grep -v dev | xargs git branch -d"
}

echo "set completion-ignore-case On" >> ~/.inputrc
