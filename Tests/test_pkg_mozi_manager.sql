DECLARE
  v_db NUMBER;
BEGIN

  dbms_output.put_line('>>> FILM STATISZTIKA TESZT:');
  -- Itt használj egy létezõ ID-t, pl. amit a SELECT MIN(film_id) ad vissza
  -- Ha a 10000 nem létezik, akkor üres lesz, de nem hiba.
  mozi_manager.film_statisztika(10000); 

  dbms_output.put_line('--------------------------------');

  dbms_output.put_line('>>> DINAMIKUS SQL TESZT:');

  -- JAVÍTVA: 'JEGY' (egyes szám)
  v_db := mozi_manager.sorok_szama('JEGY');
  dbms_output.put_line('Jegyek szama: ' || v_db);

  -- JAVÍTVA: 'FILM' (egyes szám)
  v_db := mozi_manager.sorok_szama('FILM');
  dbms_output.put_line('Filmek szama: ' || v_db);

  -- Ez maradjon így, ez teszteli a hibát!
  v_db := mozi_manager.sorok_szama('KUTYAK');
  dbms_output.put_line('Kutyak szama (hiba eseten -1): ' || v_db);
END;
/
