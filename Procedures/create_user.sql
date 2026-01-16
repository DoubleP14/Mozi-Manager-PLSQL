DECLARE
  v_count NUMBER;
BEGIN
  SELECT COUNT(*)
    INTO v_count
    FROM dba_users t
   WHERE t.username = 'MOZI_GAZDA';

  IF v_count = 1
  THEN
    EXECUTE IMMEDIATE 'drop user mozi_gazda cascade';
  END IF;
END;
/

CREATE USER mozi_gazda identified BY "12345678" DEFAULT tablespace users quota unlimited ON users;

grant CREATE session TO mozi_gazda;
grant CREATE TABLE TO mozi_gazda;
grant CREATE view TO mozi_gazda;
grant CREATE PROCEDURE TO mozi_gazda;
grant CREATE TRIGGER TO mozi_gazda;
grant CREATE job TO mozi_gazda;
grant CREATE sequence TO mozi_gazda;
grant CREATE TYPE TO mozi_gazda;
