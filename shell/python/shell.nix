{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  packages = with pkgs; [
    uv
    python314
    python314Packages.numpy
    python314Packages.pandas
    python314Packages.requests
    python314Packages.matplotlib
    python314Packages.flask
    # python314Packages.fastapi
  ];

  shellHook = ''
    echo "Bem-vindo ao ambiente Python com Nix!"
    echo "Python: $(python3 --version)"
    echo "Pacotes disponíveis: numpy, pandas, requests, matplotlib, flask"
    echo ""
    echo "Digite 'exit' para sair do ambiente Nix."

    alias py=python
  '';
}