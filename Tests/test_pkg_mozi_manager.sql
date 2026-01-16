DECLARE
  v_db NUMBER;
BEGIN

  dbms_output.put_line('>>> FILM STATISZTIKA TESZT:');
  mozi_manager.film_statisztika(10000); 

  dbms_output.put_line('--------------------------------');

  dbms_output.put_line('>>> DINAMIKUS SQL TESZT:');

  v_db := mozi_manager.sorok_szama('JEGY');
  dbms_output.put_line('Jegyek szama: ' || v_db);

  v_db := mozi_manager.sorok_szama('FILM');
  dbms_output.put_line('Filmek szama: ' || v_db);

  v_db := mozi_manager.sorok_szama('KUTYAK');
  dbms_output.put_line('Kutyak szama (hiba eseten -1): ' || v_db);
END;
/
