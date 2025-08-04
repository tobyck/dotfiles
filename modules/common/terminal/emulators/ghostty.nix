{ pkgs, ... }:

{
  programs.ghostty =
    let
      vague-theme = pkgs.fetchFromGitHub {
        owner = "vague2k";
        repo = "vague.nvim";
        rev = "676e5b4d74f32ff91c1583eba9c326d2b749672f";
        hash = "sha256-rJe0pJu6/JKCCdhKTwPFdHlZ2CUaIJc++nlsEdYXQOY=";
      };
    in
    {
      enable = true;
      package = null;

      settings = {
        theme = "${vague-theme}/extras/ghostty/vague";
        command = "${pkgs.fish}/bin/fish --login --interactive";
        shell-integration = "fish";
        font-family = "Iosevka NFM";
        font-size = 13.5;
        window-padding-x = 6;
        window-padding-y = 4;
      };
    };
}
