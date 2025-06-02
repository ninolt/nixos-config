{ pkgs, lib, ... }: {
  programs.zsh = {
    enable = true;
    enableCompletion = true;

    shellAliases = {
      ll = "ls -la";
      space = "sudo du -h -d 1 . 2> /dev/null | sort -h";

      # Git
      gadd = "git add .";
      gst = "git status";
      gd = "f() { git diff \"$1\"; }; f";
      gsd = "f() { git diff --staged \"$1\"; }; f";

      # NixOS
      update = "sudo nixos-rebuild switch --flake /etc/nixos";
      delold = "sudo nix-collect-garbage --delete-older-than 10d";
      nrepo = "cd /etc/nixos";
      fupdate = "nrepo && gadd && update";
    };

    initContent = ''
      # Skipping a line before each zsh prompt
      PROMPT=$'\n'$PROMPT

      fastfetch
    '';

    history.size = 10000;

    oh-my-zsh = {
      enable = true;
      theme = "gallois";
    };
  };
}
