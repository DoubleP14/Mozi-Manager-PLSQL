CREATE OR REPLACE TRIGGER trg_jegy_naplozas
  AFTER INSERT OR UPDATE OR DELETE ON jegyek
  FOR EACH ROW
DECLARE
  v_muvelet VARCHAR2(20);
BEGIN
  IF inserting
  THEN
    v_muvelet := 'INSERT';
    INSERT INTO jegy_history
      (history_id
      ,jegy_id
      ,regi_status
      ,uj_status
      ,modositas_datuma
      ,felhasznalo
      ,muvelet)
    VALUES
      (seq_history.nextval
      ,:new.jegy_id
      ,NULL
      ,:new.status
      ,SYSDATE
      ,USER
      ,v_muvelet);
  
  ELSIF updating
  THEN
    v_muvelet := 'UPDATE';
    INSERT INTO jegy_history
      (history_id
      ,jegy_id
      ,regi_status
      ,uj_status
      ,modositas_datuma
      ,felhasznalo
      ,muvelet)
    VALUES
      (seq_history.nextval
      ,:new.jegy_id
      ,:old.status
      ,:new.status
      ,SYSDATE
      ,USER
      ,v_muvelet);
  
  ELSIF deleting
  THEN
    v_muvelet := 'DELETE';
    INSERT INTO jegy_history
      (history_id
      ,jegy_id
      ,regi_status
      ,uj_status
      ,modositas_datuma
      ,felhasznalo
      ,muvelet)
    VALUES
      (seq_history.nextval
      ,:old.jegy_id
      ,:old.status
      ,NULL
      ,SYSDATE
      ,USER
      ,v_muvelet);
  END IF;
END;
/
