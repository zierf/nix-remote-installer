# nixos-anywhere

Remote installation via      [nixos-anywhere](https://github.com/nix-community/nixos-anywhere) and [disko](https://github.com/nix-community/disko).

## Install NixOS on Remote Host

```SH
nix run github:nix-community/nixos-anywhere/bc77bd1cca884bacba44058659d44141bea53a03 -- --flake ${PWD}#vmd38860.contaboserver.net root@192.168.100.123
```

## Errors

- [sshKeyDir: unbound variable](https://github.com/nix-community/nixos-anywhere/issues/376#issuecomment-2342492455)

### DHCP changes IP

Can't reconnect after starting the `kexec` installer:

```SH
ssh: connect to host 192.168.100.123 port 22: No route to host
```

Add previous ip address to network interface:

```SH
ip addr add 192.168.100.123 dev enp1s0
```
