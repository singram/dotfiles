#
# system aliases
#
alias edit_emacs='emacs ~.emacs'
alias cls=clear
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
# F puts / after directories * after executables @ after syms - h makes human readable sizes
alias lh='ls -laFh'
alias rm_svn='find . -name ".svn" | xargs rm -Rf'
alias git_branches_sorted='for k in `git branch -a |sed s/^..//`;do echo -e `git log -1 --pretty=format:"%Cgreen%ci %Cblue%cr%Creset" "$k"`\\t"$k";done|sort'
alias update_projects='cd ~/projects/ && svn up sage2 toolbox'

# tomcat operations
# NOTE: Add: ack    ALL = NOPASSWD: ALL - to /etc/sudoers file to allow this to work without asking for pw.
alias tomcat_stop='/usr/local/tomcat/bin/shutdown.sh'
alias tomcat_start='/usr/local/tomcat/bin/startup.sh'
alias tomcat_restart='/usr/local/tomcat/bin/shutdown.sh && /usr/local/tomcat/bin/startup.sh'
alias tomcat_logs='cd /usr/local/tomcat/logs'

# Pathing shortcuts
alias dbdumps='cd ~/projects/databases/'
alias s2_trunk_resources='cd ~/projects/sage2/trunk/medsage/mms/src/main/resources/'

# Ruby or Rails Specific
alias s4_home='cd ~/projects/s4/trunk'
alias s4_trunk_reset='cd ~/projects/s4/trunk && rake db:drop:s4 && rake db:create:s4 && rake db:migrate:total'
alias s4_trunk_sage3_reset='cd ~/projects/s4/trunk && rake db:drop:sage3 && rake db:create:sage3 && rake db:migrate:sage3'
alias memcache_start='memcached -vv'

function gitg
{
  command gitg "$@" &
}
export -f gitg

function meld
{
  command meld "$@" &
}
export -f meld
