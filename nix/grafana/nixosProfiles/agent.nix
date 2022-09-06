{
  config,
  lib,
  pkgs,
  ...
}: {
  services.grafana-agent = {
    enable = true;
  };
}
