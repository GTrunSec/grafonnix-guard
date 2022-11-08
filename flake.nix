{
  inputs = {
    nixpkgs.follows = "cells-lab/nixpkgs";
    cells-lab.url = "github:GTrunSec/cells-lab";

    std.follows = "cells-lab/std";
    grafonnix.url = "github:divnix/grafonnix";
    POP.follows = "grafonnix/POP";
  };

  inputs = {
    nixos.follows = "cells-lab/nixos";
    microvm.url = "github:astro/microvm.nix";
  };

  outputs = {std, ...} @ inputs:
    std.growOn {

      inherit inputs;

      cellsFrom = ./nix;

      cellBlocks = with std.blockTypes;[
        (installables "packages")

        (functions "devshellProfiles")
        (devshells "devshells")

        (data "dashboards")

        (runnables "entrypoints")

        (functions "lib")

        (functions "nixosProfiles")

        (microvms "microvmProfiles")

        (functions "packages")

        (functions "overlays")
      ];
    } {
      devShells = inputs.std.harvest inputs.self ["guard" "devshells"];
      nixosConfigurations = inputs.std.harvest inputs.self ["grafana" "microvmProfiles"];
    };
}
