CREATE OR REPLACE PACKAGE BODY mozi_manager IS

  -- Hibanaplózás 
  PROCEDURE log_error(p_msg IN VARCHAR2, p_proc IN VARCHAR2) IS
    PRAGMA AUTONOMOUS_TRANSACTION;
    v_code NUMBER; 
  BEGIN
    v_code := SQLCODE;
    INSERT INTO hiba_naplo (hiba_id, hiba_kod, hiba_uzenet, eljaras_neve, felhasznalo)
    VALUES (seq_hiba.nextval, v_code, p_msg, p_proc, USER);
    COMMIT; 
  END log_error;

  -- 1. SZABAD HELYEK
  FUNCTION szabad_helyek(p_vetites_id IN NUMBER) RETURN NUMBER IS
    v_kapacitas NUMBER;
    v_foglalt   NUMBER;
  BEGIN
    SELECT t.kapacitas INTO v_kapacitas
      FROM vetites v JOIN terem t ON v.terem_id = t.terem_id
     WHERE v.vetites_id = p_vetites_id;
  
    SELECT COUNT(*) INTO v_foglalt FROM jegy
     WHERE vetites_id = p_vetites_id AND status <> 'TOROLT';
  
    RETURN v_kapacitas - v_foglalt;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN 
        log_error('Nem létezõ vetítés ID: ' || p_vetites_id, 'szabad_helyek');
        RETURN 0;
  END szabad_helyek;

  -- 2. JEGYVÁSÁRLÁS
  PROCEDURE jegy_vasarlas(p_vetites_id IN NUMBER, p_ugyfel_id IN NUMBER, p_szek_szam IN NUMBER) IS
    v_ar         NUMBER := 2500;
    v_foglalt_db NUMBER;
    v_pontok     NUMBER;
    v_dummy      NUMBER;
    e_foglalt_szek EXCEPTION;
  BEGIN
    SELECT 1 INTO v_dummy FROM vetites WHERE vetites_id = p_vetites_id FOR UPDATE;

    SELECT torzsvasarloi_pontok INTO v_pontok FROM ugyfel WHERE ugyfel_id = p_ugyfel_id;
    IF v_pontok > 50 THEN 
        v_ar := 2000; 
        dbms_output.put_line('Kedvezmény!');
    END IF;
  
    SELECT COUNT(*) INTO v_foglalt_db FROM jegy
     WHERE vetites_id = p_vetites_id AND szek_szam = p_szek_szam AND status <> 'TOROLT';
  
    IF v_foglalt_db > 0 THEN RAISE e_foglalt_szek; END IF;
  
    INSERT INTO jegy (vetites_id, ugyfel_id, szek_szam, ar, status)
    VALUES (p_vetites_id, p_ugyfel_id, p_szek_szam, v_ar, 'FIZETVE');
    
    dbms_output.put_line('Jegy rögzítve.');

  EXCEPTION
    WHEN e_foglalt_szek THEN
       log_error('Foglalt székre próbáltak foglalni. Vetítés: ' || p_vetites_id || ' Szék: ' || p_szek_szam, 'jegy_vasarlas');
       RAISE_APPLICATION_ERROR(-20001, 'A szék már foglalt!');
    WHEN OTHERS THEN
       log_error(SQLERRM, 'jegy_vasarlas');
       RAISE;
  END jegy_vasarlas;

  -- 3. STATISZTIKA
  PROCEDURE film_statisztika(p_film_id IN NUMBER) IS
    CURSOR c_vetitesek IS SELECT vetites_id, kezdes_ido FROM vetites WHERE film_id = p_film_id;
    v_szabad NUMBER;
  BEGIN
    FOR r IN c_vetitesek LOOP
      v_szabad := szabad_helyek(r.vetites_id);
      dbms_output.put_line('Idõ: ' || r.kezdes_ido || ' Szabad: ' || v_szabad);
    END LOOP;
  END film_statisztika;

  -- 4. DINAMIKUS SQL
  FUNCTION sorok_szama(p_tabla_nev IN VARCHAR2) RETURN NUMBER IS
    v_db NUMBER;
  BEGIN
    EXECUTE IMMEDIATE 'SELECT COUNT(*) FROM ' || p_tabla_nev INTO v_db;
    RETURN v_db;
  EXCEPTION WHEN OTHERS THEN log_error(SQLERRM, 'sorok_szama'); RETURN -1;
  END sorok_szama;
  
  -- 5. OBJEKTUM VISSZAADÁSA
  FUNCTION get_film_adatok(p_film_id IN NUMBER) RETURN ty_film_adat IS
    v_obj ty_film_adat;
  BEGIN
    SELECT ty_film_adat(f.cim, f.hossz_perc, k.megnevezes)
      INTO v_obj
      FROM film f JOIN kategoria k ON f.kategoria_id = k.kategoria_id
     WHERE f.film_id = p_film_id;
    RETURN v_obj;
  EXCEPTION WHEN OTHERS THEN log_error(SQLERRM, 'get_film_adatok'); RETURN NULL;
  END get_film_adatok;

END mozi_manager;
/
