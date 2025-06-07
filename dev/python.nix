{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    uv
	python313Packages.python-lsp-server
  ];
}
