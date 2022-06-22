{
  config,
  lib,
  pkgs,
  ...
}: {
  postgresql = {
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
    systemd.services.grafana.after = ["postgresql.service"];
  };
}
