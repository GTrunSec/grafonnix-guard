{
  inputs = {
    nixpkgs.follows = "cells-lab/nixpkgs";

    cells-lab.url = "github:GTrunSec/cells-lab";

    std.follows = "cells-lab/std";
    grafonnix.url = "github:divnix/grafonnix";
    POP.follows = "grafonnix/POP";
  };

  inputs = {
    # nixos.url = "github:NixOS/nixpkgs/nixos-22.05";
    nixos.follows = "cells-lab/nixos";
    microvm.url = "github:astro/microvm.nix";
  };

  outputs = {std, ...} @ inputs:
    std.growOn {

      inherit inputs;

      cellsFrom = ./nix;

      cellBlocks = [
        (std.blockTypes.installables "packages")

        (std.blockTypes.functions "devshellProfiles")
        (std.blockTypes.devshells "devshells")

        (std.blockTypes.data "dashboards")

        (std.blockTypes.runnables "entrypoints")

        (std.blockTypes.functions "library")

        (std.blockTypes.functions "nixosProfiles")

        (std.blockTypes.microvms "microvmProfiles")

        (std.blockTypes.functions "packages")

        (std.blockTypes.functions "overlays")
      ];
    } {
      devShells = inputs.std.harvest inputs.self ["guard" "devshells"];
      nixosConfigurations = inputs.std.harvest inputs.self ["grafana" "microvmProfiles"];
    };
}
