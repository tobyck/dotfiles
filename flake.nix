{
	description = "Toby's NixOS system and user configurations";

	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

		home-manager = {
			url = "github:nix-community/home-manager";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		apple-silicon = {
			url = "github:tpwrules/nixos-apple-silicon/3410fe09c4d6e23f0757499b8da89d15bede1f00";
			# inputs.nixpkgs.follows = "nixpkgs";
		};

		hyprland.url = "github:hyprwm/Hyprland/0c513ba91bd73106be99e35b1a020d24e5ae874a";

		ags.url = "github:Aylur/ags";
	};

	outputs = { self, nixpkgs, home-manager, ... }@inputs: {
		nixosConfigurations.deepthought = nixpkgs.lib.nixosSystem {
			system = "aarch64-linux";
			specialArgs = { inherit inputs; };
			modules = [
				./system/configuration.nix
				home-manager.nixosModules.home-manager
				{
					home-manager.useGlobalPkgs = true;
					home-manager.backupFileExtension = "backup";
					home-manager.users.toby = {
						imports = [
							inputs.ags.homeManagerModules.default
							./home
						];
					};
				}
			];
		};
	};
}
