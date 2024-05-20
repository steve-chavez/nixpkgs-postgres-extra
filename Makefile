PG_CONFIG = pg_config
PGXS=$(shell $(PG_CONFIG) --pgxs)
PG_REGRESS=$(abspath $(PGXS)/../../test/regress/pg_regress)

TESTDIR=test
TESTS = $(wildcard $(TESTDIR)/sql/*.sql)
REGRESS = $(patsubst $(TESTDIR)/sql/%.sql,%,$(TESTS))
REGRESS_OPTS = --inputdir=$(TESTDIR)

installcheck:
	$(PG_REGRESS) $(REGRESS_OPTS) $(REGRESS)
