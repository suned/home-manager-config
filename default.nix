{ user, nixpkgs, home-manager, nix-vscode-extensions, ... }:
let
  system = "x86_64-darwin";
  pkgs = nixpkgs.legacyPackages.${system};
  community-extensions = nix-vscode-extensions.extensions.${system};
  package = { packages.${system}.default = home-manager.defaultPackage.${system}; };
  home = { homeDirectory = "/Users/${user.username}"; username = user.username; };
in
{
  packages.${system}.default = home-manager.defaultPackage.${system};

  homeConfigurations.${user.username} = home-manager.lib.homeManagerConfiguration {
    inherit pkgs;

    modules = [ ./home.nix { inherit home; } ];
    extraSpecialArgs = {
      vscode-marketplace = community-extensions.vscode-marketplace;
      inherit user;
    };
  };
}
