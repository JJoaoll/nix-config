
{ config, lib, pkgs, ... }: {

  programs.bash = {
    enable = true;
    enableCompletion = true;

    shellAliases = {

      "ll"         = "lsd -l";
      "ya"         = "yazi";
      "cat"        = "bat --color=always";
      "doom"       = "~/.config/emacs/bin/doom run & disown";
      "nixedit"    = "sudo vim /etc/nixos/configuration.nix";
      "catnix"     = "sudo bat --color=always /etc/nixos/configuration.nix";
      "nixrebuild" = "sudo nixos-rebuild switch";
      "ff"         = "fzf --preview='bat --color=always {}'";
      "fe"         = "fzf -m --preview='bat --color=always {}' --bind 'enter:become(nvim {})'";
      
      "ne"         = "nixedit";        # nix edit"
      "nr"         = "nixrebuild";     # nix rebuild "
      "np"         = "catnix";         # nix print"
      "nh"         = "cd /etc/nixos/"; # nix home"
      
      "nv"         = "nix-instantiate --eval --expr";

      "g."         = "git add .";
      "gc-m"       = "git commit -m";
      "gp"         = "git push";

      #TODO: do!
      # "gp!"       = "git add .; git commit -m $1; git push;";
    };


    bashrcExtra = ''
      # # ~/.bashrc: Cute and cozy bash configuration
      #
      # # Exit early if not running interactively
      # [[ $- != *i* ]] && return
      #
      # # Source aliases with a warm welcome
      # if [ -f ~/.bash_aliases ]; then
      #   echo "✨ Loading your cozy aliases... ✨"
      #   . ~/.bash_aliases
      # else
      #   echo "😿 Oh no! Couldn't find .bash_aliases. Let's make one!"
      # fi
      #
      # # Set a cute prompt
      # PS1='[\u@\h \W] 🐾 '
      #
      # # Enable color support for ls and grep
      # if [ -x /usr/bin/dircolors ]; then
      #   test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
      #   alias ls='ls --color=auto'
      #   alias grep='grep --color=auto'
      # fi
      #
      # # Welcome message with some sparkle
      # echo "🌟 Welcome to your shell, cutie! Let's make some magic! 🌟"
    '';
  };
}
