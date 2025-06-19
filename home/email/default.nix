{ pkgs, lib, ... }:
{
	age.secrets = {
		email_private_name.path = ../../secrets/email_private_name.age;
		email_private_address.path = ../../secrets/email_private_address.age;
		email_private_signature.path = ../../secrets/email_private_signature.age;
	};

	accounts.email.accounts = [
		{
			name = "private";
			thunderbird.enable = true;
			realName = "!!EMAIL_PRIVATE_NAME!!";
			address = "!!EMAIL_PRIVATE_ADDRESS!!";
			signature = {
				text = "!!EMAIL_PRIVATE_SIGNATURE!!";
				showSignature = "append";
			};
		}
	];

	programs.thunderbird.enable = true;
}
