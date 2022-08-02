{
  inputs,
  cell,
}: let
  inherit (inputs.cells-lab.microvms.library) makeVM;
in {
  inherit (inputs) nixpkgs;
  dev = makeVM {
    channel = inputs.nixos.legacyPackages;
    module = _: {
      imports = [
        cell.nixosProfiles.default
        # cell.nixosProfiles.agent
        ./microvm.nix
        ./dev.nix
      ];
    };
  };
}
