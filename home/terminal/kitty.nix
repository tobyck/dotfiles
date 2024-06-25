{
	programs.kitty = let
		font = "Iosevka NF";
	in {
		enable = true;

		# theme = "Rosé Pine";
		theme = "Tokyo Night";

		font = {
			name = font;
			size = 9.2;
		};

		extraConfig = ''
			bold_font ${font} Bold
			italic_font ${font} Italic
			bold_italic_font ${font} Bold Italic
		'';

		settings = {
			window_padding_width = 4;
			cursor_blink_interval = 0;
			cursor_underline_thickness = 1;
		};
	};
}
