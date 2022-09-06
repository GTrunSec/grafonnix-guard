{
  config,
  lib,
  pkgs,
  ...
}: {

  networking.firewall.allowedTCPPorts = [3000];
  networking.firewall.allowedUDPPorts = [3000];

  microvm.forwardPorts = [
    {
      from = "host";
      host.port = 6000;
      guest.port = 22;
    }
    # doesn't work for me.
    # ssh -L 3001:localhost:3000 root@localhost -p 6000 -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null
    {
      from = "host";
      host.port = 3000;
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
