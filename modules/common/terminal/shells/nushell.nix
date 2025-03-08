{ pkgs, startupCommand ? "", ... }:

{
	programs.nushell = {
		enable = true;

		envFile.text = ''
			$env.__NIX_DARWIN_SET_ENVIRONMENT_DONE = 1

			$env.PATH = [
				$"($env.HOME)/.nix-profile/bin"
				$"/etc/profiles/per-user/($env.USER)/bin"
				"/run/current-system/sw/bin"
				"/nix/var/nix/profiles/default/bin"
				"/usr/local/bin"
				"/usr/bin"
				"/usr/sbin"
				"/bin"
				"/sbin"
			]

			$env.LS_COLORS = (vivid generate tokyonight-night | str trim)
			$env.EDITOR = "nvim"

			$env.NIX_PATH = "nixpkgs=flake:nixpkgs:/nix/var/nix/profiles/per-user/root/channels"
			$env.NIX_SSL_CERT_FILE = "/etc/ssl/certs/ca-certificates.crt"
			$env.NIX_USER_PROFILE_DIR = "/nix/var/nix/profiles/per-user/$USER"
			$env.NIX_PROFILES = [
				"/nix/var/nix/profiles/default"
				"/run/current-system/sw"
				"/etc/profiles/per-user/$USER"
				"$HOME/.nix-profile"
			]

			if ($"($env.HOME)/.nix-defexpr/channels" | path exists) {
				$env.NIX_PATH = ($env.PATH | split row (char esep) | append $"($env.HOME)/.nix-defexpr/channels")
			}

			$env.SHELL = "${pkgs.nushell}/bin/nu"

			mkdir ~/.cache/starship
			starship init nu | save -f ~/.cache/starship/init.nu

			zoxide init nushell --cmd cd | save -f ~/.zoxide.nu
		'';

		configFile.text = ''
			$env.config = {
				show_banner: false
				color_config: {
					shape_garbage: "red_underline"
					shape_external: "blue"
					shape_externalarg: "light_cyan"
				}
			}

			use ~/.cache/starship/init.nu
			source ~/.zoxide.nu

			${startupCommand}
		'';
	};
}
