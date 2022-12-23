{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [./psql.nix];

  services.grafana = {
    enable = true;

    settings = {
      server = {
        addr = "0.0.0.0";
        domain = "localhost";
      };
      analytics.reporting_enabled = false;
      security = {
        adminUser = "admin";
        adminPassword = "admin";
      };
    };
  };
}
