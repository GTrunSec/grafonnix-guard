{
  inputs,
  cell,
}: let
  inherit (inputs.cells-lab.microvms.lib) makeVM;
in {
  dev = makeVM {
    channel = inputs.nixos.legacyPackages;
    module = _: {
      imports = [
        {
          nix.registry = {
            nixpkgs.flake = inputs.nixos;
          };
        }
        cell.nixosProfiles.default
        # cell.nixosProfiles.agent
        ./microvm.nix
        ./dev.nix
      ];
    };
  };
}
