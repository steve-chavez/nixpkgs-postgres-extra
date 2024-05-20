create extension if not exists conninfo;

select * from conninfo_parse('postgresql://user:pass@localhost:5432/postgres?target_session_attrs=read-write');
