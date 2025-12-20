{ config, pkgs, ... }:

{
  home.packages = [
    pkgs.bash-language-server
    pkgs.ccls
    pkgs.copilot-language-server
    pkgs.gopls
    pkgs.lua-language-server
    pkgs.nixd
    pkgs.nodePackages.javascript-typescript-langserver
    pkgs.nodePackages.vscode-langservers-extracted
    pkgs.phpactor
    pkgs.ruby-lsp
    pkgs.ruff
    pkgs.rust-analyzer
    pkgs.shfmt
    pkgs.vscode-langservers-extracted
    pkgs.yaml-language-server
  ];
}
