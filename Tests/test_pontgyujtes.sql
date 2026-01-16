DECLARE
  v_pontok_elotte NUMBER;
  v_pontok_utana  NUMBER;
  v_ugyfel_id     NUMBER;
  v_vetites_id    NUMBER;
BEGIN
  -- 1. Szerezzünk valódi ID-kat az adatbázisból (hogy biztosan mûködjön)
  SELECT MIN(ugyfel_id) INTO v_ugyfel_id FROM ugyfel;
  SELECT MIN(vetites_id) INTO v_vetites_id FROM vetites;

  dbms_output.put_line('--- PONTGYUJTES TESZT ---');

  -- 2. Pontok lekérdezése vásárlás elõtt (JAVÍTVA: 'ugyfel' tábla)
  SELECT torzsvasarloi_pontok
    INTO v_pontok_elotte
    FROM ugyfel 
   WHERE ugyfel_id = v_ugyfel_id;

  dbms_output.put_line('Pontok vasarlas elott: ' || v_pontok_elotte);

  dbms_output.put_line('>>> Jegyvasarlas folyamatban...');
  
  -- 3. Vásárlás (Valós ID-kkal, pl. a 99-es székre)
  mozi_manager.jegy_vasarlas(v_vetites_id, v_ugyfel_id, 99);
  
  -- 4. Tranzakció lezárása (FONTOS, hogy a trigger fusson és bekerüljön a pont)
  COMMIT;

  -- 5. Pontok lekérdezése vásárlás után (JAVÍTVA: 'ugyfel' tábla)
  SELECT torzsvasarloi_pontok
    INTO v_pontok_utana
    FROM ugyfel
   WHERE ugyfel_id = v_ugyfel_id;

  dbms_output.put_line('Pontok vasarlas utan: ' || v_pontok_utana);

  -- 6. Kiértékelés
  IF v_pontok_utana > v_pontok_elotte THEN
    dbms_output.put_line('SIKER! A pontok jovairva.');
  ELSE
    dbms_output.put_line('HIBA! A pontok nem valtoztak (lehet, hogy nem volt FIZETVE statusz?)');
  END IF;

  dbms_output.put_line('------------------------------');
END;
/
