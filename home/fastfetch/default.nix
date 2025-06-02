{ pkgs, lib, ... }: {
  programs.fastfetch = {
    enable = true;
    package = pkgs.fastfetchMinimal;
    settings = {
      logo = {
        type = "file";
        source = ./fabric-presents-red.txt;
      };

      display = {
        color = {
          keys = "light_blue";
          title = "blue";
          output = "white";
          separator = "light_blue";
        };
        separator = ": ";
      };

      modules = [
        {
          type = "title";
        }
        {
          type = "break";
        }
        {
          type = "os";
          key = "OS";
        }
        {
          type = "host";
          key = "Host";
        }
        {
          type = "cpu";
          key = "CPU";
        }
        {
          type = "datetime";
          key = "Date & Time";
          format = "{year}-{month-pretty}-{day-pretty} {hour-pretty}:{minute-pretty}:{second-pretty}";
        }
        {
          type = "uptime";
          key = "Uptime";
        }
        {
          type = "memory";
          key = "Memory";
        }
        {
          type = "swap";
          key = "Swap";
        }
        {
          type = "disk";
          key = "Disk";
          format = "{size-used} / {size-total} ({size-percentage})";
        }
        {
          type = "localip";
          key = "Local IP";
        }
        {
          type = "battery";
          key = "Battery";
        }
        {
          type = "break";
        }
        {
          type = "colors";
          symbol = "block";
          block = {
            width = 3;
            range = [ 0 15 ];
          };
        }
      ];
    };
  };
}
