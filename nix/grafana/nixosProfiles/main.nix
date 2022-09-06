{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [./psql.nix];

  services.grafana = {
    enable = true;
    addr = "0.0.0.0";
    analytics.reporting.enable = false;
    domain = "localhost";
    security = {
      adminUser = "testadmin";
      adminPassword = "snakeoilpwd";
    };
  };
}
