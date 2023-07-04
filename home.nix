{ user, pkgs, vscode-marketplace, ... }:

{
  home.stateVersion = "23.05";

  programs.home-manager.enable = true;
  nixpkgs.config.allowUnfreePredicate = (pkg: true);

  home.packages = [
    pkgs.iterm2
    (pkgs.nerdfonts.override { fonts = [ "Hack" ]; })
    pkgs.direnv
    pkgs.slack
    pkgs.pre-commit
    pkgs._1password
  ];

  programs.vscode = {
    enable = true;
    package = pkgs.vscode;
    extensions = with vscode-marketplace; [
      ms-python.python
      ms-python.mypy-type-checker
      bbenoist.nix
      usernamehw.errorlens
    ];
    userSettings = {
      "window.commandCenter" = false;
      "editor.fontFamily" = "Hack Nerd Font";
      "editor.fontSize" = 17;
      "editor.cursorStyle" = "block";
      "workbench.editor.showTabs" = false;
      "workbench.colorTheme" = "Solarized Light";
      "workbench.activityBar.visible" = false;
      "workbench.colorCustomizations" = {
        "editorCursor.foreground" = "#dc322f";
        "terminalCursor.foreground" = "#dc322f";
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
      gpu = "git push --set-upstream origin (eval \"git branch --show-current\")";
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
  };

  programs.bat = {
    enable = true;
    config = {
      theme = "Solarized (light)";
    };
  };
}
