{ inputs, ... }:
{
  flake.nixosModules.core = {
    imports = [ inputs.luciole.nixosModules.default ];

    programs.luciole.enable = true;

    xdg.mime.defaultApplications."inode/directory" = "dev.noctalia.luciole.desktop";

    preferences.binds."Mod+X".command = "luciole";
  };
}
