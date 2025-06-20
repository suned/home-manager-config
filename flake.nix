{
  description = "Home Manager configuration";

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { flake-utils, nixpkgs, home-manager, ... }: flake-utils.lib.eachDefaultSystem
    (system:
      {
        formatter = nixpkgs.legacyPackages.${system}.nixpkgs-fmt;
        mkConfiguration = { user, ssh_config ? [ ] }: import ./mkConfiguration.nix { inherit user ssh_config nixpkgs home-manager system; };
      }
    ) // {
    templates.default = {
      path = ./template;
      description = "My Home Manager configuration";
    };
  };
}
