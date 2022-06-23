{
  inputs,
  cell,
}: let
  inherit (inputs.grafonnix.lib) annotation;
in {
  datasource =
    (annotation.datasource {
      name = "newAdv";
      datasource = "-- Grafana --";
      expr = "advExpr";
      enable = true;
      hide = true;
      iconColor = "rgba(0, 211, 255, 1)";
      tags = ["alert" "attack"];
      type = "dashboard";
      builtIn = 1;
    })
    .__unpop__;
}
