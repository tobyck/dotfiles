{
	services.mosquitto = {
		enable = true;
		listeners = [ (import ./crisislab.nix) ];
	};

	networking.firewall.allowedTCPPorts = [ 1883 ];
}
