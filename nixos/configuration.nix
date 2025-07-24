# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:


{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ../pkgs
      ./keyboard
    ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.initrd.luks.devices."luks-8a876280-84ca-45ae-a826-5fd2d64699c4".device = "/dev/disk/by-uuid/8a876280-84ca-45ae-a826-5fd2d64699c4";
  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Fortaleza";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "pt_BR.UTF-8";
    LC_IDENTIFICATION = "pt_BR.UTF-8";
    LC_MEASUREMENT = "pt_BR.UTF-8";
    LC_MONETARY = "pt_BR.UTF-8";
    LC_NAME = "pt_BR.UTF-8";
    LC_NUMERIC = "pt_BR.UTF-8";
    LC_PAPER = "pt_BR.UTF-8";
    LC_TELEPHONE = "pt_BR.UTF-8";
    LC_TIME = "pt_BR.UTF-8";
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.jjoaoll = {
    isNormalUser = true;
    description = "João Pereira";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      kdePackages.kate
    #  thunderbird
    ];
  };

  # Install firefox.
  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;


  virtualisation.libvirtd = {
    enable = true;
    qemu = {
      swtpm.enable = true;  # For Windows VMs (optional)
      ovmf.enable  = true;   # For UEFI support (optional)
    };
  };

  environment.sessionVariables = {
    STEAM_EXTRA_COMPAT_TOOLS_PATH = "${pkgs.gamescope}/bin";
    GDK_BACKEND = "x11";
  };



  system.autoUpgrade.enable = true;
  # system.autoUpgrade.allowReboot = true;
  services.flatpak.enable = true;
  # Enable XDG Desktop Portals
  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];


  # NVIDIA drivers
  # -----------------------------------------------------------------
  hardware.nvidia = {
    open                   = false;
    modesetting.enable     = true;
    powerManagement.enable = true;
    nvidiaSettings         = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };
  # -----------------------------------------------------------------
  # Gaming Compatibility
  # -----------------------------------------------------------------

  hardware.graphics = {
   enable32Bit = true;
    extraPackages32 = with pkgs; [
      libva
      pkgsi686Linux.libvdpau
      pkgsi686Linux.mesa
    ];

    extraPackages = with pkgs; [ nvidia-vaapi-driver ];
  };

  hardware.opentabletdriver.enable = true;
  hardware.opentabletdriver.daemon.enable = true;
  # -----------------------------------------------------------------

  services.xserver.windowManager.i3 = {
    enable = true;
    extraPackages = with pkgs; [
      dmenu    # lançador de aplicativos padrão do i3
      i3status # barra de status simples
      i3lock   # bloqueador de tela
      i3blocks # barra de status alternativa
    ];
  };


  # Pacotes úteis para i3 (adicione ao environment.systemPackages)
  environment.systemPackages = with pkgs; [
    rofi # alternativa ao dmenu
    feh # para gerenciar papel de parede
    arandr # para gerenciar monitores
    picom # compositor para efeitos visuais

    lightdm
    lightdm-gtk-greeter  # Greeter GTK padrão
    # lightdm-webkit2-greeter  # Greeter WebKit2 (temas modernos)

    #HACK: AUDIO STUFF
    dunst libnotify
    pulseaudio
    alsa-utils
  ];



  # programs.ssh.askPassword = lib.mkForce "${pkgs.kdePackages.ksshaskpass}/bin/ksshaskpass";

  services = {
    displayManager = {
      sddm.enable = false;
      sddm.wayland.enable = false;


      defaultSession = "none+i3";  # Define i3 como sessão padrão
    };

    xserver = {
      enable = true;
      videoDrivers = [ "nvidia" ];
      inputClassSections = [
        ''
          Identifier "IgnoreTablet"
          MatchIsTablet "on"
          MatchVendor "Wacom|Huion|Gaomon"
          Option "Ignore" "on"
        ''
      ];

      desktopManager.plasma6.enable = false;
      desktopManager.gnome.enable = true;
      displayManager = {

        lightdm = {
          enable = true;
          greeters.gtk.enable = true;  # Habilita o greeter GTK (padrão)
          # Opcional: Use um tema personalizado (ex: "tema-arc")
          # greeters.gtk.theme.name = "Arc";
        };

      };
    };
  };

  # Define que queremos X11
  environment.sessionVariables = {
    XDG_SESSION_TYPE = "x11";
  };
  

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?

}
