{ config, pkgs, ... }:

{
  home.packages = [
    pkgs.nodePackages.vscode-langservers-extracted
    pkgs.nodePackages.javascript-typescript-langserver
    pkgs.ruff
    pkgs.ruby-lsp
    pkgs.gopls
    pkgs.rust-analyzer
    pkgs.ccls
    pkgs.phpactor
    pkgs.lua-language-server
    pkgs.vscode-langservers-extracted
    pkgs.yaml-language-server
    pkgs.bash-language-server
    pkgs.shfmt
  ];
}
