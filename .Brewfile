# vim: noai:ts=2:sw=2 filetype=ruby
# Example: https://github.com/joelparkerhenderson/brewfile/blob/master/Brewfile
#tap 'caskroom/cask'
tap 'homebrew/core'
tap 'homebrew/bundle'
tap 'homebrew/services'
#tap 'caskroom/drivers'
#tap 'caskroom/versions'
tap 'homebrew/cask-versions'
tap 'homebrew/cask'
tap 'homebrew/cask-drivers'

# sshpass
tap 'hudochenkov/sshpass'
brew 'hudochenkov/sshpass/sshpass'

### neovim
tap 'neovim/neovim'
brew 'neovim'

### Shell
brew 'bash'
brew 'bash-completion'
brew 'calc'
brew 'coreutils'
brew 'dos2unix'
brew 'elinks'
brew 'fzf'
brew 'gawk'
brew 'gettext' # envsubst
brew 'gnu-sed', args: ['with-default-names']
brew 'grep', args: ['with-default-names']
brew 'hping'
brew 'httping'
brew 'ipcalc'
brew 'iproute2mac'
brew 'keychain'
brew 'the_silver_searcher'
brew 'tree'
brew 'zplug', args: ['HEAD', 'with-zsh']
brew 'zsh'
brew 'pstree'
brew 'psutils'
brew 'pv'
brew 'pwgen'
brew 'reattach-to-user-namespace'
brew 'mtr'
brew 'netcat'
brew 'unrar'
brew 'p7zip'
brew 'watch'
brew 'htop'
brew 'rlwrap' # Readline wrapper: adds readline support to tools that lack it
brew 'parallel'

brew 'asciinema' # Record terminal session
brew 'tmate' # Share termial
brew 'tmux'

### Monitoring
brew 'smartmontools'

### DB
brew 'mycli'
brew 'mysql'
brew 'postgresql'

# MSSQL cli client `sqlcmd`
#tap 'microsoft/mssql-preview'
tap 'microsoft/homebrew-mssql-release'
brew 'microsoft/homebrew-mssql-release/mssql-tools'

### Download utility
brew 'aria2'
brew 'wget'

### Ops
brew 'awscli'
brew 'awslogs'
brew 's3cmd'
tap 'chef/chef'
cask 'chef/chef/chefdk'
brew 'ansible'
brew 'kubernetes-cli'
cask 'google-cloud-sdk'
brew 'rpm'
brew 'vault'
brew 'ssh-copy-id'
brew 'sshuttle'
brew 'openssh'
brew 'mosh'
brew 'socat'
brew 'nmap'
brew 'vegeta' # HTTP load testing tool

# ncurses like tool to manage k8s pods
tap 'derailed/k9s'
brew 'k9s'

# work with s3 bucket as file system
# cask 'osxfuse'
# brew 's3fs'
# brew 'goofys'

### Dev
brew 'git'
brew 'vcsh'
cask 'docker'
brew 'shellcheck'
brew 'yamllint'
brew 'go'
brew 'python3'
brew 'node'
brew 'libyaml' # required by rubocop
brew 'openssl@1.1' # required by rubocop
cask 'keybase' # public key crypto for everyone
cask 'postman'
cask 'visual-studio-code'

# json
brew 'jq'
brew 'jid'
brew 'jo'
brew 'jsonlint'
# Replaced with own script
# tap 'wakeful/selection'
# brew 'wakeful/selection/yaml2json'

# vagrant
cask 'vagrant'
cask 'virtualbox'
cask 'virtualbox-extension-pack'

# terraform
brew 'terraform'
brew 'graphviz' # terraform graph
# terraform lint cli `tflint`
brew 'wata727/tflint/tflint'
tap 'wata727/tflint'

# DNS
brew 'ldns'

### Media
#brew 'mpv', args: ['with-bundle']
cask 'mpv'
cask 'iina'
brew 'youtube-dl'
cask 'vlc'
cask 'spotify'
# cask 'airflow'
cask 'plex-media-server'
# does not work well with python3, so pip2 install tvnamer
#brew 'tvnamer'

### Browsers
#cask 'caskroom/versions/firefox-esr'
cask 'google-chrome'
cask 'firefox'
cask 'google-hangouts'
cask 'flash-npapi'
cask 'torbrowser'
cask 'rambox' # messaging and emailing app
cask 'java'

### Other
# select default applications for document types and URL schemes on Mac OS X
brew 'duti'

# Remap ECS key to Caps-Lock, is not necessary anymore due to
# https://9to5mac.com/2016/10/25/remap-escape-key-action-macbook-pro-macos-sierra-10-12-1-modifier-keys/
# cask 'karabiner-elements'

brew 'maven'
brew 'nginx'
brew 'openconnect'
cask 'google-backup-and-sync'
cask 'insomnia'
cask 'ioquake3'
cask 'iterm2'
cask 'keepassxc'
cask 'keka'
# cask 'mac2imgur'
cask 'macpass'
# cask 'openemu'
cask 'qbittorrent'
cask 'skitch'
cask 'steam'
cask 'teamviewer'
cask 'tunnelblick'
cask 'viber'
cask 'wireshark'
cask 'microsoft-remote-desktop-beta'

# IM
cask 'skype'
cask 'slack'
cask 'telegram-desktop'

# Security
brew 'aircrack-ng'
