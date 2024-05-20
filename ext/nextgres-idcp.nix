{ lib, stdenv, fetchFromGitHub, postgresql, openssl, libkrb5 }:

stdenv.mkDerivation rec {
  pname = "nextgres-idcp";
  version = "0.1";

  buildInputs = [ postgresql openssl libkrb5 ];

  USE_PGXS = "true";

  src = fetchFromGitHub {
    owner  = "nextgres";
    repo   = pname;
    rev    = "b90bbf19a158f937951a52edb6f888f8ffa0b30e";
    hash   = "sha256-Wu757MmZO6TLhSJh34L/d99PLg2Jah3X7lGh061W1rI=";
  };

  installPhase = ''
    mkdir -p $out/{lib,share/postgresql/extension}

    cp *.so      $out/lib
    cp *.sql     $out/share/postgresql/extension
    cp *.control $out/share/postgresql/extension
  '';

  meta = with lib; {
    description = "NEXTGRES In-Database Connection Pool Extension for Postgres";
    homepage    = "https://github.com/nextgres/nextgres-idcpo";
    maintainers = with maintainers; [ steve-chavez ];
    platforms   = postgresql.meta.platforms;
    license     = licenses.postgresql;
  };
}
