{ config, pkgs, lib, inputs, ...}:
  with lib;
{
  home.packages = with pkgs;
  [
    pre-commit
  ];

  programs.delta.enable = true;
  programs.delta.enableGitIntegration = true;

  programs.git = {
    enable = true;
    lfs.enable = true;

    package = pkgs.gitFull;

    signing = {
      key = "730750D54B7A9F66";
      signByDefault = false;
      format = "openpgp";
    };

    ignores = [
      "*~"
      "*.swp"
      "Session.vim"
    ];

    attributes = [
      "*.pdf diff=pdf"
    ];

    settings = {
      user.name = "Luís Ferreira";
      user.email = "contact@lsferreira.net";

      core = {
        editor = "nvim --clean";
        whitespace = "trailing-space,space-before-tab";
        commitGraph = true;
      };

      format.signoff = true;

      alias = {
        "s" = "status";

        "c" = "commit";
        "cs" = "commit -s";
        "ca-sign" = "commit -s --amend --no-edit";
        "cp" = "cherry-pick";

        "b" = "branch";
      };
    };
  };

  programs.git-cliff.enable = true;
  programs.gitui.enable = true;
  programs.gh.enable = true;
}
