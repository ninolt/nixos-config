{ config, pkgs, lib, ... }: {
	programs.firefox = {
		enable = true;
		languagePacks = [ "fr" "en-GB" "en-US" ];

		policies = {
			DisableFirefoxStudies = true;
			DisableTelemetry = true;
      		DontCheckDefaultBrowser = true;
      		DisablePocket = true;
			OfferToSaveLogins = false;

			ExtensionSettings = {
				"uBlock0@raymondhill.net" = {
          			install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
          			installation_mode = "force_installed";
					private_browsing = true;
        		};

			 	"{08d5243b-4236-4a27-984b-1ded22ce01c3}" = {
          	 		install_url = "https://addons.mozilla.org/firefox/downloads/latest/gruvboxgruvboxgruvboxgruvboxgr/latest.xpi";
          	 		installation_mode = "force_installed";
			 		allowed_types = "theme";
			 	};

				"idcac-pub@guus.ninja" = {
					install_url = "https://addons.mozilla.org/firefox/downloads/latest/istilldontcareaboutcookies/latest.xpi";
					installation_mode = "force_installed";
					private_browsing = true;
				};

				"{446900e4-71c2-419f-a6a7-df9c091e268b}" = {
					install_url = "https://addons.mozilla.org/firefox/downloads/latest/bitwarden-password-manager/latest.xpi";
					installation_mode = "force_installed";
					default_area = "navbar";
				};

				"sponsorBlocker@ajay.app" = {
					install_url = "https://addons.mozilla.org/firefox/downloads/latest/sponsorblock/latest.xpi";
					installation_mode = "force_installed";
				};

				"deArrow@ajay.app" = {
					install_url = "https://addons.mozilla.org/firefox/downloads/latest/dearrow/latest.xpi";
					installation_mode = "force_installed";
				};

				"dfyoutube@example.com" = {
					install_url = "https://addons.mozilla.org/firefox/downloads/latest/df-youtube/latest.xpi";
					installation_mode = "force_installed";
				};
			};
		};

		profiles.default = {
			name = "default";
			# Adding Arkenfox's user.js file, then overriding with my own config
			extraConfig = ''
      			${builtins.readFile (pkgs.fetchurl {
    				url = "https://raw.githubusercontent.com/arkenfox/user.js/9103afafff2b5287b495c1a1268968fdb447d66f/user.js";
    				sha256 = "16nxw0l65vdaafrspirp6zshhp85600lr51szkfasa8pfivg9k7x";
				})}
      	  		${builtins.readFile ./user-overrides.js}
      		'';

			search = {
				default = "ddg";
				force = true;
			};
		};
	};
}
