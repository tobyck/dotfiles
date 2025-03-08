# { lib, ... }:

let
  driverDaemonCmd = "/Library/Application\\ Support/org.pqrs/Karabiner-DriverKit-VirtualHIDDevice/Applications/Karabiner-VirtualHIDDevice-Daemon.app/Contents/MacOS/Karabiner-VirtualHIDDevice-Daemon";
	kanataCmd = "/Users/toby/Downloads/kanata_macos_arm64 --cfg ${../common/keyboard.kbd}";
	logPath = /Users/toby/.log/kanata;
in {
	launchd.user.agents.kanata = {
		script = ''
			sudo ${driverDaemonCmd} &
			sleep 2 && sudo ${kanataCmd}
		'';
		serviceConfig = {
			RunAtLoad = true;
			StandardErrorPath = logPath + /err.log;
			StandardOutPath = logPath + /out.log;
			ProcessType = "Interactive";
		};
	};

	security.sudo.extraConfig = ''
		%admin ALL=(root) NOPASSWD: ${driverDaemonCmd}
		%admin ALL=(root) NOPASSWD: ${kanataCmd}
	'';
}
