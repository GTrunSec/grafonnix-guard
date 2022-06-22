{
  config,
  lib,
  pkgs,
  ...
}: {
  microvm = {
    hypervisor = "qemu";

    mem = 4000;
    vcpu = 4;

    interfaces = [
      {
        type = "user";
        id = "vm-qemu-1";
        mac = "00:02:00:01:01:00";
      }
    ];
    volumes = [
      {
        mountPoint = "/var";
        image = "/tmp/user.img";
        size = 2048;
      }
    ];
  };

  microvm.shares = [
    {
      # use "virtiofs" for MicroVMs that are started by systemd
      proto = "9p";
      tag = "ro-store";
      source = "/nix/store";
      mountPoint = "/nix/.ro-store";
    }
  ];
}
