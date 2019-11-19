{ pkgs, ... }:
with pkgs;
let
  my-python-packages = python-packages: with python-packages; [
    conda
    pip
    ipython
    autopep8
    black
    flake8
    flask
    importmagic
    jedi
    jupyter
    requests
    rope
    setuptools
    twine
    virtualenv
    wheel
    yapf
    pylint
    xonsh
  ];
  python-with-my-packages = python3.withPackages my-python-packages;
in ...
