{
  description = "Tokenizers";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-22.05";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
        rust = pkgs.rustPlatform;
        beam = pkgs.beamPackages;

        pname = "tokenizers";
        version = "0.1.0-dev";
        src = ./.;

        tokenizers = beam.buildMix rec {
          inherit src pname version;
          name = pname;

          mixFodDeps = beam.fetchMixDeps {
            inherit src version;

            pname = "mix-deps-${pname}";
            sha256 = "sha256-Db4quXznZadJvPE0/9Ex3EjEA+qiYDgdWUJ2vKxkfBQ=";
          };

          cargoDeps = rust.fetchCargoTarball {
            inherit src;

            name = "cargo-deps-${pname}";
	    sourceRoot = "${src}/${cargoRoot}";
            hash = "sha256-USrYkC/OBUTcWntF6wA4vGNz/YaeYvLkkNqAcsYubC0=";
          };

          cargoRoot = "native/ex_tokenizers";

          nativeBuildInputs = with rust; [
	    cargoSetupHook

	    pkgs.rustPlatform.rust.cargo
	    pkgs.rustPlatform.rust.rustc
	    pkgs.pkg-config
	    pkgs.openssl
          ];

	  buildInput = with pkgs; [
	  ];

          # propagatedBuildInputs = tokenizers-deps;
          # buildInputs = builtins.attrValues tokenizers-deps;
        };
      in
      {
        packages = {
          inherit tokenizers;
        };
      });
}


# devShell = pkgs.mkShell {
#   buildInputs = with pkgs; [
#     act
#     elixir
#     erlang
#     gdb
#     libiconv
#     openssl
#     pkg-config
#     rustPkg
#     rust-analyzer-nightly
#   ];
#   shellHook = ''
#     mkdir -p .nix-mix
#     mkdir -p .nix-hex
#     export MIX_HOME=$PWD/.nix-mix
#     export HEX_HOME=$PWD/.nix-hex
#     export PATH=$MIX_HOME/bin:$PATH
#     export PATH=$HEX_HOME/bin:$PATH
#     export PATH=$MIX_HOME/escripts:$PATH
#   '';
# };
