DECLARE
  v_pontok_elotte NUMBER;
  v_pontok_utana  NUMBER;
  v_ugyfel_id     NUMBER;
  v_vetites_id    NUMBER;
BEGIN
  SELECT MIN(ugyfel_id) INTO v_ugyfel_id FROM ugyfel;
  SELECT MIN(vetites_id) INTO v_vetites_id FROM vetites;

  dbms_output.put_line('--- PONTGYUJTES TESZT ---');

  SELECT torzsvasarloi_pontok
    INTO v_pontok_elotte
    FROM ugyfel 
   WHERE ugyfel_id = v_ugyfel_id;

  dbms_output.put_line('Pontok vasarlas elott: ' || v_pontok_elotte);

  dbms_output.put_line('>>> Jegyvasarlas folyamatban...');
  
  mozi_manager.jegy_vasarlas(v_vetites_id, v_ugyfel_id, 99);
  
  COMMIT;

  SELECT torzsvasarloi_pontok
    INTO v_pontok_utana
    FROM ugyfel
   WHERE ugyfel_id = v_ugyfel_id;

  dbms_output.put_line('Pontok vasarlas utan: ' || v_pontok_utana);

  IF v_pontok_utana > v_pontok_elotte THEN
    dbms_output.put_line('SIKER! A pontok jovairva.');
  ELSE
    dbms_output.put_line('HIBA! A pontok nem valtoztak (lehet, hogy nem volt FIZETVE statusz?)');
  END IF;

  dbms_output.put_line('------------------------------');
END;
/
