{ lib, stdenv, fetchFromGitHub, postgresql }:

stdenv.mkDerivation rec {
  pname = "conninfo";
  version = "1.0";

  buildInputs = [ postgresql ];

  src = fetchFromGitHub {
    owner  = "ibarwick";
    repo   = pname;
    rev    = "6eefa30a916761963dc2727a08bf6c958df5d8fe";
    hash   = "sha256-BS9IdA0+EkRlirihcOWZMW3NPWr9Mwps48MCRkFH+PU=";
  };

  installPhase = ''
    mkdir -p $out/{lib,share/postgresql/extension}

    cp *.so      $out/lib
    cp *.sql     $out/share/postgresql/extension
    cp *.control $out/share/postgresql/extension
  '';

  meta = with lib; {
    description = "conninfo is a PostgreSQL extension providing some utility functions for parsing conninfo strings.";
    homepage    = "https://github.com/ibarwick/conninfo";
    maintainers = with maintainers; [ steve-chavez ];
    platforms   = postgresql.meta.platforms;
    license     = licenses.postgresql;
  };
}
