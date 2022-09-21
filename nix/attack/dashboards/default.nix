{
  inputs,
  cell,
}: let
  inherit (inputs.grafonnix.lib) annotation;
  l = inputs.nixpkgs.lib // inputs.grafonnix.lib // builtins // inputs.POP.lib;
in {
  adds = import ./adds.nix { lib = l; };
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
