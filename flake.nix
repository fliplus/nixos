{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    flake-parts.url = "github:hercules-ci/flake-parts";

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    impermanence.url = "github:nix-community/impermanence";

    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";

    hjem = {
      url = "github:feel-co/hjem";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hjem-rum = {
      url = "github:snugnug/hjem-rum";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.hjem.follows = "hjem";
    };

    nvf = {
      url = "github:notashelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    noctalia = {
      url = "github:noctalia-dev/noctalia-shell/legacy-v4";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    mac-style-plymouth = {
      url = "github:SergioRibera/s4rchiso-plymouth-theme";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser.url = "github:0xc000022070/zen-browser-flake";

    spicetify-nix.url = "github:Gerg-L/spicetify-nix";
    millennium.url = "github:SteamClientHomebrew/Millennium/next?dir=packages/nix";
  };

  outputs =
    inputs:
    let
      inherit (inputs.nixpkgs.lib.fileset) toList fileFilter;
      import-tree = path: toList (fileFilter (file: file.hasExt "nix") path);
    in
    inputs.flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "x86_64-linux" ];
      imports = import-tree ./modules;
    };
}
