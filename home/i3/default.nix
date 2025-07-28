{ config, pkgs, ... }: {

  imports = [
    ./polybar
    ./picom.nix
    ./rofi.nix
  ];

  home.packages = with pkgs; [
    nitrogen 
  ];


  # xsession.windowManager.i3 = {
  #   enable = true;
  #
  #   config = rec {
  #     # Terminal padrão
  #     terminal = "kitty";
  #
  #     # Tecla modificadora (Windows/Command)
  #     modifier = "Mod4";
  #
  #     # Atalhos principais
  #     keybindings = pkgs.lib.mkOptionDefault {
  #       # Aplicativos
  #       "${modifier}+Return" = "exec ${terminal}";
  #       "${modifier}+d" = "exec rofi -show drun";
  #       "${modifier}+Shift+q" = "kill";
  #
  #       # Navegação
  #       "${modifier}+h" = "focus left";
  #       "${modifier}+j" = "focus down";
  #       "${modifier}+k" = "focus up";
  #       "${modifier}+l" = "focus right";
  #
  #       # Workspaces
  #       "${modifier}+1" = "workspace number 1";
  #       "${modifier}+2" = "workspace number 2";
  #       "${modifier}+Shift+1" = "move container to workspace number 1";
  #
  #       # Layout
  #       "${modifier}+f" = "fullscreen toggle";
  #       "${modifier}+s" = "layout stacking";
  #       "${modifier}+w" = "layout tabbed";
  #       "${modifier}+e" = "layout toggle split";
  #
  #       # Sistema
  #       "${modifier}+Shift+r" = "restart";
  #       "${modifier}+Shift+e" = 
  #         "exec i3-nagbar -t warning -m 'Sair do i3?' -b 'Desligar' 'systemctl poweroff' -b 'Reiniciar' 'systemctl reboot' -b 'Sair' 'i3-msg exit'";
  #     };
  #
  #     # Configuração da barra
  #     bars = [{
  #       position = "top";
  #       statusCommand = "${pkgs.i3status}/bin/i3status";
  #       fonts = {
  #         names = [ "DejaVu Sans Mono" "Font Awesome" ];
  #         size = 11.0;
  #       };
  #       colors = {
  #         background = "#1d1f21";
  #         statusline = "#c5c8c6";
  #         separator = "#666666";
  #         focusedWorkspace = {
  #           border = "#285577";
  #           background = "#285577";
  #           text = "#ffffff";
  #         };
  #         activeWorkspace = {
  #           border = "#333333";
  #           background = "#5f676a";
  #           text = "#ffffff";
  #         };
  #       };
  #     }];
  #
  #     # Cores das bordas das janelas
  #     colors = {
  #       focused = {
  #         border = "#4c7899";
  #         background = "#285577";
  #         text = "#ffffff";
  #         indicator = "#2e9ef4";
  #         childBorder = "#285577";
  #       };
  #     };
  #
  #     # Configurações de janela
  #     window.border = 2;
  #     gaps = {
  #       inner = 8;
  #       smartGaps = true;
  #     };
  #
  #     # Comandos iniciais
  #     startup = [
  #       # Política de privacidade (opcional)
  #       { command = "xset s off"; notification = false; }
  #       { command = "xset -dpms"; notification = false; }
  #
  #       # Fundo de tela
  #       { command = "feh --bg-scale ~/.background-image"; always = true; }
  #     ];
  #   };
  #
  #   # # Pacotes adicionais necessários
  #   # extraPackages = with pkgs; [
  #   #   dmenu         # Menu de aplicativos
  #   #   i3status      # Barra de status
  #   #   rofi          # Launcher moderno
  #   #   feh           # Gerenciador de wallpaper
  #   #   kitty         # Terminal
  #   # ];
  # };
}
