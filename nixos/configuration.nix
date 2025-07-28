# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./audio
      ./pkgs
      ./i3
      ./keyboard
    ];

  nix.settings.experimental-features = ["nix-command" "flakes"];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

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


  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.jjoaoll = {
    isNormalUser = true;
    description = "João Lucas de Moraes Pereira";
    extraGroups = [ "networkmanager" "wheel" "video" "audio" ];
    packages = with pkgs; [];
  };

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
    # services.flatpak.enable = true;
    # Enable XDG Desktop Portals
    # xdg.portal.enable = true;
    # xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  
  
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
