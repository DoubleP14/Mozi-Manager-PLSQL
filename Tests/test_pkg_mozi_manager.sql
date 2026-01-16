DECLARE
  v_db NUMBER;
BEGIN

  dbms_output.put_line('>>> FILM STATISZTIKA TESZT:');
  mozi_manager.film_statisztika(10000);

  dbms_output.put_line('--------------------------------');

  dbms_output.put_line('>>> DINAMIKUS SQL TESZT:');

  v_db := mozi_manager.sorok_szama('JEGYEK');
  dbms_output.put_line('Jegyek sz�ma: ' || v_db);

  v_db := mozi_manager.sorok_szama('FILMEK');
  dbms_output.put_line('Filmek sz�ma: ' || v_db);

  v_db := mozi_manager.sorok_szama('KUTYAK');
  dbms_output.put_line('Kuty�k sz�ma (hiba eset�n -1): ' || v_db);
END;
/
