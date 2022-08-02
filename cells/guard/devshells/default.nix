{
  inputs,
  cell,
}: let
  l = nixpkgs.lib // builtins;
  inherit (inputs) nixpkgs std;
  substituters = "--option extra-substituters https://microvm.cachix.org";
  keys = "--option extra-trusted-public-keys microvm.cachix.org-1:oXnBc6hRE3eX5rSYdRyMYXnfzcCxC7yKPTbZXALsqys=";
in
  l.mapAttrs (_: std.std.lib.mkShell) {
    default = {lib, ...}: {
      name = "Guard: grafonnix seucurity event dashboard";
      std.docs.enable = lib.mkForce true;
      imports = [
        inputs.cells-lab.main.devshellProfiles.default
        inputs.cells-lab.main.devshellProfiles.docs
      ];
      nixago = [
        inputs.cells-lab.main.nixago.treefmt
      ];
      commands = [
        {
          name = "build-microvm";
          command = "nix build .#x86_64-linux.grafana.microvmProfiles.dev.config.microvm.runner.qemu ${substituters} ${keys}";
        }
      ];
    };
  }
