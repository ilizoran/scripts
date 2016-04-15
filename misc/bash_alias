# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

alias s="sudo su"

# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
    # We have color support; assume it's compliant with Ecma-48
    # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
    # a case would tend to support setf rather than setaf.)
    color_prompt=yes
    else
    color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
#if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
#    . /etc/bash_completion
#fi

#my alias

alias lm="ls -al | more"
alias lf="ls -FG"
alias h="history"
alias hm="history | more"
alias ff="find . -type f -name "
alias install="sudo apt-get install"
alias up="apt-get update"
alias ra="service apache2 restart"


function create_alias(){
echo ""
echo -n "Name of the alias > "
read alias_name
echo -n "Command > "
read alias_command
echo "Writing new alias to your bash profile!"
echo "alias $alias_name='$alias_command'" >> ~/.bashrc
}

function lista(){
echo "List of aliases:"
    ALIASES=`alias | cut -d '=' -f 1`
    echo "$COMMANDS"$'\n'"$ALIASES" | sort -u

echo ""
echo "####################"
}

alias ca="create_alias"
alias bash="gedit ~/.bashrc"
alias o="cd /opt/otrs"
alias cdlogo="cd /opt/otrs/var/log/"
alias logo="sudo gedit /opt/otrs/var/log/otrs.log"

alias cdloga='cd /var/log/apache2'
alias loga='sudo gedit /var/log/apache2/error.log'
alias listag='gedit /root/.gitconfig'
alias sp='bin/otrs.SetPermissions.pl --otrs-user=otrs  --web-group=www-data /opt/otrs'

alias sf='../scripts/sync_fork.sh'
alias sf5='../scripts/sync_fork_5_0.sh'

alias rc='../scripts/rebuild_config.sh'
alias modunins='perl ../module-tools/module-linker.pl uninstall'
alias modins='perl ../module-tools/module-linker.pl install'
alias ut='perl bin/otrs.Console.pl Dev::UnitTest::Run --test'
alias ud='perl bin/otrs.Console.pl Dev::UnitTest::Run --directory'
alias p='phantomjs --wd'
alias rest='sudo perl scripts/restore.pl -b /opt/backup_basic/ -d /opt/otrs/'
alias backup='sudo perl scripts/backup.pl -d /opt/backup -t fullbackup'
alias cu='perl ../scripts/otrs.CleanTestUsers.pl'
alias ss='mc /tmp'
alias cl='perl bin/otrs.Console.pl Maint::Session::DeleteAll'
alias c='mc /opt/otrs/var/tmp'
alias ols='perl bin/otrs.Console.pl List'
alias sd='java -jar ../selenium/selenium-server-standalone-2.53.0.jar'
alias r='../scripts/reset_system.sh'
alias gt='perl bin/otrs.Console.pl Dev::Tools::Database::RandomDataInsert --generate-tickets 20 --articles-per-ticket 2 --generate-users 2 --generate-customer-users 2  --generate-queues 2 --mark-tickets-as-seen'

# install systems
alias otrs='../scripts/install_OTRS.sh'
alias otrsPG='../scripts/install_OTRS_PG.sh'
alias otrsAll='../scripts/install_OTRS_PG_ALL.sh'
alias otrsVanila='../scripts/install_OTRS_Vanila.sh'
alias otrsPortal='../scripts/install_OTRS_CustomerPortal.sh'

# unlink all modules
alias ul='perl ../scripts/Linker.pl -a uninstall -m /opt -o /opt/otrs -l All -d'
alias up='../scripts/otrs_customer_portal_uninstall.sh'

alias fetch='perl bin/otrs.Console.pl Maint::PostMaster::Read < '


PERL_MB_OPT="--install_base \"/home/s7otrs/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/home/s7otrs/perl5"; export PERL_MM_OPT;
