{
  config,
  lib,
  pkgs,
  ...
}: {
  networking.hostName = "grafana-dev";

  users.users.root.password = "";

  services.openssh = {
    enable = true;
    permitRootLogin = "yes";
  };
}
