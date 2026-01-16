DECLARE
  v_helyek_elotte NUMBER;
  v_helyek_utana  NUMBER;
BEGIN
  dbms_output.put_line('--- TESZT INDUL�SA ---');

  v_helyek_elotte := mozi_manager.szabad_helyek(10000);
  dbms_output.put_line('Szabad helyek kezdetben: ' || v_helyek_elotte);

  dbms_output.put_line('>>> Jegyv�s�rl�s ind�t�sa...');
  mozi_manager.jegy_vasarlas(10000, 10000, 20);

  v_helyek_utana := mozi_manager.szabad_helyek(10000);
  dbms_output.put_line('Szabad helyek v�s�rl�s ut�n: ' || v_helyek_utana);

  dbms_output.put_line('--- TESZT V�GE ---');
END;
/
