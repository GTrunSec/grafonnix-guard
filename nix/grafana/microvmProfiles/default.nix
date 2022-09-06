{
  inputs,
  cell,
}: let
  inherit (inputs.cells-lab.microvms.library) makeVM;
in {
  inherit (inputs) nixpkgs;
  inherit (inputs) self;
  dev = makeVM {
    channel = inputs.nixos.legacyPackages;
    module = _: {
      imports = [
        {
          nix.registry = {
            microvm.flake = inputs.self;
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
