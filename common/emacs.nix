{ config, pkgs, lib, ... }:
let
  emacsPkg = config.programs.emacs.package;
  emacsVterm =
    (pkgs.emacsPackagesFor emacsPkg).emacsWithPackages (epkgs: [
      epkgs.vterm
    ]);
  lspPackages = with pkgs; [
    bash-language-server
    ccls
    copilot-language-server
    gopls
    lua-language-server
    nixd
    nodePackages.javascript-typescript-langserver
    nodePackages.vscode-langservers-extracted
    phpactor
    ruby-lsp
    ruff
    rust-analyzer
    shfmt
    vscode-langservers-extracted
    yaml-language-server
  ];
  spellPackages = with pkgs; [
    aspell
    aspellDicts.en
    aspellDicts.en-computers
    aspellDicts.en-science
  ];
  emacsWithBatteries = [ emacsVterm ] ++ lspPackages ++ spellPackages;
in
{
  options.programs.emacs.package = lib.mkOption {
    type = lib.types.package;
    default = pkgs.emacs;
    description = "Emacs package to use (e.g. emacs-pgtk, emacs-nox, etc)";
  };
  config = {
    environment.systemPackages = emacsWithBatteries;
  };
}
