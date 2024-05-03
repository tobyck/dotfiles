{
	programs.firefox = {
		enable = true;

		profiles.default = {
			userChrome = ''
				* {
					font-family: Inter !important;
				}
			'';
		};
	};
}
