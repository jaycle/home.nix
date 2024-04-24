{
  description = "Home Manager configuration of jayson";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "nixpkgs/nixos-23.11";
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    kickstart-nvim = {
      flake = true;
      url = "github:jaycle/kickstart-nix.nvim";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
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
        };
      };
    in {
      formatter.${system} = nixpkgs.legacyPackages.${system}.nixfmt;
      homeConfigurations."jayson" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          ({ config, pkgs, ... }: {
            nixpkgs.overlays =
              [ inputs.kickstart-nvim.overlays.default overlay-unstable ];
          })
          ./home.nix
        ];
        extraSpecialArgs = { inherit inputs; };
      };
    };
}
