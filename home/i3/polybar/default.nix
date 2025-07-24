{ pkgs, ... }: {

  services.polybar = {
    enable = true;
    package = pkgs.polybarFull;  
    script = "polybar mybar &";  
    config = ./config.ini;  # Caminho para o arquivo de configuração
    extraConfig = ''
    '';
  };

}
