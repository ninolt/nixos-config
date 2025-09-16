{ pkgs, lib, ... }: {
  services.gnome-keyring.enable = true;
  home.packages = [ pkgs.gcr ]; # Provides org.gnome.keyring.SystemPrompter
  services.nextcloud-client = {
    enable = true;
    
    startInBackground = true;
  };
}
