{ pkgs, lib, ... }: {
  programs.librewolf = {
    enable = true;
    languagePacks = [ "fr-FR" "en-GB" ];

    settings = {
      "webgl.disabled" = false;
      "browser.theme.content-theme" = 0;
      "browser.theme.toolbar-theme" = 0;
      "privacy.clearOnShutdown.history" = false;
      "privacy.clearOnShutdown.cookies" = false;
    };
  };
}
