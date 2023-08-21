{ user, ssh_config, pkgs, vscode-marketplace, ... }: {
  home.stateVersion = "23.05";


  programs.home-manager.enable = true;
  nixpkgs.config.allowUnfreePredicate = (pkg: true);

  home.packages = [
    pkgs.iterm2
    (pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
    pkgs.pre-commit
    pkgs.nil
    pkgs.nixpkgs-fmt
    pkgs.hadolint
    pkgs.awscli2
    pkgs.docker
    pkgs.python311
    pkgs.direnv
  ];

  programs.vscode = {
    enable = true;
    package = pkgs.vscode;
    extensions = with vscode-marketplace; [
      ms-python.python
      matangover.mypy
      ms-azuretools.vscode-docker
      usernamehw.errorlens
      jnoortheen.nix-ide
      exiasr.hadolint
      hashicorp.terraform
      tamasfe.even-better-toml
      ms-python.black-formatter
      ms-python.pylint
    ];
    userSettings = {
      "window.commandCenter" = false;
      "editor.fontFamily" = "JetBrainsMono Nerd Font";
      "editor.fontLigatures" = "'zero'";
      "editor.fontSize" = 13;
      "editor.cursorStyle" = "block";
      "editor.formatOnSave" = true;
      "workbench.editor.showTabs" = false;
      "workbench.colorTheme" = "Solarized Light";
      "workbench.activityBar.visible" = false;
      "workbench.colorCustomizations" = {
        "editorCursor.foreground" = "#dc322f";
        "terminalCursor.foreground" = "#dc322f";
      };
      "nix.enableLanguageServer" = true;
      "nix.serverPath" = "nil";
      "nix.serverSettings" = {
        "nil" = {
          "formatting" = {
            "command" = [ "nixpkgs-fmt" ];
          };
        };
      };
      "mypy.runUsingActiveInterpreter" = true;
      "[python]" = {
        "editor.defaultFormatter" = "ms-python.black-formatter";
      };
    };
    keybindings = [
      {
        key = "cmd+k cmd+r";
        command = "git.revertSelectedRanges";
      }
      {
        key = "cmd+k cmd+d";
        command = "editor.action.revealDefinition";
      }
      {
        key = "cmd+k cmd+t";
        command = "editor.action.insertSnippet";
        when = "editorTextFocus && editorLangId == python";
        args = {
          snippet = "reveal_type($TM_SELECTED_TEXT)";
        };
      }
    ];
    languageSnippets = {
      python = {
        ipdb = {
          body = [
            "import ipdb"
            "ipdb.set_trace()"
          ];
          prefix = [ "ip" ];
        };
      };
    };
  };

  programs.fish = {
    enable = true;

    shellInit = ''
      starship init fish | source
      direnv hook fish | source

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

      # home-manager
      hms = "home-manager switch";

      # python
      p = "python";
      ip = "ipython";
      pru = "poetry run";

      # aws
      ap = "aws-profile";

      # terraform
      tf = "terraform";
    };

    functions = {
      aws-profile = {
        body = "set -gx AWS_PROFILE $argv";
      };
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

  programs.starship = {
    enable = true;
    settings = {
      add_newline = false;
    };
  };

  programs.git = {
    enable = true;
    userName = "suned";
    userEmail = user.email;
    ignores = [
      ".envrc"
      ".direnv"
    ];

    delta = {
      enable = true;
      options = {
        syntax-theme = "Solarized (light)";
        side-by-side = true;
        navigate = true;
      };
    };
  };

  programs.bat = {
    enable = true;
    config = {
      theme = "Solarized (light)";
    };
  };

  home.file = {
    ".ssh/config" = {
      text = ''
        ${builtins.readFile ./dotfiles/ssh/config}
        ${ssh_config}
      '';
    };

    ".config/nix/nix.conf" = {
      source = ./dotfiles/nix/nix.conf;
    };

    ".config/fish/completions/aws-profile.fish" = {
      source = ./dotfiles/fish/completions/aws-profile.fish;
    };

    ".config/direnv/direnv.toml" = {
      source = ./dotfiles/direnv/direnv.toml;
    };
  };
}
