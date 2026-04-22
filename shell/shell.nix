# shell.nix — Define um ambiente de desenvolvimento reproduzível com Nix
#
# Para entrar no ambiente, execute: nix-shell
# Para sair, execute: exit (ou Ctrl+D)

# `pkgs` recebe o conjunto de pacotes do nixpkgs.
# A versão usada aqui é a que está fixada no canal configurado no sistema.
# Para fixar uma versão específica (recomendado em projetos reais), usa-se
# fetchTarball ou flakes — veremos isso mais à frente no curso.
{ pkgs ? import <nixpkgs> {} }:

# `pkgs.mkShell` cria um ambiente de shell temporário.
# Todos os pacotes e variáveis declarados aqui ficam disponíveis
# APENAS dentro desse shell — o sistema host não é alterado.
pkgs.mkShell {

  # --- PACOTES DISPONÍVEIS NO SHELL ---
  # `packages` (ou `buildInputs`) lista tudo que deve estar no PATH
  # quando você entrar no ambiente.
  packages = [
    pkgs.git        # controle de versão
    pkgs.curl       # requisições HTTP
    pkgs.jq         # manipulação de JSON no terminal
    pkgs.ripgrep    # busca de texto (rg), alternativa rápida ao grep
    pkgs.python3    # interpretador Python 3

    # Pacotes Python podem ser incluídos via python3.withPackages:
    # (pkgs.python3.withPackages (ps: [ ps.requests ps.numpy ]))
  ];

  # --- VARIÁVEIS DE AMBIENTE ---
  # Tudo aqui é exportado como variável de ambiente dentro do shell.
  # Útil para configurar ferramentas sem editar ~/.bashrc globalmente.
  EDITOR = "vim";
  MY_PROJECT = "nix-course";

  # --- SCRIPT EXECUTADO AO ENTRAR NO SHELL ---
  # `shellHook` é um script Bash que roda automaticamente quando você
  # executa `nix-shell`. Ideal para mensagens de boas-vindas,
  # ativar virtualenvs, verificar pré-requisitos, etc.
  shellHook = ''
    echo "Bem-vindo ao ambiente do $MY_PROJECT!"
    echo "Python: $(python3 --version)"
    echo "Git:    $(git --version)"
    echo ""
    echo "Digite 'exit' para sair do ambiente Nix."
  '';
}