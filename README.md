# home-manager-config

My home manager configuration for `nix`.

## Usage

1. Install `nix`.

2. Add a `flake.nix` to `~/.config/home-manager` with this content
   ```nix
   {
    description = "Home Manager configuration";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
        nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";
        home-manager = {
            url = "github:nix-community/home-manager";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        home-manager-config = {
            url = "github:suned/home-manager-config";
            flake = false;
        };
    };

    outputs =
        { nixpkgs, home-manager, nix-vscode-extensions, home-manager-config, ... }:
            let
                user = { username = "your.username"; email = "your.email@host.com"; };
            in import home-manager-config
                {
                    inherit user nixpkgs nix-vscode-extensions home-manager;
                };
    }

   ```
3. Run `cd ~/.config/home-manager; nix run . switch` (on subsequent changes `home-manager switch` may be used since home manager is installed and managed by itself after first initialization).
4. If making changes:
    1. Clone this repo and make desired changes.
    2. Change the url of `home-manager-config` to local path
    3. Run `nix flake update`
    4. Run `home-manager switch`
