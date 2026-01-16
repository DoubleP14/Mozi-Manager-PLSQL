CREATE OR REPLACE PACKAGE mozi_manager IS
  FUNCTION szabad_helyek(p_vetites_id IN NUMBER) RETURN NUMBER;
  
  PROCEDURE jegy_vasarlas(p_vetites_id IN NUMBER, p_ugyfel_id IN NUMBER, p_szek_szam IN NUMBER);

  PROCEDURE film_statisztika(p_film_id IN NUMBER);

  FUNCTION sorok_szama(p_tabla_nev IN VARCHAR2) RETURN NUMBER;
  
  FUNCTION get_film_adatok(p_film_id IN NUMBER) RETURN ty_film_adat;
  
  PROCEDURE log_error(p_msg IN VARCHAR2, p_proc IN VARCHAR2);
  
END mozi_manager;
/
