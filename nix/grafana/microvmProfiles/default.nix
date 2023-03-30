{
  inputs,
  cell,
}: let
  inherit (inputs.std.lib.ops) mkMicrovm;
in {
  dev =
    mkMicrovm
    ({config, ...}: {
      imports = [
        cell.nixosModules.default
        # cell.nixosProfiles.agent
        ./microvm.nix
        ./dev.nix
      ];
      config = {
        nixpkgs.pkgs = inputs.nixos.legacyPackages;
        documentation.enable = false;
      };
    });
}
