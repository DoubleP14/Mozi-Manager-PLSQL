CREATE OR REPLACE VIEW v_musor AS
SELECT 
    f.cim AS film_cime,
    k.megnevezes AS kategoria,
    t.nev AS terem,
    v.kezdes_ido,
    f.hossz_perc
FROM vetites v
JOIN film f ON v.film_id = f.film_id
JOIN terem t ON v.terem_id = t.terem_id
JOIN kategoria k ON f.kategoria_id = k.kategoria_id;

CREATE OR REPLACE VIEW v_bevetel_filmenkent AS
SELECT 
    f.cim,
    COUNT(j.jegy_id) AS eladott_jegyek,
    NVL(SUM(j.ar), 0) AS osszes_bevetel
FROM film f
LEFT JOIN vetites v ON f.film_id = v.film_id
LEFT JOIN jegy j ON v.vetites_id = j.vetites_id AND j.status = 'FIZETVE'
GROUP BY f.cim;
