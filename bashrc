# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
if [ ! -z "$PS1" ]; then

  # don't put duplicate lines in the history. See bash(1) for more options
  # ... or force ignoredups and ignorespace
  HISTCONTROL=ignoredups:ignorespace

  # append to the history file, don't overwrite it
  shopt -s histappend
  # Whenever displaying the prompt, write the previous line to disk:
  PROMPT_COMMAND='history -a'

  # for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
  HISTSIZE=10000
  HISTFILESIZE=20000

  # check the window size after each command and, if necessary,
  # update the values of LINES and COLUMNS.
  shopt -s checkwinsize

  # Ignore small typos in directory names
  shopt -s cdspell

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

fi

# memcached stuff
export EVENT_NOKQUEUE=1

export JAVA_HOME=/usr/lib/jvm/java-6-openjdk
export MAVEN_HOME=/usr/local/apache-maven/apache-maven-2.2.1
export MAVEN_OPTS="-Xms256m -Xmx512m -XX:PermSize=256m -XX:MaxPermSize=512m"
export ANT_OPTS="-Xms256m -Xmx512m -XX:PermSize=256m -XX:MaxPermSize=512m"
export MYSQL_PS1="\u, \d> "
export CATALINA_HOME=/usr/local/tomcat
export JBOSS_HOME=/usr/local/jboss

export RAILS_ENV=development
export URL=ipl.medsagetechnologies.srai:3000

# Finally, update the path with all the good stuff
export PATH=$JAVA_HOME/bin:$MAVEN_HOME/bin:$RUBY_HOME/bin:~/bin:$PATH:$CATALINA_HOME/bin:$JBOSS_HOME/bin

export PS1='\[\e]0;\u@\h: \W\a\]${debian_chroot:+($debian_chroot)}\u@\h:\w`__git_ps1`\$ '

export TORQUEBOX_HOME=$HOME/projects/torquebox-current
export JBOSS_HOME=$TORQUEBOX_HOME/jboss
export JRUBY_HOME=$TORQUEBOX_HOME/jruby
export PATH=$JRUBY_HOME/bin:$PATH

complete -C ~/.bash/rake_completion -o default rake

test -f ~/.bash_functions && . ~/.bash_functions || true

# DONT FORGET TO CHANGE PAM_ENVIRONMENT to include the rvm path stuff if you
# want rspec/ruby to work fully in emacs
if [[ -s /home/singram/.rvm/scripts/rvm ]] ; then source /home/singram/.rvm/scripts/rvm ; fi

#[[ $- == *i* ]]   &&   . ~/bash/git-prompt.sh

[[ -r $rvm_path/scripts/completion ]] && . $rvm_path/scripts/completion
