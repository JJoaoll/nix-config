{ config, lib, pkgs, ... }:

{
  programs.kitty = {
    enable = true;

    font = { 
      name = "JetBrainsMono Nerd Font"; 
      package = pkgs.nerd-fonts.jetbrains-mono;
      size = 13;
    };

    shellIntegration.enableBashIntegration = true;
    themeFile = "gruvbox-dark-hard";

    settings = {
      window_padding_width = 10;
      
      remember_window_size = false;
      initial_window_width = 1000;
      initial_window_height = 600;
      close_on_child_death = true;

      cursor_trail = 1;
      cursor_trail_decay = "0.1 0.4";
      cursor_trail_start_threshold = 2;
      
      dynamic_background_opacity = true;
      mouse_hide_wait = "3.0";
      scrollback_lines = 100000;
      strip_trailing_spaces = "always";
      
      touch_scroll_multiplier = 20;
    };
  }; 
}
