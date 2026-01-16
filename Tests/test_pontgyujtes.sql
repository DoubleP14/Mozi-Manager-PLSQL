DECLARE
  v_pontok_elotte NUMBER;
  v_pontok_utana  NUMBER;
  v_ugyfel_id     NUMBER := 10000; -- Minta Janos ID
BEGIN
  dbms_output.put_line('--- PONTGY�JT�S TESZT ---');

  SELECT torzsvasarloi_pontok
    INTO v_pontok_elotte
    FROM ugyfelek
   WHERE ugyfel_id = v_ugyfel_id;

  dbms_output.put_line('Pontok v�s�rl�s el�tt: ' || v_pontok_elotte);

  dbms_output.put_line('>>> Jegyv�s�rl�s folyamatban...');
  mozi_manager.jegy_vasarlas(10000, v_ugyfel_id, 88);

  SELECT torzsvasarloi_pontok
    INTO v_pontok_utana
    FROM ugyfelek
   WHERE ugyfel_id = v_ugyfel_id;

  dbms_output.put_line('Pontok v�s�rl�s ut�n: ' || v_pontok_utana);

  IF v_pontok_utana > v_pontok_elotte
  THEN
    dbms_output.put_line('SIKER! A pontok j�v��rva.');
  ELSE
    dbms_output.put_line('HIBA! A pontok nem v�ltoztak.');
  END IF;

  dbms_output.put_line('-------------------------');
END;
/
