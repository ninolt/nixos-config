{ pkgs, lib, ... }: {
  programs.alacritty = {
    enable = true;
    settings = {
      general = {
        import = [ "/home/nino/.config/nixos/home/alacritty/gruvbox_dark.toml" ];
      };

      font = {
        normal = {
          family = "Hack Nerd Font";
          style = "Regular";
        };
        size = 14.00;
      };

      window = {
        padding = {
          x = 20;
          y = 20;
        };
      };
    };
  };
}
