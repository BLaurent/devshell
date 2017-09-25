# Raccourcis pour 'ls'
alias ll='ls -l'
alias la='ls -A'
alias lla='ls -al'
alias lx='ls -lXB'              # sort by extension
alias lk='ls -lSr'              # sort by size
alias lc='ls -lcr'		# sort by change time
alias lu='ls -lur'		# sort by access time
alias lr='ls -lR'               # recursifile:///Users/benoitlaurent/Downloads/predix_to_pzen.pacve ls
alias lt='ls -ltr'              # sort by date

# Quelques alias pratiques
alias s='cd ..'
alias c='clear'

# quand on est bourr�
alias xs='cd'
alias vf='cd'
alias moer='more'
alias moew='more'
alias kk='ll'

alias df='df -h'
alias du='du -k -h'

alias untar='tar xvf'
alias untargz='tar xvzf'
alias untarbz2='tar xvjf'
alias targzarch='tar cvfz'
alias tarbz2arch='tar cvfj'

alias grep='grep --color=auto'
alias less='less --quiet'
alias make='make --silent'
alias vi='vim'
function makesilent() { make "$@" >> ~/make.log 2>&1 }

alias h='history 50'
function qf() {find . -name "$@" -print}
function grc() {grep -n --color=auto "$@" *.c *.cxx }
function grh() {grep -n "$@" *.h *.hxx}
function grch() {grep -n "$@" *.[ch] *.[ch]xx}
function grl() {grep -n "$@" *.htm *.html}
function format() { astyle -NSCHUD -pxd -k3 -W1 -A2 --indent=spaces=2 "$@" }
alias emacs='gvim'
alias xemacs='gvim'
alias emacs-22.1='gvim'

function gocd () {
  cd `go list -f '{{.Dir}}' $1`
}


platform='unknown'
unamestr=`uname`
if [[ "$unamestr" == 'Linux' ]]; then
   platform='linux'
elif [[ "$unamestr" == 'FreeBSD' ]]; then
   platform='freebsd'
 elif [[ "$unamestr" == 'Darwin' ]]; then
   platform='osx'
fi

export NVM_DIR="$HOME/.nvm"
if [[ $platform == 'osx' ]]
then
  source $(brew --prefix nvm)/nvm.sh
else
  [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" # This loads nvm
fi


function no_proxy(){
  unset HTTP_PROXY
  unset HTTPS_PROXY
  unset NO_PROXY
  unset http_proxy
  unset https_proxy
  unset no_proxy
}

function vg() { valgrind --error-limit=no --num-callers=10 --leak-check=full --leak-resolution=med --run-libc-freeres=no "$@" }
function vgd() { valgrind --error-limit=no --leak-check=full --show-reachable=yes --leak-resolution=med --db-attach=yes --run-libc-freeres=no "$@" }
function vgr() { valgrind --demangle=yes --error-limit=no --leak-check=full --show-reachable=yes --track-origins=yes --leak-resolution=high --run-libc-freeres=no "$@" }

function rg(){ grep -n -R -I --exclude='*.so' --exclude='*.so.*' --exclude='*.a' --color=auto  "$@" ./ 2>/dev/null }
function rgc(){ grep -n -R -I --color=auto --include='*.c' --include='*.cxx' --include='*.cc' --include='*.cpp' "$@" ./ 2>/dev/null }
function rgch(){ grep -n -R -I --color=auto --include='*.[ch]' --include='*.[ch]xx' --include='*.cc' --include='*.[ch]pp' "$@" ./ 2>/dev/null }
function rgcxx(){ grep -n -R -I --color=auto --include='*.cxx' --include='*.cc' --include='*.cpp' "$@" ./ 2>/dev/null }
function rgh(){ grep -n -R -I --color=auto --include='*.h' --include='*.hxx' --include='*.hh' --include='*.hpp' "$@" ./ 2>/dev/null }
function rgj(){ grep -n -R -I --color=auto --include='*.java' --include='*.js' "$@" ./ 2>/dev/null }
function rgl(){ grep -n -R -I --color=auto --include='*.htm' --include='*.html' --include='*.xml' "$@" ./ 2>/dev/null }
function rgp(){ grep -n -R -I --color=auto --include='*.py' "$@" ./ 2>/dev/null }
function rgts(){ grep -n -R -I --color=auto --include='*.ts' "$@" ./ 2>/dev/null }
function rgcss(){ grep -n -R -I --color=au --include='*.css' --include='*.less' "$@" ./ 2>/dev/null }

alias envgr='env | grep'

alias hgcheck='hg status . | egrep -v "^\?"'

function gps() {ps -ef | fgrep "$@" | fgrep -v fgrep }
function genv() {env | fgrep "$@"}
function lm() {ls -tl "$@" | head -30 }
function lpman() { troff -man -Tpost "$@" | /usr/lib/lp/postscript/dpost | lpr }

function psc {
  ps --cols=1000 --sort='-%cpu,uid,pgid,ppid,pid' -e \
     -o user,pid,ppid,pgid,stime,stat,wchan,time,pcpu,pmem,vsz,rss,sz,args |
     sed 's/^/ /' | less
}

function psm {
  ps --cols=1000 --sort='-vsz,uid,pgid,ppid,pid' -e \
     -o user,pid,ppid,pgid,stime,stat,wchan,time,pcpu,pmem,vsz,rss,sz,args |
     sed 's/^/ /' | less
}

function build_cscope_db()
{
  rm -f tags
  rm -f cscope.*
  find -L `pwd` -type f \( -name "*.[chxSs]" -o -name "*.java" -o -name "*.cxx" -o -name "*.hxx" -o -name "*.hpp" -o -name "*.hh" -o -name "*.cc" -o -name "*.cpp" -o -name "*.py" -o -name "*.inl" \) -print | egrep -v "omni|XmHTML|boost/*|xercesc|gtest|gmock|import/include|numpy|include/icon|system/icon|main/icon|local_include|boost_1_*_0|node_modules" > cscope.files
  cscope -b -R -u -q
  ctags --totals=yes --sort=foldcase --c-kinds=+nstpcxl --c++-kinds=+lpcx --fields=+ialS --extra=+q --file-scope=yes -L cscope.files
}

# aspell
alias aspell_fr='aspell --lang=fr'
alias aspell_en='aspell --lang=en'

#
# 2. Prompt et D�finition des touches
#

# exemple : ma touche HOME, cf man termcap, est codifiee K1 (upper left
# key on keyboard) dans le /etc/termcap. En me referant a l'entree
# correspondant a mon terminal (par exemple 'linux') dans ce fichier, je
# lis : K1=\E[1~, c'est la sequence de caracteres qui sera envoyee au
# shell. La commande bindkey dit simplement au shell : a chaque fois que
# tu rencontres telle sequence de caractere, tu dois faire telle action.
# La liste des actions est disponible dans "man zshzle".

# Correspondance touches-fonction
bindkey '^A'    beginning-of-line       # Home
bindkey '^E'    end-of-line             # End
bindkey '^D'    delete-char             # Del
bindkey '[3~' delete-char             # Del
bindkey '[2~' overwrite-mode          # Insert
bindkey '[5~' history-search-backward # PgUp
bindkey '[6~' history-search-forward  # PgDn
bindkey '^R' history-incremental-search-backward

# Prompt couleur (la couleur n'est pas la m�me pour le root et
# pour les simples utilisateurs)
#if [ "`id -u`" -eq 0 ]; then
#  EXPORT PS1="%{[2;44;30m%}%n%{[0m[2;49;33m%}@%{[2;49;34m%}%m %{[2;49;32m%}%~%{[0m[2;49;33m%}%#%{[0m%} "
#else
#  export PS1="%{[2;49;31m%}%n%{[0m[2;49;32m%}@%{[2;49;34m%}%m %{[2;49;33m%}%~%{[0m[2;49;32m%}%(!.#.$)%{[0m%} "
#fi


# Console linux, dans un screen ou un rxvt
if [ "$TERM" = "linux" -o "$TERM" = "screen" -o "$TERM" = "rxvt" ]
then
  # Correspondance touches-fonction sp�cifique
  bindkey '[1~' beginning-of-line       # Home
  bindkey '[4~' end-of-line             # End
fi

# xterm
if [ "$TERM" = "xterm" ]
then
   # Correspondance touches-fonction sp�cifique
  bindkey '[H'  beginning-of-line       # Home
  bindkey '[F'  end-of-line             # End
fi

if [ "$TERM" = "Eterm" ]
then
  # Correspondance touches-fonction sp�cifique
  bindkey '[H'  beginning-of-line       # Home
  bindkey '[F'  end-of-line             # End
fi

if [ "$COLORTERM" = "gnome-terminal" ]
then
  # Correspondance touches-fonction sp�cifique
  bindkey '[H'  beginning-of-line       # Home
  bindkey '[F'  end-of-line             # End
fi

# Gestion de la couleur pour 'ls' (exportation de LS_COLORS)
if [ -x /usr/bin/dircolors ]
then
  if [ -r ~/.dir_colors ]
  then
    eval "`dircolors --sh ~/.dir_colors`"
  elif [ -r /etc/DIR_COLORS ]
  then
    eval "`dircolors --sh /etc/DIR_COLORS`"
  fi
fi


#
# 3. Options de zsh (cf 'man zshoptions')
#

# Je ne veux JAMAIS de beeps
unsetopt beep
unsetopt hist_beep
unsetopt list_beep
# >| doit �tre utilis�s pour pouvoir �craser un fichier d�j� existant ;
# le fichier ne sera pas �cras� avec '>'
unsetopt clobber
# Ctrl+D est �quivalent � 'logout'
unsetopt ignore_eof
# Affiche le code de sortie si diff�rent de '0'
setopt print_exit_value
# Demande confirmation pour 'rm *'
unsetopt rm_star_silent
# Ignore les fichiers d'extensions suivantes
fignore=(.o:.class:\~)

#set coredump size to 100Mo
limit coredumpsize 100000

# Correction orthographique des commandes
# D�sactiv� car, contrairement � ce que dit le "man", il essaye de
# corriger les commandes avant de les hasher
#setopt correct

setopt autocd

# Sch�mas de compl�tion

# - Sch�ma A :
# 1�re tabulation : compl�te jusqu'au bout de la partie commune
# 2�me tabulation : propose une liste de choix
# 3�me tabulation : compl�te avec le 1er item de la liste
# 4�me tabulation : compl�te avec le 2�me item de la liste, etc...
# -> c'est le sch�ma de compl�tion par d�faut de zsh.

# Sch�ma B :
# 1�re tabulation : propose une liste de choix et compl�te avec le 1er item
#                   de la liste
# 2�me tabulation : compl�te avec le 2�me item de la liste, etc...
# Si vous voulez ce sch�ma, d�commentez la ligne suivante :
#setopt menu_complete

# Sch�ma C :
# 1�re tabulation : compl�te jusqu'au bout de la partie commune et
#                   propose une liste de choix
# 2�me tabulation : compl�te avec le 1er item de la liste
# 3�me tabulation : compl�te avec le 2�me item de la liste, etc...
# Je n'ai malheureusement jamais r�ussi � mettre en place ce sch�ma
# alors qu'il me para�t �tre le sch�ma id�al !
# Si vous savez comment faire �a avec zsh -> alexis@via.ecp.fr
# Comme ca :)
unsetopt list_ambiguous

# Options de compl�tion
# Quand le dernier caract�re d'une compl�tion est '/' et que l'on
# tape 'espace' apr�s, le '/' est effa��
setopt auto_remove_slash
# Fait la compl�tion sur les fichiers et r�pertoires cach�s
setopt glob_dots

# Traite les liens symboliques comme il faut
setopt chase_links

# Quand l'utilisateur commence sa commande par '!' pour faire de la
# compl�tion historique, il n'ex�cute pas la commande imm�diatement
# mais il �crit la commande dans le prompt
setopt hist_verify
# Si la commande est invalide mais correspond au nom d'un sous-r�pertoire
# ex�cuter 'cd sous-r�pertoire'
setopt auto_cd
# L'ex�cution de "cd" met le r�pertoire d'o� l'on vient sur la pile
setopt auto_pushd
# Ignore les doublons dans la pile
setopt pushd_ignore_dups
# N'affiche pas la pile apr�s un "pushd" ou "popd"
setopt pushd_silent
# "pushd" sans argument = "pushd $HOME"
setopt pushd_to_home

# Les jobs qui tournent en t�che de fond sont nic� � '0'
unsetopt bg_nice
# N'envoie pas de "HUP" aux jobs qui tourent quand le shell se ferme
unsetopt hup

#
# 4. Param�tres de l'historique des commandes
#

# Nombre d'entr�es dans l'historique
export HISTORY=8000
export SAVEHIST=8000
# Fichier o� est stock� l'historique
export HISTFILE=$HOME/.history

#
# 5. Compl�tion des options des commandes
#
zmodload -d complist zsh/complist
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}'
zstyle ':completion:*' max-errors 3 numeric
zstyle ':completion:*' use-compctl false
zstyle ':completion::complete:*' use-cache 1
zstyle ':completion:*:*:*:default' menu yes select
zstyle ':completion:*:*:kill:*:processes' list-colors "=(#b) #([0-9]#)*=36=31"
zstyle ':completion:*:(all-|)files' ignored-patterns '(|*/)CVS'
zstyle ':completion:*:cd:*' ignored-patterns '(*/)#CVS'

local _myhosts

if [ -e "${HOME}/.ssh/known_hosts" ]; then
  _myhosts=( ${${${${(f)"$(<$HOME/.ssh/known_hosts)"}:#[0-9]*}%%\ *}%%,*} )
fi

zstyle ':completion:*' hosts $_myhosts

# exec 2>>(while read line; do
#   print '\e[91m'${(q)line}'\e[0m' > /dev/tty; done &)

autoload -U compinit promptinit
compinit
promptinit

function ff() {find . -type f -follow -iname '*'$*'*' -ls ; }
function ffs() {find . -type f -follow -not -path '*/\.*' -iname '*'$*'*' -ls | perl -pe 's/.*?(?=\.\/)//'; }
function fl() {find .  -type l -follow -not -path '*/\.*' -iname '*'$*'*' -ls ; }
function fls() {find . -type l -follow -not -path '*/\.*' -iname '*'$*'*' -ls | perl -pe 's/.*?(?=\.\/)//'; }
function fd() {find .  -type d -follow -not -path '*/\.*' -iname '*'$*'*' -ls ; }
function fds() {find . -type d -follow -not -path '*/\.*' -iname '*'$*'*' -ls | perl -pe 's/.*?(?=\.\/)//'; }

function precmd {

    local TERMWIDTH
    (( TERMWIDTH = ${COLUMNS} - 1 ))


    ###
    # Truncate the path if it's too long.

    PR_FILLBAR=""
    PR_PWDLEN=""

    local promptsize=${#${(%):---(%n@%m:%l)---()--}}
    local pwdsize=${#${(%):-%~}}

    if [[ "$promptsize + $pwdsize" -gt $TERMWIDTH ]]; then
	    ((PR_PWDLEN=$TERMWIDTH - $promptsize))
    else
	PR_FILLBAR="\${(l.(($TERMWIDTH - ($promptsize + $pwdsize)))..${PR_HBAR}.)}"
    fi


    ###
    # Get APM info.

    #if which ibam > /dev/null; then
#	PR_APM_RESULT=`ibam --percentbattery`
 #   elif which apm > /dev/null; then
	PR_APM_RESULT=``
  #  fi
}


setopt extended_glob
preexec () {
    if [[ "$TERM" == "screen" ]]; then
	local CMD=${1[(wr)^(*=*|sudo|-*)]}
	echo -n "\ek$CMD\e\\"
    fi
}


setprompt () {
    ###
    # Need this so the prompt will work.

    setopt prompt_subst


    ###
    # See if we can use colors.

    autoload colors zsh/terminfo
    if [[ "$terminfo[colors]" -ge 8 ]]; then
	colors
    fi
    for color in RED GREEN YELLOW BLUE MAGENTA CYAN WHITE; do
	eval PR_$color='%{$terminfo[normal]$fg[${(L)color}]%}'
	eval PR_LIGHT_$color='%{$fg[${(L)color}]%}'
	(( count = $count + 1 ))
    done
    PR_NO_COLOUR="%{$terminfo[sgr0]%}"


    ###
    # See if we can use extended characters to look nicer.

    typeset -A altchar
    set -A altchar ${(s..)terminfo[acsc]}
    PR_SET_CHARSET="%{$terminfo[enacs]%}"
    PR_SHIFT_IN="%{$terminfo[smacs]%}"
    PR_SHIFT_OUT="%{$terminfo[rmacs]%}"
    PR_HBAR=${altchar[q]:--}
    PR_ULCORNER=${altchar[l]:--}
    PR_LLCORNER=${altchar[m]:--}
    PR_LRCORNER=${altchar[j]:--}
    PR_URCORNER=${altchar[k]:--}


    ###
    # Decide if we need to set titlebar text.

    case $TERM in
	xterm*)
	    PR_TITLEBAR=$'%{\e]0;%(!.-=*[ROOT]*=- | .)%n@%m:%~ | ${COLUMNS}x${LINES} | %y\a%}'
	    ;;
	screen)
	    PR_TITLEBAR=$'%{\e_screen \005 (\005t) | %(!.-=[ROOT]=- | .)%n@%m:%~ | ${COLUMNS}x${LINES} | %y\e\\%}'
	    ;;
	*)
	    PR_TITLEBAR=''
	    ;;
    esac


    ###
    # Decide whether to set a screen title
    if [[ "$TERM" == "screen" ]]; then
	PR_STITLE=$'%{\ekzsh\e\\%}'
    else
	PR_STITLE=''
    fi


    ###
    # APM detection

    #if which ibam > /dev/null; then
#	PR_APM='$PR_RED${${PR_APM_RESULT[(f)1]}[(w)-2]}%%(${${PR_APM_RESULT[(f)3]}[(w)-1]})$PR_LIGHT_BLUE:'
 #   elif which apm > /dev/null; then
#	PR_APM='$PR_RED${PR_APM_RESULT[(w)5,(w)6]/\% /%%}$PR_LIGHT_BLUE:'
 #   else
	PR_APM=''
 #   fi


    ###
    # Finally, the prompt.

    PROMPT='$PR_SET_CHARSET$PR_STITLE${(e)PR_TITLEBAR}\
$PR_CYAN$PR_SHIFT_IN$PR_ULCORNER$PR_BLUE$PR_HBAR$PR_SHIFT_OUT(\
$PR_GREEN%(!.%SROOT%s.%n)$PR_GREEN@%m:%l\
$PR_BLUE)$PR_SHIFT_IN$PR_HBAR$PR_CYAN$PR_HBAR${(e)PR_FILLBAR}$PR_BLUE$PR_HBAR$PR_SHIFT_OUT(\
$PR_MAGENTA%$PR_PWDLEN<...<%~%<<\
$PR_BLUE)$PR_SHIFT_IN$PR_HBAR$PR_CYAN$PR_URCORNER$PR_SHIFT_OUT\

$PR_CYAN$PR_SHIFT_IN$PR_LLCORNER$PR_BLUE$PR_HBAR$PR_SHIFT_OUT(\
%(?..$PR_LIGHT_RED%?$PR_BLUE:)\
${(e)PR_APM}$PR_YELLOW%D{%H:%M}\
$PR_LIGHT_BLUE:%(!.$PR_RED.$PR_WHITE)%#$PR_BLUE)$PR_SHIFT_IN$PR_HBAR$PR_SHIFT_OUT\
$PR_CYAN$PR_SHIFT_IN$PR_HBAR$PR_SHIFT_OUT\
$PR_NO_COLOUR '

    RPROMPT=' $PR_CYAN$PR_SHIFT_IN$PR_HBAR$PR_BLUE$PR_HBAR$PR_SHIFT_OUT\
($PR_YELLOW%D{%a,%b%d}$PR_BLUE)$PR_SHIFT_IN$PR_HBAR$PR_CYAN$PR_LRCORNER$PR_SHIFT_OUT$PR_NO_COLOUR'

    PS2='$PR_CYAN$PR_SHIFT_IN$PR_HBAR$PR_SHIFT_OUT\
$PR_BLUE$PR_SHIFT_IN$PR_HBAR$PR_SHIFT_OUT(\
$PR_LIGHT_GREEN%_$PR_BLUE)$PR_SHIFT_IN$PR_HBAR$PR_SHIFT_OUT\
$PR_CYAN$PR_SHIFT_IN$PR_HBAR$PR_SHIFT_OUT$PR_NO_COLOUR '
}

setprompt





