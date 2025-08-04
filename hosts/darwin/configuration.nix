{ pkgs, ... }:

let
	username = "toby";
in {
	imports = [
		../../modules/darwin/kanata.nix
	];

	users.users.${username} = {
			name = username;
			home = "/Users/${username}";
	};

	homebrew = {
		enable = true;
		onActivation.cleanup = "uninstall";
		casks = [
			"zen-browser"
			"kitty"
			"obsidian"
			"spotify"
			"discord"
			"whatsapp"
			"microsoft-teams"
			"slack"
			"chatgpt"
			"launchcontrol"
			"aldente"
			"steam"
			"steamcmd"
			"google-chrome"
			"zoom"
			"ghostty"
			"postman"
			"adobe-creative-cloud"
			"microsoft-excel"
		];
		brews = [
			"nanopb"
		];
		masApps = {
			"Just Focus" = 1142151959;
		};
	};

	system = {
		primaryUser = username;
		defaults = {
			NSGlobalDomain = {
				AppleInterfaceStyle = "Dark";
				NSAutomaticQuoteSubstitutionEnabled = false;
				NSAutomaticCapitalizationEnabled = false;
				NSAutomaticDashSubstitutionEnabled = false;
				NSAutomaticInlinePredictionEnabled = false;
				NSAutomaticPeriodSubstitutionEnabled = false;
			};
			dock = {
				autohide = true;
				persistent-apps = [
					"/Applications/Zen Browser.app"
					"/Applications/Ghostty.app"
					"/Applications/Obsidian.app"
					"/Applications/Spotify.app"
					"/System/Applications/Mail.app"
					"/System/Applications/Calendar.app"
					"/Applications/WhatsApp.app"
				];
				show-recents = false;
				tilesize = 48;
				mru-spaces = false;
			};
			finder = {
				AppleShowAllExtensions = true;
				ShowPathbar = true;
				_FXShowPosixPathInTitle = true;
			};
			screencapture.location = "~/Pictures/Screenshots";
		};

		activationScripts.setDefaultBrowser.text = "sudo -u ${username} defaultbrowser zen";

		startup.chime = false;
		stateVersion = 5;
	};

	environment.systemPackages = with pkgs; [
		defaultbrowser
		pam-reattach

		cargo rustup
		nodejs bun
		zig
		jdk
	];

	# allow use of touch id for sudo (and in tmux too)
	environment.etc."pam.d/sudo_local".text = ''
		auth       optional       ${pkgs.pam-reattach}/lib/pam/pam_reattach.so
		auth       sufficient     pam_tid.so
	'';

	nixpkgs.hostPlatform = "aarch64-darwin";
	nix.settings.experimental-features = "nix-command flakes";
	ids.gids.nixbld = 350;
}
