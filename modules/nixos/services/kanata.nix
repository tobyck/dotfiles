{ pkgs, ... }:

{
	home.packages = [ pkgs.kanata ];

	systemd.user.services.kanata = {
		Unit.Description = "Automatically run Kanata keyboard remappings in the background";
		Install.WantedBy = [ "default.target" ];
		Service = {
			Restart = "no";
			ExecStart = pkgs.writeShellScript "start-kanata.sh" ''
				${pkgs.kanata}/bin/kanata -c ${../../common/kanata/keyboard.kbd}
			'';
		};
	};
}
