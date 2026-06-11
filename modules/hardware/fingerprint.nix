{
  flake.nixosModules.laptop = {
    services.fprintd.enable = true;

    preferences.persist.root.directories = [ "/var/lib/fprint" ];
  };
}
