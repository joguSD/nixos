# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # TODO: move this stuff into hardware-configuration?
  # Use the GRUB 2 boot loader.
  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  # boot.loader.grub.efiSupport = true;
  # boot.loader.grub.efiInstallAsRemovable = true;
  # boot.loader.efi.efiSysMountPoint = "/boot/efi";
  # Define on which hard drive you want to install Grub.
  boot.loader.grub.device = "/dev/sda"; # or "nodev" for efi only


  # General Configuration
  networking.hostName = "gekkou"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  networking.interfaces.ens3.useDHCP = true;

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  # Set your time zone.
  time.timeZone = "America/Los_Angeles";

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # Essentials
    wget vim ripgrep git
    # GUI
    firefox mpv gimp ark obs-studio
    # GUI - KDE
    gwenview filelight
  ];

  programs.vim.defaultEditor = true;
  programs.zsh.enable = true;
  programs.zsh.ohMyZsh = {
    enable = true;
    theme = "af-magic";
    plugins = [ "git" "sudo" ];
  };

  # List services that you want to enable:

  # TODO: Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # TODO: Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.layout = "us";
  # TODO Configure transmission to be a little more friendly
  services.transmission = {
    enable = true;
    downloadDirPermissions = "775";
  };

  # Enable the KDE Desktop Environment.
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.defaultUserShell = pkgs.zsh;
  users.users.jogu = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
  };

  # Fonts -- Source Han is the best I've found.
  fonts.fonts = with pkgs; [
    source-han-code-jp
    source-han-sans-japanese
    source-han-serif-japanese
    source-han-sans-korean
    source-han-serif-korean
    source-han-sans-traditional-chinese
    source-han-serif-traditional-chinese
    source-han-sans-simplified-chinese
    source-han-serif-simplified-chinese
  ];

  fonts.fontconfig.defaultFonts = {
    monospace = [
      "Source Han Code JP"
    ];
    sansSerif = [
      "Source Han Sans JP"
      "Source Han Sans KR"
      "Source Han Sans TW"
      "Source Han Sans CN"
    ];
    serif = [
      "Source Han Serif JP"
      "Source Han Serif KR"
      "Source Han Serif TW"
      "Source Han Serif CN"
    ];
  };

  # IME -- this is the easist IME setup of my life!
  i18n.inputMethod = {
    enabled = "fcitx";
    fcitx.engines = with pkgs.fcitx-engines; [ mozc ];
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "20.03"; # Did you read the comment?

}

