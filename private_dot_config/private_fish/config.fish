if status is-interactive
    # Commands to run in interactive sessions can go here
end

set -gx GOPATH $HOME/golang
set -gx GOROOT /opt/homebrew/opt/go/libexec

fish_add_path ~/.local/bin
fish_add_path ~/.cargo/bin
fish_add_path $GOPATH/bin
fish_add_path $GOROOT/bin
fish_add_path /opt/homebrew/bin

# Aliases
alias cat bat
alias grep rg
alias mkdir 'mkdir -p'
alias cz chezmoi

zoxide init fish | source
