with import (builtins.fetchTarball {
  name = "2023-09-16";
  url = "https://github.com/NixOS/nixpkgs/archive/ae5b96f3ab6aabb60809ab78c2c99f8dd51ee678.tar.gz";
  sha256 = "11fpdcj5xrmmngq0z8gsc3axambqzvyqkfk23jn3qkx9a5x56xxk";
}) {};
mkShell {
  buildInputs =
    let
      supportedPgs = [
        postgresql_16
        postgresql_15
        postgresql_14
        postgresql_13
        postgresql_12
      ];
      pgWithExts = { postgresql }: postgresql.withPackages (p: [
        (callPackage ./ext/conninfo.nix { inherit postgresql; })
      ]);
      withTmpPgExts = map (postgresql: callPackage ./scripts/withTmpPg.nix { postgresql = pgWithExts { inherit postgresql;}; }) supportedPgs;
    in
    withTmpPgExts;

  shellHook = ''
    export HISTFILE=.history
  '';
}
