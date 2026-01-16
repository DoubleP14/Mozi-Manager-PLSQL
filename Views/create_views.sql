CREATE OR REPLACE VIEW v_musor AS
SELECT 
    f.cim AS film_cime,
    k.megnevezes AS kategoria,
    t.nev AS terem,
    v.kezdes_ido,
    f.hossz_perc
FROM vetitesek v
JOIN filmek f ON v.film_id = f.film_id
JOIN termek t ON v.terem_id = t.terem_id
JOIN kategoriak k ON f.kat_id = k.kat_id; 

CREATE OR REPLACE VIEW v_bevetel_filmenkent AS
SELECT 
    f.cim,
    COUNT(j.jegy_id) AS eladott_jegyek,
    SUM(j.ar) AS osszes_bevetel
FROM filmek f
JOIN vetitesek v ON f.film_id = v.film_id
JOIN jegyek j ON v.vetites_id = j.vetites_id
WHERE j.status = 'FIZETVE'
GROUP BY f.cim;