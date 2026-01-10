{
  flake.nixosModules.core = {
    services.openssh.enable = true;

    programs.ssh.extraConfig = ''
      Host *
        IdentityAgent ~/.1password/agent.sock
    '';

    preferences.persist.home.directories = [ ".ssh" ];
  };
}
