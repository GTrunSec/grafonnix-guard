{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    cells-lab.url = "github:GTrunSec/cells-lab";

    yants.follows = "cells-lab/yants";
    std.follows = "cells-lab/std";
    data-merge.follows = "cells-lab/data-merge";
    grafonnix.url = "github:divnix/grafonnix";
    POP.follows = "grafonnix/POP";
  };

  inputs = {
    nixos.url = "github:NixOS/nixpkgs/nixos-22.05";
    microvm.url = "github:astro/microvm.nix";
  };

  outputs = {std, ...} @ inputs:
    std.growOn {
      inherit inputs;
      cellsFrom = ./cells;
      organelles = [
        (std.installables "packages")

        (std.functions "devshellProfiles")
        (std.devshells "devshells")

        (std.data "dashboards")

        (std.runnables "entrypoints")

        (std.functions "library")

        (std.functions "nixosProfiles")

        (inputs.cells-lab.microvms "microvmProfiles")

        (std.functions "packages")

        (std.functions "overlays")
      ];
    } {
      devShells = inputs.std.harvest inputs.self ["guard" "devshells"];
    };
}
