#!/usr/bin/bash
if status is-interactive
    # Commands to run in interactive sessions can go here
end

starship init fish | source

alias dir='dir --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias fixpacman="sudo rm /var/lib/pacman/db.lck"
alias grep='grep --color=auto'
alias grubup="sudo update-grub"
alias hw='hwinfo --short'
alias psmem10='ps auxf | sort -nr -k 4 | head -10'
alias psmem='ps auxf | sort -nr -k 4'
alias rmpkg="sudo pacman -Rdd"
alias tarnow='tar -acf '
alias untar='tar -zxvf '
alias upd='/usr/bin/update'
alias vdir='vdir --color=auto'
alias wget='wget -c '
alias gdrive='rclone --vfs-cache-mode writes mount drive: ~/drive'
alias sharefile='rclone --vfs-cache-mode writes mount sharefile: ~/sharefile'
alias update='sudo pacman -Syu'
alias sound1='systemctl --user restart pipewire.service'
alias sound2='systemctl --user restart pipewire-media-session.service'
alias apt-get='man pacman'
alias apt='man pacman'
alias helpme='cht.sh --shell'
alias please='sudo'
alias tb='nc termbin.com 9999'
alias cleanup='sudo pacman -Rns `pacman -Qtdq`'
alias jctl="journalctl -p 3 -xb"
alias rip="expac --timefmt='%Y-%m-%d %T' '%l\t%n %v' | sort | tail -200 | nl"
alias mirror="sudo reflector -f 30 -l 30 --number 10 --verbose --save /etc/pacman.d/mirrorlist"
alias mirrord="sudo reflector --latest 50 --number 20 --sort delay --save /etc/pacman.d/mirrorlist"
alias mirrors="sudo reflector --latest 50 --number 20 --sort score --save /etc/pacman.d/mirrorlist"
alias mirrora="sudo reflector --latest 50 --number 20 --sort age --save /etc/pacman.d/mirrorlist"
alias grub="cd /home/ellie && ./grub.sh"
alias rebuild="cd /home/ellie && ./update.sh"

set -x SHELL_ICON 🐠
set -U fish_greeting
if status --is-interactive && type -q fastfetch
   fastfetch
end

function last_history_item; echo $history[1]; end 
abbr -a !! --position anywhere --function last_history_item


