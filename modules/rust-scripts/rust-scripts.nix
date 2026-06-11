{
  flake.nixosModules.core =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        (rustPlatform.buildRustPackage {
          pname = "scripts";
          version = "0.1.0";
          src = ./.;
          cargoLock.lockFile = ./Cargo.lock;
        })
      ];
    };
}
