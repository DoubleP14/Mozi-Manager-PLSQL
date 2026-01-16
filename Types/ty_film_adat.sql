-- 1. Típus létrehozása (Fejléc)
CREATE OR REPLACE TYPE ty_film_adat AS OBJECT (
    film_cim    VARCHAR2(100),
    hossz_perc  NUMBER,
    kategoria   VARCHAR2(50),
    MEMBER FUNCTION get_info RETURN VARCHAR2
);
/

-- 2. Típus törzse (Logika)
CREATE OR REPLACE TYPE BODY ty_film_adat AS
    MEMBER FUNCTION get_info RETURN VARCHAR2 IS
    BEGIN
        RETURN self.film_cim || ' (' || self.hossz_perc || ' perc) - ' || self.kategoria;
    END;
END;
/

-- 3. A Csomag "megrugdosása" (Újrafordítás)
ALTER PACKAGE mozi_manager COMPILE BODY;
