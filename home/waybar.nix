{ pkgs, lib, ... }: {
  programs.waybar = {
    enable = true;

    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 30;

        modules-center = [ "sway/workspaces" ];
        modules-right = [ "pulseaudio" "battery" "clock" ];

        "sway/workspaces" = {
          disable-scroll = true;
          all-outputs = true;
        };

        "pulseaudio" = {
          format = "{volume}%";
          format-bluetooth = "{volume}%";
          format-muted = "{volume}%";
        };

        "battery" = {
          interval = 30;
          states = {
            "good" = 95;
            "warning" = 30;
            "critical" = 20;
          };
          format = "{capacity}%";
        };

        "clock" = {
          interval = 5;
          format = "{:%H:%M}";
          timezone = "Europe/Paris";
          tooltip-format = "<tt>{calendar}</tt>";
          calendar.format.today = "<b>{}</b>";
        };
      };
    };
  };
}
