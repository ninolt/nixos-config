{ config, lib, ... }:

let
  # Chemin vers le fichier de configuration généré par NixOS
  emailConfigFile = config.accounts.email.accounts.private.settings.configFile;

  # Remplacez les placeholders par les secrets
  scalpelTransformations = {
    "PRIVATE_NAME".secret = config.age.secrets.my-secret.path;
    "PRIVATE_ADDRESS".secret = config.age.secrets.my-other-secret.path;
    "PRIVATE_SIGNATURE".secret = config.age.secrets.my-another-secret.path;
  };
in
{
  scalpel.trafos."email-config" = {
    source = emailConfigFile;
    matchers = scalpelTransformations;
    owner = "user";
    group = "group";
    mode = "0440";
  };
}

