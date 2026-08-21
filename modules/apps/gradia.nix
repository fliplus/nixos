{ lib, ... }:
{
  flake.nixosModules.core =
    { pkgs, ... }:
    let
      gradiaScript = pkgs.writeShellScriptBin "niri-gradia-screenshot" ''
        wl-paste | gradia
      '';
    in
    {
      environment.systemPackages = with pkgs; [
        gradia
        wl-clipboard
      ];

      preferences.binds."Mod+Shift+E".command = lib.getExe gradiaScript;
    };
}
