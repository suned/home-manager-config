# home-manager-config

My home manager configuration for `nix`.

## Usage

1. Install `nix`.

2. Create Home Manager config directory and enter it:
   ```bash
   mkdir ~/.config/home-manager; cd ~/.config/home-manager
   ```
3. Run `flake init`:
   ```bash
   nix flake init --template github:suned/home-manager-config
   ```
4. Run `home-manager switch`:
   ```
   nix run home-manager/release-23.05 -- switch
   ```
   Its only necessary to use `nix run` the first time, subsequently `home-manager` is installed by the configuration.

## iTerm

Iterm configuration is saved under `dotfiles/iterm` but are not installed by home manager. Can be loaded in iTerm by going to `"Preferences" -> "General" -> "Preferences"`.
