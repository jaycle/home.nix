{ inputs, nixpkgs, config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "jayson";
  home.homeDirectory = "/home/jayson";
  nixpkgs.config.allowUnfreePredicate = _: true;

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    foot
    firefox
    # neovim
    unstable.obsidian
    nvim-pkg
    kitty
    git-credential-oauth
    unstable.ticktick
    unstable._1password-gui
    freecad
    unstable.beeper
    unstable.discord
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. If you don't want to manage your shell through Home
  # Manager then you have to manually source 'hm-session-vars.sh' located at
  # either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/jayson/etc/profile.d/hm-session-vars.sh
  #

  # programs.neovim = {
  #   enable = true;
  #   defaultEditor = true;
  #   withPython3 = true;
  #   plugins = with pkgs.vimPlugins; [ 
  #     nvim-treesitter.withAllGrammars
  #     vim-nix 
  #     {
  #       plugin = telescope-nvim;
  #       type = "lua";
  #       config = ''
  #         require("config.telescope")
  #       '';
  #     }
  #   ];
  # };
  # home.file = {
  #   ".config/nvim" = {
  #     recursive = true;
  #     source = config/nvim;
  #   };
  # };

  programs.ssh = { enable = true; };

  programs.tmux = {
    enable = true;
    keyMode = "vi";
    prefix = "C-a";
  };

  programs.opam = { enable = true; };

  programs.git = {
    enable = true;
    userName = "Jayson Cleary";
    userEmail = "jayson.cleary@gmail.com";
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" ];
    };
    initExtra = ''
      unsetopt BEEP
    '';
  };

  programs.wezterm = {
    enable = true;
    package = inputs.wezterm.packages.${pkgs.system}.default;
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
