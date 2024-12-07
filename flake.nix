{
  description = "Home Manager configuration of jayson";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # kickstart-nvim = {
    #   url = "github:nix-community/kickstart-nix.nvim";
    #   inputs.nixpkgs.follows = "nixpkgs-unstable";
    # };
    kickstart-nvim = {
      url = "path:/home/jayson/projects/kickstart-nvim/";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    # kickstart-nvim = { url = "github:jaycle/kickstart-nix.nvim"; };
    wezterm.url = "github:wez/wezterm?dir=nix";
  };

  outputs = inputs@{ nixpkgs, nixpkgs-unstable, home-manager, ... }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      overlay-unstable = final: prev: {
        unstable = import nixpkgs-unstable {
          inherit system;
          config.allowUnfree = true;
          overlays = [ inputs.kickstart-nvim.overlays.default ];
        };
      };
    in {
      formatter.${system} = nixpkgs.legacyPackages.${system}.nixfmt;
      homeConfigurations."jayson" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          ({ config, pkgs, ... }: {
            nixpkgs.overlays =
              [ overlay-unstable ];
          })
          ./home.nix
        ];
        extraSpecialArgs = { inherit inputs; };
      };
    };
}
