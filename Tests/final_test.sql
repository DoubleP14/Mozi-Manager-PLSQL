DECLARE
    -- Változók deklarálása
    v_vetites_id NUMBER;
    v_ugyfel_id  NUMBER;
    v_film_id    NUMBER;
    v_film_info  ty_film_adat;
BEGIN
    dbms_output.put_line('>>> TESZT INDÍTÁSA... <<<');

    SELECT MIN(vetites_id) INTO v_vetites_id FROM vetites;
    SELECT MIN(ugyfel_id) INTO v_ugyfel_id FROM ugyfel;
    SELECT MIN(film_id) INTO v_film_id FROM film;

    -- 1. Jegyvásárlás hívása
    dbms_output.put_line('--- Jegyvásárlás folyamat ---');
    mozi_manager.jegy_vasarlas(v_vetites_id, v_ugyfel_id, 15);
    
    COMMIT; 

    -- 2. Objektum és függvény tesztelése
    dbms_output.put_line('--- Film adatok lekérése (Type) ---');
    v_film_info := mozi_manager.get_film_adatok(v_film_id);
    
    dbms_output.put_line('Film info: ' || v_film_info.get_info());
    dbms_output.put_line('>>> MINDEN MÛKÖDIK! SIKER! <<<');
EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line('HIBA: ' || SQLERRM);
END;
/
