{ pkgs, lib, ... }: {
  home.packages = [ pkgs.pavucontrol ];

  programs.waybar = {
    enable = true;

    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 40;

        modules-center = [ "sway/workspaces" ];
        modules-right = [ "network" "cpu" "memory" "pulseaudio" "battery" "clock" ];

        "sway/workspaces" = {
          disable-scroll = true;
          all-outputs = true;
        };

        "network" = {
          format-wifi = "  {essid}";
          format-ethernet = "  Ethernet";
          format-disconnected = "  Disconnected";
          tooltip-format-wifi = "{essid} ({signalStrength}%)";
          tooltip-format-ethernet = "{ifname}";
          tooltip-format-disconnected = "Disconnected";
          on-click = "alacritty -e nmtui";
        };

        "cpu" = {
          interval = 5;
          format = "  {usage}%";
          tooltip = false;
        };

        "memory" = {
          interval = 5;
          format = "󰘚  {percentage}%";
          tooltip-format = "{used:0.1f}GB / {total:0.1f}GB";
        };

        "pulseaudio" = {
          format = "{icon}  {volume}%";
          format-bluetooth = "  {volume}%";
          format-muted = "  {volume}%";
          format-icons = {
            default = [ "" "" ];
          };
          on-click = "pactl set-sink-mute @DEFAULT_SINK@ toggle";
          on-click-right = "pavucontrol";
          on-scroll-up = "pactl set-sink-volume @DEFAULT_SINK@ +5%";
          on-scroll-down = "pactl set-sink-volume @DEFAULT_SINK@ -5%";
        };

        "battery" = {
          interval = 30;
          states = {
            "good" = 95;
            "warning" = 30;
            "critical" = 20;
          };
          format = "{icon}  {capacity}%";
          format-charging = "  {capacity}%";
          format-icons = [ "" "" "" "" "" ];
        };

        "clock" = {
          interval = 5;
          format = "  {:%H:%M}";
          timezone = "Europe/Paris";
          tooltip-format = "<tt>{calendar}</tt>";
          calendar.format.today = "<b>{}</b>";
        };
      };
    };

    style = ''
      * {
        font-family: "Hack Nerd Font";
        font-size: 13px;
        min-height: 0;
      }

      window#waybar {
        background: transparent;
      }

      #workspaces,
      #network,
      #cpu,
      #memory,
      #pulseaudio,
      #battery,
      #clock {
        margin: 5px 4px;
        padding: 0 6px;
        border-radius: 8px;
        color: #282828;
      }

      #workspaces {
        padding: 0 4px;
        background-color: transparent;
      }

      #workspaces button {
        min-width: 28px;
        padding: 0;
        color: #a89984;
        background: transparent;
      }

      #workspaces button.focused {
        color: #282828;
        background-color: #fbf1c7;
        border-radius: 6px;
      }

      #workspaces button.urgent {
        color: #282828;
        background-color: #fb4934;
        border-radius: 6px;
      }

      #network,
      #cpu,
      #memory,
      #pulseaudio,
      #battery,
      #clock {
        min-width: 70px;
      }

      #network {
        background-color: #8ec07c;
      }

      #cpu {
        background-color: #fe8019;
      }

      #memory {
        background-color: #fabd2f;
      }

      #pulseaudio {
        background-color: #83a598;
      }

      #battery {
        background-color: #b8bb26;
      }

      #battery.warning {
        background-color: #fabd2f;
      }

      #battery.critical {
        background-color: #fb4934;
        color: #ebdbb2;
      }

      #clock {
        background-color: #d3869b;
      }
    '';
  };
}
