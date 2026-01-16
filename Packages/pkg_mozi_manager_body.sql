CREATE OR REPLACE PACKAGE BODY mozi_manager IS

  FUNCTION szabad_helyek(p_vetites_id IN NUMBER) RETURN NUMBER IS
    v_kapacitas NUMBER;
    v_foglalt   NUMBER;
  BEGIN
    SELECT t.kapacitas
      INTO v_kapacitas
      FROM vetitesek v
      JOIN termek t
        ON v.terem_id = t.terem_id
     WHERE v.vetites_id = p_vetites_id;
  
    SELECT COUNT(*)
      INTO v_foglalt
      FROM jegyek
     WHERE vetites_id = p_vetites_id
       AND status <> 'TOROLT';
  
    RETURN v_kapacitas - v_foglalt;
  EXCEPTION
    WHEN no_data_found THEN
      RETURN 0;
  END szabad_helyek;

  PROCEDURE jegy_vasarlas(p_vetites_id IN NUMBER
                         ,p_ugyfel_id  IN NUMBER
                         ,p_szek_szam  IN NUMBER) IS
    v_ar         NUMBER := 2500;
    v_foglalt_db NUMBER;
    v_dummy      NUMBER;
    v_pontok     NUMBER;
    e_foglalt_szek  EXCEPTION;
    e_nincs_vetites EXCEPTION;
  BEGIN
    BEGIN
      SELECT 1
        INTO v_dummy
        FROM vetitesek
       WHERE vetites_id = p_vetites_id
         FOR UPDATE;
    EXCEPTION
      WHEN no_data_found THEN
        RAISE e_nincs_vetites;
    END;
  
    BEGIN
      SELECT torzsvasarloi_pontok
        INTO v_pontok
        FROM ugyfelek
       WHERE ugyfel_id = p_ugyfel_id;
      IF v_pontok > 50
      THEN
        v_ar := 2000;
      END IF;
    EXCEPTION
      WHEN OTHERS THEN
        NULL;
    END;
  
    SELECT COUNT(*)
      INTO v_foglalt_db
      FROM jegyek
     WHERE vetites_id = p_vetites_id
       AND szek_szam = p_szek_szam
       AND status <> 'TOROLT';
  
    IF v_foglalt_db > 0
    THEN
      RAISE e_foglalt_szek;
    END IF;
  
    INSERT INTO jegyek
      (jegy_id
      ,vetites_id
      ,ugyfel_id
      ,szek_szam
      ,ar
      ,vasarlas_datuma
      ,status)
    VALUES
      (seq_jegyek.nextval
      ,p_vetites_id
      ,p_ugyfel_id
      ,p_szek_szam
      ,v_ar
      ,SYSDATE
      ,'FIZETVE');
  
    COMMIT;
    dbms_output.put_line('Sikeres v�s�rl�s (Package)! Jegy: ' ||
                         seq_jegyek.currval);
  
  EXCEPTION
    WHEN e_foglalt_szek THEN
      ROLLBACK;
      dbms_output.put_line('HIBA: A sz�k m�r foglalt!');
    WHEN e_nincs_vetites THEN
      ROLLBACK;
      dbms_output.put_line('HIBA: Nincs ilyen vet�t�s!');
    WHEN OTHERS THEN
      ROLLBACK;
      dbms_output.put_line('V�ratlan hiba: ' || SQLERRM);
  END jegy_vasarlas;

  PROCEDURE film_statisztika(p_film_id IN NUMBER) IS
    CURSOR c_vetitesek IS
      SELECT vetites_id
            ,kezdes_ido
            ,terem_id
        FROM vetitesek
       WHERE film_id = p_film_id
       ORDER BY kezdes_ido;
  
    v_szabad NUMBER;
  BEGIN
    dbms_output.put_line('--- Statisztika a ' || p_film_id ||
                         ' ID-j� filmhez ---');
  
    FOR r_vetites IN c_vetitesek
    LOOP
      v_szabad := szabad_helyek(r_vetites.vetites_id);
      dbms_output.put_line('Vet�t�s ID: ' || r_vetites.vetites_id ||
                           ' | Id�pont: ' ||
                           to_char(r_vetites.kezdes_ido,
                                   'YYYY-MM-DD HH24:MI') ||
                           ' | Szabad helyek: ' || v_szabad);
    END LOOP;
  
    dbms_output.put_line('--- Statisztika v�ge ---');
  END film_statisztika;

  FUNCTION sorok_szama(p_tabla_nev IN VARCHAR2) RETURN NUMBER IS
    v_sql_parancs VARCHAR2(200);
    v_darab       NUMBER;
  BEGIN
    v_sql_parancs := 'SELECT COUNT(*) FROM ' || p_tabla_nev;
    EXECUTE IMMEDIATE v_sql_parancs
      INTO v_darab;
    RETURN v_darab;
  EXCEPTION
    WHEN OTHERS THEN
      dbms_output.put_line('Hiba: Nem l�tez� t�bla (' || p_tabla_nev || ')');
      RETURN - 1;
  END sorok_szama;

END mozi_manager;
/
