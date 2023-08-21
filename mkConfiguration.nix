{ user, ssh_config, nixpkgs, home-manager, nix-vscode-extensions, ... }:
let
  system = "aarch64-darwin";
  pkgs = nixpkgs.legacyPackages.${system};
  community-extensions = nix-vscode-extensions.extensions.${system};
  home = { homeDirectory = "/Users/${user.username}"; username = user.username; };
in
home-manager.lib.homeManagerConfiguration {
  inherit pkgs;

  modules = [ ./home.nix { inherit home; } ];
  extraSpecialArgs = {
    vscode-marketplace = community-extensions.vscode-marketplace;
    inherit user ssh_config;
  };
}
