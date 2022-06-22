{
  config,
  lib,
  pkgs,
  ...
}: {
  microvm.forwardPorts = [
    {
      from = "host";
      host.port = 6000;
      guest.port = 22;
    }
    {
      from = "host";
      host.port = 3001;
      guest.port = 3000;
    }
  ];
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
        image = "/tmp/user-${config.networking.hostName}.img";
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
