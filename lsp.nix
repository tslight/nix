{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    # Node / JavaScript / TypeScript
    # nodePackages.typescript-language-server
    nodePackages.vscode-langservers-extracted
    nodePackages.javascript-typescript-langserver
    # nodePackages.eslint-language-server

    # Python
    # pyright
    # pylsp
    # python-language-server
    ruff

    # Ruby
    # solargraph
    ruby-lsp

    # Go
    gopls

    # Rust
    rust-analyzer

    # Java
    # jdt-language-server

    # C / C++
    ccls

    # PHP
    phpactor

    # Lua
    lua-language-server

    # HTML / CSS / JSON / YAML / Markdown
    vscode-langservers-extracted
    yaml-language-server

    # Shell / Bash
    bash-language-server
    shfmt (formatter)

    # Dart / Flutter
    # dart_language_server

    # Kotlin
    # kotlin-language-server

    # Haskell
    # haskell-language-server

    # Elm
    # elm-language-server

    # Julia
    # julia-language-server

    # PHP
    # intelephense

    # Others
    # nim-language-server
    # r-language-server
    # zig-language-server
    # reason-language-server
    # clojure-lsp
    # crystal-langserver
    # fortran-language-server
    # groovy-language-server
  ];
}
