{
  description = "Home Manager configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, nix-vscode-extensions, ... }:
    {
      formatter.x86_64-darwin = nixpkgs.legacyPackages.x86_64-darwin.nixpkgs-fmt;
      mkConfiguration = user: import ./mkConfiguration.nix { inherit user nixpkgs nix-vscode-extensions home-manager; };
      templates.default = {
        path = ./template;
        description = "My Home Manager configuration";
      };
    };
}
