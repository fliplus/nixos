{ lib, ... }:
{
  flake.nixosModules.desktop =
    { pkgs, ... }:
    let
      ns2pro-bridge = pkgs.rustPlatform.buildRustPackage (finalAttrs: {
        pname = "ns2pro-bridge";
        version = "0.4.1";

        src = pkgs.fetchFromGitHub {
          owner = "Cookiekira";
          repo = "ns2pro-bridge";
          tag = "v${finalAttrs.version}";
          hash = "sha256-DVJDHZWEXoAjhj7BN8fpRUl5C9I3IO/mjPyedVLZCs8=";
        };

        cargoHash = "sha256-Z94VCppdEw2SRo17Qab3AoOBB2TO3HdxWTjitrLhY5M=";
        cargoBuildFlags = [
          "-p"
          "ns2pro-bridge"
        ];

        doCheck = false;

        meta.mainProgram = "ns2pro-bridge";
      });
    in
    {
      environment.systemPackages = [ ns2pro-bridge ];

      boot.kernelModules = [ "vhci-hcd" ];

      systemd.services.ns2pro-bridge = {
        description = "Switch 2 Pro Controller Bluetooth bridge";

        after = [ "bluetooth.service" ];
        wants = [ "bluetooth.service" ];
        wantedBy = [ "multi-user.target" ];

        serviceConfig = {
          ExecStart = lib.getExe ns2pro-bridge;

          Restart = "on-failure";
          RestartSec = 3;
        };
      };

      preferences.persist.root.directories = [ "/var/lib/ns2pro-bridge" ];
    };
}
