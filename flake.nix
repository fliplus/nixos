{
  description = "A very basic flake";

  outputs =
    { self, ... }@args:
    let
      inputs = (import ./.tack) { overrides = args.tackOverrides or { }; };
      inherit (inputs.nixpkgs.lib.fileset) toList fileFilter;
      import-tree = path: toList (fileFilter (file: file.hasExt "nix") path);
    in
    inputs.flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "x86_64-linux" ];
      imports = import-tree ./modules;
    };
}
