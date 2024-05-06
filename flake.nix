{
	description = "Toby's NixOS system and user configurations";

	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

		home-manager = {
			url = "github:nix-community/home-manager";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		# This is release 2024-04-20, the one before the big one with the kernel and uboot updates that apprently breaks graphics
		apple-silicon = {
			url = "github:tpwrules/nixos-apple-silicon/15dbcfd42d9f4924b2f9cca5942d3cb0048e147f";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		hyprland.url = "github:hyprwm/Hyprland";

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
