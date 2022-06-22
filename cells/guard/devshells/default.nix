{
  inputs,
  cell,
}: let
  l = nixpkgs.lib // builtins;
  inherit (inputs) nixpkgs std;
in
  l.mapAttrs (_: std.std.lib.mkShell) {
    default = {lib, ...}: {
      name = "Guard: grafonnix seucurity event dashboard";
      std.docs.enable = lib.mkForce true;
      imports = [
        inputs.cells-lab.main.devshellProfiles.default
        inputs.cells-lab.main.devshellProfiles.docs
      ];
    };
  }
