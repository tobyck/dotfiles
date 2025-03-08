{
	description = "Toby's nix configurations";

	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

		nix-darwin = {
			url = "github:LnL7/nix-darwin";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";

		home-manager = {
			url = "github:nix-community/home-manager";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		apple-silicon = {
			url = "github:tpwrules/nixos-apple-silicon/c5f944f49a052232015bb3c03524b69e3fdd2aa4";
			# inputs.nixpkgs.follows = "nixpkgs";
		};

		/* hyprland = {
			type = "git";
			url = "https://github.com/hyprwm/Hyprland";
			rev = "0c513ba91bd73106be99e35b1a020d24e5ae874a";
			submodules = true;
		}; */

		ags.url = "github:Aylur/ags";
	};

	outputs = { self, nixpkgs, nix-darwin, nix-homebrew, home-manager, ... }@inputs: {
		nixosConfigurations.deepthought = nixpkgs.lib.nixosSystem {
			system = "aarch64-linux";
			specialArgs = { inherit inputs; };
			modules = [
				./hosts/nixos/configuration.nix
				home-manager.nixosModules.home-manager {
					home-manager.useGlobalPkgs = true;
					home-manager.backupFileExtension = "backup";
					home-manager.users.toby = {
						imports = [
							inputs.ags.homeManagerModules.default
							./modules/nixos/home.nix
						];
					};
				}
			];
		};
		darwinConfigurations.deepthought = nix-darwin.lib.darwinSystem {
			system = "aarch64-darwin";
			modules = [ 
				./hosts/darwin/configuration.nix
				nix-homebrew.darwinModules.nix-homebrew {
					nix-homebrew = {
						enable = true;
						enableRosetta = true;
						user = "toby";
					};
				}
				home-manager.darwinModules.home-manager {
					home-manager.useGlobalPkgs = true;
					home-manager.useUserPackages = true;
					home-manager.users.toby = import ./modules/darwin/home.nix;
				}
			];
		};
	};
}
