DECLARE
  -- Asszociatív tömb (kulcs-érték pár) létrehozása
  TYPE t_film_lista IS TABLE OF ty_film_adat INDEX BY VARCHAR2(100);
  
  v_filmek t_film_lista;
  v_obj    ty_film_adat;
  v_idx    VARCHAR2(100);
BEGIN
  dbms_output.put_line('--- OBJEKTUM ES TOMB TESZT ---');

  -- 1. Elemek hozzáadása (JAVÍTVA: 3 paraméter kell!)
  -- (Cím, Hossz, Kategória)
  v_filmek('Avatar') := ty_film_adat('Avatar: A viz utja', 192, 'Sci-Fi');
  v_filmek('Barbie') := ty_film_adat('Barbie', 114, 'Vígjáték');
  
  -- 2. Bejárás (Loop)
  v_idx := v_filmek.first;
  
  WHILE v_idx IS NOT NULL
  LOOP
    v_obj := v_filmek(v_idx);
    
    -- JAVÍTVA: A függvény neve get_info() lett!
    dbms_output.put_line(v_obj.get_info());
    
    v_idx := v_filmek.next(v_idx);
  END LOOP;
  
  dbms_output.put_line('---------------------------------------');
END;
/
