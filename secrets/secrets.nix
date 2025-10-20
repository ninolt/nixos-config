let
  user = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJmcCC9ljCBfEi5FdloKOuaZ0uBvONeMbDPsUqjiCEZY";
  users = [ user ];

  system = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMtOOv/a8Xfoqv4ghNFp566Eovjy0K8DwPhcIAFnbLaR";
  systems = [ system ];
in
{
  "email_private_address.age".publicKeys = users ++ systems;
  "email_private_name.age".publicKeys = users ++ systems;
  "email_private_signature.age".publicKeys = users ++ systems;

  "vps_domain.age".publicKeys = users ++ systems;

  "ntfy_token.age".publicKeys = users ++ systems;
}
