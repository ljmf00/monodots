{ config, pkgs, lib, inputs, ...}:
  with lib;
{
  services.gpg-agent.pinentry.package = mkDefault pkgs.pinentry-gnome3;

  programs.librewolf = {
    enable = true;
    package = pkgs.librewolf;

    # Enable WebGL, cookies and history
    settings = {
      "webgl.disabled" = false;
      "privacy.fingerprintingProtection" = true;
      "privacy.resistFingerprinting" = true;
      "privacy.resistFingerprinting.letterboxing" = false;
      "network.http.referer.XOriginPolicy" = 2;
      "privacy.clearOnShutdown.history" = false;
      "privacy.clearOnShutdown.cookies" = true;
      "privacy.donottrackheader.enabled" = true;
      "privacy.globalprivacycontrol.enabled" = true;
      "network.cookie.lifetimePolicy" = 0;
      "widget.use-xdg-desktop-portal.file-picker" = 1;
    };
  };

  # configure default browser
  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "text/html" = "librewolf.desktop";
      "x-scheme-handler/http" = "librewolf.desktop";
      "x-scheme-handler/https" = "librewolf.desktop";
      "x-scheme-handler/about" = "librewolf.desktop";
      "x-scheme-handler/unknown" = "librewolf.desktop";
    };
  };

  home.sessionVariables.DEFAULT_BROWSER = "${config.programs.librewolf.package}/bin/librewolf";

  gtk = {
    enable = true;

    theme.name    = "Adwaita-Dark";
    theme.package = pkgs.gnome-themes-extra;

    iconTheme.name    = "Papirus-Dark";
    iconTheme.package = pkgs.papirus-icon-theme;
  };

  dconf.settings = {
    # Theme
    "org/gnome/desktop/interface"."color-scheme" = "prefer-dark";

    # disable first-setup messages
    "org/gnome/software"."first-run" = false;

    # Setting hot corners
    "org/gnome/shell"."enable-hot-corners" = false;
    "org/gnome/desktop/interface"."enable-hot-corners" = false;

    # Animations
    "org/gnome/desktop/interface"."enable-animations" = true;

    # Clock, Locale and Calendar
    "org/gnome/desktop/interface"."clock-format" = "24h";
    "org/gnome/desktop/interface"."clock-show-seconds" = true;
    "org/gnome/desktop/interface"."clock-show-weekday" = true;
    "org/gnome/desktop/interface"."clock-show-date" = true;
    "org/gnome/desktop/calendar"."show-weekdate" = true;
    "org/gnome/shell/weather"."automatic-location" = true;
    "org/gnome/system/location".enabled = true;
  };
}
