{ user, ssh_config, nixpkgs, home-manager, system, ... }:
let
  pkgs = nixpkgs.legacyPackages.${system};
  home = { homeDirectory = "/Users/${user.username}"; username = user.username; };
in
home-manager.lib.homeManagerConfiguration {
  inherit pkgs;

  modules = [ ./home.nix { inherit home; } ];
  extraSpecialArgs = {
    inherit user ssh_config;
  };
}
