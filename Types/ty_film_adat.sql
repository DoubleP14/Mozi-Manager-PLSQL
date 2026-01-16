CREATE OR REPLACE TYPE ty_film_adat AS OBJECT
(
  film_cime VARCHAR2(100),
  bevetel   NUMBER,

  MEMBER FUNCTION get_formazott_adat RETURN VARCHAR2
)
;
/

CREATE OR REPLACE TYPE BODY ty_film_adat AS MEMBER FUNCTION get_formazott_adat RETURN VARCHAR2 IS BEGIN RETURN 'Film: ' || self.film_cime || ' | Bev�tel: ' || self.bevetel || ' Ft'; END; END;
/
