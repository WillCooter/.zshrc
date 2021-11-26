export ZSH="/Users/???/.oh-my-zsh"
plugins=(colorize)
source $ZSH/oh-my-zsh.sh

# COLORISE SETUP
ZSH_COLORIZE_TOOL=chroma
ZSH_COLORIZE_CHROMA_FORMATTER=terminal256

# GIT BRANCH SETUP
unset LESS
autoload -Uz vcs_info
precmd() { vcs_info }
zstyle ':vcs_info:git:*' formats ' - %B(%b) '

# PROMPT SETUP
PROMPT='
%B%F{3}cooter%b %~${vcs_info_msg_0_}%f
 %B%F{2}%T%b [%i] → %f'

# EMPHASES
NORM=$(tput sgr0)
BOLD='\e[1m'
DIM='\e[2m'
UNDERLINED='\e[4m'
INVERTED='\e[7m'

# TEXT COLOURS
RED='\e[31m'
ORANGE='\e[38;5;208m'
YELLOW='\e[33m'
GREEN='\e[32m'
CYAN='\e[36m'
BLUE='\e[34m'
PURPLE='\e[38;5;98m'
MAGENTA='\e[38;5;165m'

function prnt {
    printf "$1\n"
}

function colours {
    prnt "\n COLOURS: ${RED}RED ${ORANGE}ORANGE ${YELLOW}YELLOW ${GREEN}GREEN ${CYAN}CYAN ${BLUE}BLUE ${PURPLE}PURPLE ${MAGENTA}MAGENTA ${NORM}"
    prnt " EMPHASES: ${NORM}NORM ${BOLD}BOLD${NORM} ${DIM}DIM${NORM} ${UNDERLINED}UNDERLINED${NORM} ${INVERTED}INVERTED${NORM}"
}

function branch_name {
    git branch --no-color | grep -E '^\*' | awk '{print $2}' \
    || echo "default_value"
}

# UTILITY ALIASES
alias ..="cd ../"
alias home="cd ~"
alias cls="clear"
alias quit="exit"
alias please="sudo"

# NODE PROCESS FUNCTIONS
function shownode {
    prnt "${RED}>>> ps aux | grep node${NORM}"
    ps aux | grep node
}
function killnode {
    prnt "${RED}>>> pkill -f node${NORM}"
    pkill -f node
}

# BASH SCRIPT FUNCTIONS
function edit {
    prnt "${RED}>>> vim ${BOLD}~/.zshrc${NORM}"
    vim ~/.zshrc
}
function editvs {
    prnt "${RED}>>> code ${BOLD}~/.zshrc${NORM}"
    code ~/.zshrc
}
function apply {
    prnt "${RED}>>> source ${BOLD}~/.zshrc${NORM}"
    source ~/.zshrc
}

# GIT FUNCTIONS
function gcommit {
    if [[ -n $(git status -s) ]]
    then
        git diff --stat
        prnt
        prnt "${RED}${BOLD}Enter a commit message:${NORM}"
        commit_message=
        while [[ $commit_message = "" ]]; do
            read commit_message
        done
        prnt "${RED}>>> git commit -a -m ${BOLD}$commit_message${NORM}"
        git commit -a -m "$commit_message"
    fi
}
function gpush {
    gcommit
    prnt "${RED}>>> git push origin ${BOLD}`branch_name`${NORM}"
    git push origin `branch_name`
}
function gpull {
    prnt "${RED}>>> git pull origin ${BOLD}`branch_name`${NORM}"
    git pull origin `branch_name`
}
function gadd {
    prnt "${RED}>>> git add ${BOLD}.${NORM}"
    git add .
}
function gmerge {
    if [ $# -eq 0 ]
    then
        prnt "${RED}${BOLD}Must supply a branch to merge from${NORM}"
    else
        prnt "${RED}>>> git pull origin ${BOLD}$1${NORM}"
        git pull origin $1
        prnt "${RED}>>> git merge ${BOLD}$1${NORM}"
        git merge $1
    fi
}
function gfetch {
    prnt "${RED}>>> git fetch${NORM}"
    git fetch
}
function gstatus {
    prnt "${RED}>>> git status ${BOLD}-s${NORM}"
    git status -s
}
function glog {
    prnt "${RED}>>> git log${NORM}"
    git log
}
function gdiff {
    prnt "${RED}>>> git diff${NORM}"
    git diff
}
function gstat {
    prnt "${RED}>>> git diff ${BOLD}--stat${NORM}"
    git diff --stat
}
function gcheck {
    if [ $# -eq 0 ]
    then
        prnt "${RED}${BOLD}Must supply a branch name${NORM}"
    else
        prnt "${RED}>>> git checkout ${BOLD}$1${NORM}"
        git checkout $1
    fi
}
function gbranch {
    prnt "${RED}>>> git branch${NORM}"
    git branch
}
function gnewbranch {
    if [ $# -eq 0 ]
    then
        prnt "${RED}${BOLD}Must supply a name for new branch${NORM}"
    else
        prnt "${RED}>>> git checkout -b ${BOLD}$1 `branch_name`${NORM}"
        git checkout -b $1 `branch_name`
    fi
}
function gdelete {
    prnt "${RED}>>> git branch -D ${BOLD}$1${NORM}"
    git branch -D $1
}
function gpurge {
    prnt "${RED}${BOLD}This will attempt to remove all local branches except 'dev'. Continue?${NORM}"
    read input
    if [[ $input == y* || $input = Y* ]]
    then
        for branch in $(git for-each-ref refs/heads  | cut -d/ -f3-)
        do
            if [ $branch != "dev" ]
            then
                gdelete $branch
            fi
        done
    else
        prnt "${RED}${BOLD}Canceling purge...${NORM}"
    fi
}

function help {
    prnt "\n ${RED}${BOLD} UTILITY ALIASES ${NORM}${RED}"
    prnt " ..           →      cd ../"
    prnt " home         →      cd ~"
    prnt " cls          →      clear"
    prnt " please       →      sudo"
    prnt " quit         →      exit"

    prnt "\n ${BOLD} NODE PROCESS FUNCTIONS ${NORM}${RED}"
    prnt " shownode     →      ps aux | grep node"
    prnt " killnode     →      pkill -f node"

    prnt "\n ${BOLD} ZSH SCRIPT FUNCTIONS ${NORM}${RED}"
    prnt " edit         →      vim ~/.zshrc"
    prnt " editvs       →      code ~/.zshrc"
    prnt " apply        →      source ~/.zshrc"

    prnt "\n ${BOLD} GIT FUNCTIONS ${NORM}${RED}"
    prnt " gcommit      →      git commit -a -m"
    prnt " gpush        →      git push origin"
    prnt " gpull        →      git pull origin"
    prnt " gadd         →      git add ."
    prnt " gmerge       →      git merge"
    prnt " gfetch       →      git fetch"
    prnt " gstatus      →      git status"
    prnt " glog         →      git log"
    prnt " gdiff        →      git diff"
    prnt " gstat        →      git diff --stat"
    prnt " gcheck       →      git checkout"
    prnt " gbranch      →      git branch"
    prnt " gnewbranch   →      git checkout -b"
    prnt " gdelete      →      git branch -D"
    prnt " gpurge       →      git branch -D (all branches except ${BOLD}dev${NORM}${RED})"
}
