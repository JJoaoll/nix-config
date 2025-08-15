{ config, pkgs, inputs, ... }:

#TODO: DARK THEME!
{
  programs.rofi = {
    enable = true;
    theme = "rounded-nord-dark";

    extraConfig = {
      # Força modo escuro
      modes = "drun,run,window";
      display-drun = " ";
      display-run = " ";
      display-window = " ";
      
      # Configurações de cor (se o tema não carregar direito)
      background = "#2E3440";
      foreground = "#ECEFF4";
      selected-background = "#3B4252";
      selected-foreground = "#81A1C1";
    };


    # extraConfig = {
    #   modi = "drun,filebrowser";
    #   font = "Noto Sans CJK JP 12";
    #   show-icons = true;
    #   disable-history = true;
    #   hover-select = true;
    #
    #   display-drun = "";
    #   display-window = "";
    #   display-combi = "";
    #   icon-theme = "Fluent-dark";
    #   terminal = "kitty";
    #   drun-match-fields = "name";
    #   drun-display-format = "{name}";
    #   me-select-entry = "";
    #   me-accept-entry = "MousePrimary";
    #   kb-cancel = "Escape,MouseMiddle";
    # };
  };
}
