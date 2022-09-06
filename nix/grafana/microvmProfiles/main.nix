{
  config,
  lib,
  pkgs,
  ...
}: {
  services.grafana = {
    enable = true;
    addr = "localhost";
    port = 3000;
    # analytics.reporting.enable = false;
    domain = "localhost";
    security = {
      adminUser = "admin";
      adminPassword = "password";
    };
  };

  services.grafana.database = {
    host = "127.0.0.1:5432";
    user = "grafana";
  };
  services.postgresql = {
    enable = true;
    ensureDatabases = ["grafana"];
    ensureUsers = [
      {
        name = "grafana";
        ensurePermissions."DATABASE grafana" = "ALL PRIVILEGES";
      }
    ];
  };
}
