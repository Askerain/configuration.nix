# - Askerain's configuration file -
# Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
# See the References section of the GitHub page to get useful links.
{ config, pkgs, ... }: {

imports =
  [ # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

system.stateVersion = "19.09"; # Replace the number with your version in order
                               # to avoid breaking some software.
# Boot settings.
boot = {
  vesa = true;
  cleanTmpDir = true;
  loader = {
    # Unmark this section if you're using Legacy Boot (MBR).
    grub.enable = true;
    grub.version = 2;
    grub.device = "/dev/sda";
    # Unmark this section if you're using UEFI (GPT).
  # efi.canTouchEfiVariables = true;
  # systemd-boot = {
  #    enable = true;
  #   consoleMode = 0;
  # };
  };
};

# Select internationalisation properties.
i18n = {
  defaultLocale = "es_ES.UTF-8"; # See references 1 and 2 in References section.
  consoleUseXkbConfig = true;
};

# Set your time zone.
time.timeZone = "Europe/Madrid"; # See Reference 3 in References section.

# Network settings.
networking = {
  hostName = "vm"; # Define your hostname.
  networkmanager.enable = true; # Enable NetworkManager.
  useDHCP = false;
  interfaces.ens33.useDHCP = true;

  firewall = { # Enable or disable the firewall.
    enable = false;
  };
};

# User settings.
# Don't forget to set a password with ‘passwd’.
users.users = {
  ayn = {
    isNormalUser = true;
    useDefaultShell = false;
    group = "users";
    extraGroups = [ "wheel" "networkmanager" "vboxusers" ];
    shell = pkgs.zsh;
    home = "/home/ayn";
    createHome = true;
  };
};

# Service settings.
services = {
  acpid = { # Enable acpid to notify ACPI events.
    enable = true;
  };
  dbus = { # Enable D-Bus.
    enable = true;
  };
  localtime = { # Enable localtime to keep the system timezone up to date.
    enable = true;
  };
  locate = { # Periodically update the database of files used by locate command.
    enable = true;
  };
  openssh = { # Enable the OpenSSH daemon.
    enable = true;
  };
  printing = { # Enable CUPS to print documents.
    enable = true;
  };
  xserver = {
    enable = true;
    layout = "es"; # See Reference 4 in References section.
    xkbOptions = "eurosign:e";
    libinput.enable = true;
    displayManager = {
      lightdm.greeters.mini = {
        enable = true;
        user = "ayn";
        extraConfig = ''
          [greeter]
          show-password-label = false
          [greeter-theme]
          background-image = "/root/Downloads/wallpaper.jpg"
        '';
      };
   };
    desktopManager = {
      xterm = {
        enable = false;
      };
    };
    windowManager = {
      default = "openbox";
      openbox.enable = true;
    };
  };
};

# Sound settings
sound.enable = true; # Enable sound.
hardware.pulseaudio = {
  enable = true;
  support32Bit = true; # Limited to 64-bit systems.
  package = pkgs.pulseaudioFull; # Enable JACK support, Bluetooth...
};

# Bluetooth settings.
#hardware.bluetooth = {
#  enable = true;
#  package = pkgs.bluezFull;
#  powerOnBoot = true;
#};

# Download packages.
nixpkgs.config.allowUnfree = true;
environment.systemPackages = with pkgs; [

  # Drivers
  alsaLib alsaPlugins # ALSA
  bluezFull bluez-alsa bluez-tools # Bluetooth

  # Essentials
  acpitool
  dbus
  dunst
  compton
  emacs
  evince
  feh
  firefox
  git
  htop
  imv
  libnotify
  mpv
  mutt
  ncmpcpp
  neofetch
  openssh
  pacman
  python
  python36
  ranger
  rofi
  scrot
  vim
  wget
  zsh
  wine
  tree

  # Other
  atom
  deluge
  imagemagick
  krita
  nmap
  steam
  vscode
  texinfo
  libreoffice
  w3m
];

# Program settings.
programs = {
  mtr.enable = true;
};
# Defaults
environment.variables = {
  EDITOR = "nano";
  VISUAL = "imv";
};
# zsh
programs.zsh = {
  ohMyZsh = {
    enable = true;
  };
  histSize = 20;
  syntaxHighlighting.enable = true;
};
# ssh
programs.ssh = {
  startAgent = true;
};
# Steam
hardware.steam-hardware.enable = false;


# Virtualisation settings.
virtualisation = {
  virtualbox.host.enable = true; # VirtualBox
  anbox.enable = true; # Anbox (https://anbox.io)
};

# Power management settings.
powerManagement.enable = true;


}

