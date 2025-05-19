{ pkgs, lib, ... }: {
  programs.alacritty = {
    enable = true;
    settings = {
      general = {
        import = [ "/home/nino/.config/nixos/home/alacritty/gruvbox_dark.toml" ];
      };
    };
  };
}
