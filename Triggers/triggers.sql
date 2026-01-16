-- === KATEGORIA ===
CREATE OR REPLACE TRIGGER trg_kategoria_biu
BEFORE INSERT OR UPDATE ON kategoria FOR EACH ROW
BEGIN
    IF INSERTING THEN
        IF :NEW.kategoria_id IS NULL THEN :NEW.kategoria_id := seq_kategoria.nextval; END IF;
        :NEW.letrehozva := SYSDATE; :NEW.letrehozta := USER;
    END IF;
    :NEW.modositva := SYSDATE; :NEW.modositotta := USER;
END;
/
CREATE OR REPLACE TRIGGER trg_kategoria_aiud
AFTER INSERT OR UPDATE OR DELETE ON kategoria FOR EACH ROW
DECLARE v_muvelet VARCHAR2(10);
BEGIN
    IF INSERTING THEN v_muvelet := 'INSERT'; ELSIF UPDATING THEN v_muvelet := 'UPDATE'; ELSE v_muvelet := 'DELETE'; END IF;
    INSERT INTO kategoria_history (kategoria_id, megnevezes, muvelet, modositas_ideje, modosito_felhasznalo)
    VALUES (NVL(:NEW.kategoria_id, :OLD.kategoria_id), NVL(:NEW.megnevezes, :OLD.megnevezes), v_muvelet, SYSDATE, USER);
END;
/

-- === FILM ===
CREATE OR REPLACE TRIGGER trg_film_biu
BEFORE INSERT OR UPDATE ON film FOR EACH ROW
BEGIN
    IF INSERTING THEN
        IF :NEW.film_id IS NULL THEN :NEW.film_id := seq_film.nextval; END IF;
        :NEW.letrehozva := SYSDATE; :NEW.letrehozta := USER;
    END IF;
    :NEW.modositva := SYSDATE; :NEW.modositotta := USER;
END;
/
CREATE OR REPLACE TRIGGER trg_film_aiud
AFTER INSERT OR UPDATE OR DELETE ON film FOR EACH ROW
DECLARE v_muvelet VARCHAR2(10);
BEGIN
    IF INSERTING THEN v_muvelet := 'INSERT'; ELSIF UPDATING THEN v_muvelet := 'UPDATE'; ELSE v_muvelet := 'DELETE'; END IF;
    INSERT INTO film_history (film_id, cim, hossz_perc, kategoria_id, muvelet, modositas_ideje, modosito_felhasznalo)
    VALUES (NVL(:NEW.film_id, :OLD.film_id), NVL(:NEW.cim, :OLD.cim), NVL(:NEW.hossz_perc, :OLD.hossz_perc), NVL(:NEW.kategoria_id, :OLD.kategoria_id), v_muvelet, SYSDATE, USER);
END;
/

-- === TEREM ===
CREATE OR REPLACE TRIGGER trg_terem_biu
BEFORE INSERT OR UPDATE ON terem FOR EACH ROW
BEGIN
    IF INSERTING THEN
        IF :NEW.terem_id IS NULL THEN :NEW.terem_id := seq_terem.nextval; END IF;
        :NEW.letrehozva := SYSDATE; :NEW.letrehozta := USER;
    END IF;
    :NEW.modositva := SYSDATE; :NEW.modositotta := USER;
END;
/
CREATE OR REPLACE TRIGGER trg_terem_aiud
AFTER INSERT OR UPDATE OR DELETE ON terem FOR EACH ROW
DECLARE v_muvelet VARCHAR2(10);
BEGIN
    IF INSERTING THEN v_muvelet := 'INSERT'; ELSIF UPDATING THEN v_muvelet := 'UPDATE'; ELSE v_muvelet := 'DELETE'; END IF;
    INSERT INTO terem_history (terem_id, nev, kapacitas, muvelet, modositas_ideje, modosito_felhasznalo)
    VALUES (NVL(:NEW.terem_id, :OLD.terem_id), NVL(:NEW.nev, :OLD.nev), NVL(:NEW.kapacitas, :OLD.kapacitas), v_muvelet, SYSDATE, USER);
END;
/

-- === VETITES ===
CREATE OR REPLACE TRIGGER trg_vetites_biu
BEFORE INSERT OR UPDATE ON vetites FOR EACH ROW
BEGIN
    IF INSERTING THEN
        IF :NEW.vetites_id IS NULL THEN :NEW.vetites_id := seq_vetites.nextval; END IF;
        :NEW.letrehozva := SYSDATE; :NEW.letrehozta := USER;
    END IF;
    :NEW.modositva := SYSDATE; :NEW.modositotta := USER;
END;
/
CREATE OR REPLACE TRIGGER trg_vetites_aiud
AFTER INSERT OR UPDATE OR DELETE ON vetites FOR EACH ROW
DECLARE v_muvelet VARCHAR2(10);
BEGIN
    IF INSERTING THEN v_muvelet := 'INSERT'; ELSIF UPDATING THEN v_muvelet := 'UPDATE'; ELSE v_muvelet := 'DELETE'; END IF;
    INSERT INTO vetites_history (vetites_id, film_id, terem_id, kezdes_ido, muvelet, modositas_ideje, modosito_felhasznalo)
    VALUES (NVL(:NEW.vetites_id, :OLD.vetites_id), NVL(:NEW.film_id, :OLD.film_id), NVL(:NEW.terem_id, :OLD.terem_id), NVL(:NEW.kezdes_ido, :OLD.kezdes_ido), v_muvelet, SYSDATE, USER);
END;
/

-- === UGYFEL ===
CREATE OR REPLACE TRIGGER trg_ugyfel_biu
BEFORE INSERT OR UPDATE ON ugyfel FOR EACH ROW
BEGIN
    IF INSERTING THEN
        IF :NEW.ugyfel_id IS NULL THEN :NEW.ugyfel_id := seq_ugyfel.nextval; END IF;
        :NEW.letrehozva := SYSDATE; :NEW.letrehozta := USER;
    END IF;
    :NEW.modositva := SYSDATE; :NEW.modositotta := USER;
END;
/
CREATE OR REPLACE TRIGGER trg_ugyfel_aiud
AFTER INSERT OR UPDATE OR DELETE ON ugyfel FOR EACH ROW
DECLARE v_muvelet VARCHAR2(10);
BEGIN
    IF INSERTING THEN v_muvelet := 'INSERT'; ELSIF UPDATING THEN v_muvelet := 'UPDATE'; ELSE v_muvelet := 'DELETE'; END IF;
    INSERT INTO ugyfel_history (ugyfel_id, nev, email, torzsvasarloi_pontok, muvelet, modositas_ideje, modosito_felhasznalo)
    VALUES (NVL(:NEW.ugyfel_id, :OLD.ugyfel_id), NVL(:NEW.nev, :OLD.nev), NVL(:NEW.email, :OLD.email), NVL(:NEW.torzsvasarloi_pontok, :OLD.torzsvasarloi_pontok), v_muvelet, SYSDATE, USER);
END;
/

-- === JEGY ===
CREATE OR REPLACE TRIGGER trg_jegy_biu
BEFORE INSERT OR UPDATE ON jegy FOR EACH ROW
BEGIN
    IF INSERTING THEN
        IF :NEW.jegy_id IS NULL THEN :NEW.jegy_id := seq_jegy.nextval; END IF;
        :NEW.letrehozva := SYSDATE; :NEW.letrehozta := USER;
    END IF;
    :NEW.modositva := SYSDATE; :NEW.modositotta := USER;
END;
/
CREATE OR REPLACE TRIGGER trg_jegy_aiud
AFTER INSERT OR UPDATE OR DELETE ON jegy FOR EACH ROW
DECLARE v_muvelet VARCHAR2(10);
BEGIN
    IF INSERTING THEN v_muvelet := 'INSERT'; ELSIF UPDATING THEN v_muvelet := 'UPDATE'; ELSE v_muvelet := 'DELETE'; END IF;
    INSERT INTO jegy_history (jegy_id, vetites_id, ugyfel_id, szek_szam, ar, status, muvelet, modositas_ideje, modosito_felhasznalo)
    VALUES (NVL(:NEW.jegy_id, :OLD.jegy_id), NVL(:NEW.vetites_id, :OLD.vetites_id), NVL(:NEW.ugyfel_id, :OLD.ugyfel_id), NVL(:NEW.szek_szam, :OLD.szek_szam), NVL(:NEW.ar, :OLD.ar), NVL(:NEW.status, :OLD.status), v_muvelet, SYSDATE, USER);
END;
/

-- === PONTGYUJTES ===
CREATE OR REPLACE TRIGGER trg_pontgyujtes
AFTER INSERT OR UPDATE ON jegy FOR EACH ROW
BEGIN
  IF :NEW.status = 'FIZETVE' AND (:OLD.status IS NULL OR :OLD.status <> 'FIZETVE') THEN
    UPDATE ugyfel
       SET torzsvasarloi_pontok = torzsvasarloi_pontok + 10
     WHERE ugyfel_id = :NEW.ugyfel_id;
  END IF;
END;
/
