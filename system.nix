{ config, pkgs, ... }: {
	age.secrets = {
		vps_domain = {
			file = ./secrets/vps_domain.age;
			owner = "nino";
		};

		ntfy_token = {
			file = ./secrets/ntfy_token.age;
			owner = "nino";
		};
	};

 	systemd.timers.system-reboot-ntfy = {
 		wantedBy = [ "timers.target" ];
 		timerConfig = {
 			OnBootSec = "3d";
 			Persistent = true;
 			Unit = "system-reboot-ntfy.service";
 		};
 	};

 	systemd.services.system-reboot-ntfy.serviceConfig = {
		User = "nino";
  		ExecStart = ''
    		${pkgs.bash}/bin/bash -c '${pkgs.curl}/bin/curl https://ntfy.$(cat ${config.age.secrets.vps_domain.path})/main -d "Your NixOS laptop has been up for more than 3 days. Time for a reboot ?" -H "Authorization: Bearer $(cat ${config.age.secrets.ntfy_token.path})" -H "Tags: sleepy"'
  		'';
	};
}
