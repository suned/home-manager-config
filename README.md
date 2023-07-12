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
   nix --extra-experimental-features "nix-command flakes" flake init --template github:suned/home-manager-config
   ```
   `--extra-experimental-features` is only necessary until the home manager configuration has been applied, the configuration
   adds `~/.config/nix/nix.conf` that enables nix-command and flakes.
4. Run `home-manager switch`:
   ```
   nix --extra-experimental-features "nix-command flakes" run home-manager/release-23.05 -- switch
   ```
   Its only necessary to use `nix run` the first time, subsequently `home-manager` is installed by the configuration.


## Remote builds
SSH and nix configuration is added to enable remote builds via [LnL7/nix-docker](https://github.com/LnL7/nix-docker#running-as-a-remote-builder), e.g for building docker images in nix on macos.

The configuration adds:
- An ssh host entry to `~/.ssh/config` for `nix-docker`
- A key to `~/.ssh` for authenticating with the container
- Configuration to `~/.config/nix/nix.conf` for the container

 Once the configuration has been applied you may run:

```bash
docker run --restart always --name nix-docker -d -p 3022:22 lnl7/nix:ssh
```
(docker is not installed by the home-manager configuration but must be installed separately)

Builds for `x86_64-linux` can now be executed in the docker container.


## Fonts

The configuration installs the hack font with ligatures downloaded from [pyrho/hack-font-ligature-nerd-font](https://github.com/pyrho/hack-font-ligature-nerd-font).

## iTerm

Iterm configuration is saved under `dotfiles/iterm` but are not installed by home manager. Can be loaded in iTerm by going to `"Preferences" -> "General" -> "Preferences"`.
