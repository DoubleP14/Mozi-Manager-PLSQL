-- 1. Típus létrehozás
CREATE OR REPLACE TYPE ty_film_adat AS OBJECT (
    film_cim    VARCHAR2(100),
    hossz_perc  NUMBER,
    kategoria   VARCHAR2(50),
    MEMBER FUNCTION get_info RETURN VARCHAR2
);
/

-- 2. Típus törzs
CREATE OR REPLACE TYPE BODY ty_film_adat AS
    MEMBER FUNCTION get_info RETURN VARCHAR2 IS
    BEGIN
        RETURN self.film_cim || ' (' || self.hossz_perc || ' perc) - ' || self.kategoria;
    END;
END;
/

ALTER PACKAGE mozi_manager COMPILE BODY;
