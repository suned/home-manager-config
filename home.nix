{ user, ssh_config, pkgs, vscode-marketplace, config, ... }: {
  home.stateVersion = "23.05";


  programs.home-manager.enable = true;
  nixpkgs.config.allowUnfreePredicate = (pkg: true);

  home.packages = [
    pkgs.nerd-fonts.jetbrains-mono
    pkgs.python311
    pkgs.colima
    pkgs.docker
    pkgs.devbox
    pkgs.eza
    pkgs.apple-sdk
  ];

  programs.fish = {
    enable = true;

    shellInit = ''
      starship init fish | source
      direnv hook fish | source

      set -Ux DEVELOPER_DIR ${pkgs.apple-sdk}

      set -Ux DIRENV_LOG_FORMAT ""
    '';

    shellAbbrs = {
      # git
      gst = "git status";
      ga = "git add";
      gaa = "git add -A";
      gcm = "git commit -m";
      gp = "git push";
      gco = "git checkout";
      gpu = "git push --set-upstream origin (git branch --show-current)";
      gd = "git diff";
      gl = "git log";

      # nix
      nf = "nix flake";
      nfl = "nix flake lock";
      nfc = "nix flake check";
      ne = "env EDITOR=bat nix edit";
      nr = "nix repl";
      ns = "nix shell";

      # home-manager
      hms = "home-manager switch";

      # python
      p = "python";
      ip = "ipython";
      pru = "poetry run";

      # aws
      ap = "aws-profile";
      asl = "aws sso login";

      # terraform
      tf = "terraform";

      # vscode
      c = "code";

      # pre-commit
      pre = "pre-commit";
    };

    functions = {
      aws-profile = {
        body = "set -gx AWS_PROFILE $argv";
      };
      vcsv = {
        body = "column -t -s, $argv | less --header 1";
      };
    };

    shellAliases = {
      ls = "eza --icons -F -H --git --group-directories-first";
      g = "bf go";
    };

    plugins = [
      {
        name = "nix-env";
        src = pkgs.fetchFromGitHub {
          owner = "lilyball";
          repo = "nix-env.fish";
          rev = "7b65bd228429e852c8fdfa07601159130a818cfa";
          sha256 = "RG/0rfhgq6aEKNZ0XwIqOaZ6K5S4+/Y5EEMnIdtfPhk=";
        };
      }
    ];
  };

  home.file = {
    ".config/nix/nix.conf" = {
      source = ./dotfiles/nix/nix.conf;
    };

    ".config/fish/completions/aws-profile.fish" = {
      source = ./dotfiles/fish/completions/aws-profile.fish;
    };
  };
}
