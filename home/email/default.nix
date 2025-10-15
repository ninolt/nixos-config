{ config, pkgs, lib, inputs, ... }:
{
	imports = [ inputs.agenix.homeManagerModules.default ];

	age.secrets.email_private_name = {
	    file = ../../secrets/email_private_name.age;
	};

	age.secrets.email_private_address = {
		file = ../../secrets/email_private_address.age;
	};

	age.secrets.email_private_signature = {
		file = ../../email_private_signature.age;
	};

	accounts.email.accounts = {
		"private" = {
			thunderbird.enable = true;
			primary = true;
			realName = builtins.readFile config.age.secrets.email_private_name.path;
			address = builtins.readFile config.age.secrets.email_private_address.path;
			signature = {
				text = builtins.readFile config.age.secrets.email_private_signature.path;
				showSignature = "append";
			};
		};
	};

	programs.thunderbird = {
		enable = true;
		profiles."nino" = {
			isDefault = true;
			accountsOrder = [
				"private"
			];
		};
	};
}
