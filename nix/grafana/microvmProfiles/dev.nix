{
  config,
  lib,
  pkgs,
  ...
}: {
  networking.hostName = "grafana-dev";

  system.stateVersion = "22.05";

  users.users.root.password = "";

  services.openssh = {
    enable = true;
    permitRootLogin = "yes";
  };
}
