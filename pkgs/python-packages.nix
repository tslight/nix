pkgs: with pkgs; [
  (python3.withPackages(ps: with ps; [
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
  ]))
]
