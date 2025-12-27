{ inputs, pkgs, ... }: 

let
  spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
in
{
  imports = [
    inputs.spicetify-nix.homeManagerModules.default
  ];

  programs.spicetify = {
    enable = true;

    theme = spicePkgs.themes.text;
    colorScheme = "Gruvbox";

    enabledExtensions = with spicePkgs.extensions; [
      shuffle
      hidePodcasts
      adblock
	  keyboardShortcut
      beautifulLyrics
    ];

	enabledCustomApps = with spicePkgs.apps; [
		newReleases
	];
  };
}
