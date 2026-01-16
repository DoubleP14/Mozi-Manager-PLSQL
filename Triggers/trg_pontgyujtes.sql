CREATE OR REPLACE TRIGGER trg_pontgyujtes
  AFTER INSERT ON jegyek
  FOR EACH ROW
BEGIN

  IF :new.status = 'FIZETVE'
  THEN
  
    UPDATE ugyfelek
       SET torzsvasarloi_pontok = torzsvasarloi_pontok + 10
     WHERE ugyfel_id = :new.ugyfel_id;
  
  END IF;
END;
/
