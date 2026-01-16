CREATE OR REPLACE PACKAGE mozi_manager IS

  FUNCTION szabad_helyek(p_vetites_id IN NUMBER) RETURN NUMBER;

  PROCEDURE jegy_vasarlas(p_vetites_id IN NUMBER
                         ,p_ugyfel_id  IN NUMBER
                         ,p_szek_szam  IN NUMBER);

  PROCEDURE film_statisztika(p_film_id IN NUMBER);

  FUNCTION sorok_szama(p_tabla_nev IN VARCHAR2) RETURN NUMBER;

END mozi_manager;
/
