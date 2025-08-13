{ config, pkgs, lib, inputs, ...}:
  with lib;
{
  config = mkIf (builtins.elem "graphical-gnome" config.sanix.features) {
    # Enable the GNOME Desktop Environment.
    services.desktopManager.gnome.enable = true;

    services.gnome = {
        # General settings
        gnome-initial-setup.enable = false;
        gnome-keyring.enable = true;
        gcr-ssh-agent.enable = true;
        gnome-online-accounts.enable = true;
        gnome-remote-desktop.enable = true;
        gnome-settings-daemon.enable = true;
        gnome-user-share.enable = true;
        gnome-browser-connector.enable = true;

        rygel.enable = true;
        sushi.enable = true;

        # File trackers and information miners
        tinysparql.enable = true;
        localsearch.enable = true;
    };

    # Enable gnome theme on QT
    qt.platformTheme = "gnome";

    environment.systemPackages = with pkgs; [
      gnome-themes-extra
      adwaita-icon-theme
    ];
  };
}
