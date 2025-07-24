{ pkgs, ... }: {

  services.polybar = {
    enable = true;
    package = pkgs.polybarFull;  
    script = "polybar mybar &";  
    # config = ./polybar/config.ini;  # Caminho para o arquivo de configuração
    extraConfig = ''
      [bar/mybar]
      width = 100%
      height = 24pt
      modules-left = i3-workspaces
      modules-center = date
      modules-right = cpu memory
      ; (Adicione mais configurações conforme necessário)
    '';
  };

}
