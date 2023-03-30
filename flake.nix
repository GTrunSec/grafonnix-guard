{
  inputs = {
    nixpkgs.follows = "std-ext/nixpkgs";
    std-ext.url = "github:GTrunSec/std-ext";
    std-ext.inputs.std.follows = "std";

    std.url = "github:divnix/std";
    std.inputs.microvm.follows = "microvm";
    microvm.url = "github:astro/microvm.nix";

    grafonnix.url = "github:divnix/grafonnix";
  };

  inputs = {
    nixos.follows = "std-ext/nixos";
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

        (functions "nixosModules")

        (microvms "microvmProfiles")

        (functions "packages")

        (functions "overlays")
      ];
    } {
      devShells = inputs.std.harvest inputs.self ["guard" "devshells"];
      nixosConfigurations = inputs.std.harvest inputs.self ["grafana" "microvmProfiles"];
    };
}
