{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [./psql.nix];

  services.grafana = {
    enable = true;
    addr = "localhost";
    analytics.reporting.enable = false;
    domain = "localhost";
    security = {
      adminUser = "testadmin";
      adminPassword = "snakeoilpwd";
    };
  };
}
