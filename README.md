# nixpkgs-postgres-extra

Extra postgres extensions not included in nixpkgs.

## Extensions

- [conninfo](https://github.com/ibarwick/conninfo)

## Trying it out

```
$ nix-shell
$ with-pg-16 psql

$ postgres=# create extension conninfo;
CREATE EXTENSION
```

## Tests

```
$ nix-shell
$ with-pg-16 make
...

ok 1         - conninfo                                    9 ms
1..1
# All 1 tests passed.
```
