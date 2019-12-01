noblacklist ~/Music
ignore seccomp
ignore private-tmp
include /etc/firejail/mpd.profile

whitelist ~/dotfiles
whitelist ~/.config/mpd
whitelist ~/Music
read-write ~/dotfiles/mpd/.config/mpd
read-only ~/dotfiles/mpd/.config/mpd/mpd.conf
