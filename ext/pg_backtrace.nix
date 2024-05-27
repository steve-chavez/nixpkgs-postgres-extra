{ lib, stdenv, fetchFromGitHub, postgresql }:

stdenv.mkDerivation rec {
  pname = "pg_backtrace";
  version = "0.1";

  buildInputs = [ postgresql ];

  USE_PGXS = "true";

  src = fetchFromGitHub {
    owner  = "postgrespro";
    repo   = pname;
    rev    = "de245a5f6b42ba870259ba68b4fbdd0c8b7bae69";
    hash   = "sha256-6AcrAb4euXEApLprlK39su7nL/rrQ4kJ4u+thS8y3TM=";
  };

  installPhase = ''
    mkdir -p $out/{lib,share/postgresql/extension}

    cp *.so      $out/lib
    cp *.sql     $out/share/postgresql/extension
    cp *.control $out/share/postgresql/extension
  '';

  meta = with lib; {
    description = "Show backtrace for errors and signals.";
    homepage    = "https://github.com/postgrespro/pg_backtrace";
    maintainers = with maintainers; [ steve-chavez ];
    platforms   = postgresql.meta.platforms;
    license     = licenses.postgresql;
  };
}
