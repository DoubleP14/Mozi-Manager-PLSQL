INSERT INTO kategoria (megnevezes) VALUES ('Akció');
INSERT INTO kategoria (megnevezes) VALUES ('Vígjáték');
INSERT INTO kategoria (megnevezes) VALUES ('Sci-Fi');
COMMIT;

INSERT INTO terem
  (nev
  ,kapacitas)
VALUES
  ('Nagyterem'
  ,120);
INSERT INTO terem
  (nev
  ,kapacitas)
VALUES
  ('VIP Terem'
  ,30);
COMMIT;

INSERT INTO film
  (cim
  ,hossz_perc
  ,kategoria_id)
VALUES
  ('Mission Impossible'
  ,140
  ,1);
INSERT INTO film
  (cim
  ,hossz_perc
  ,kategoria_id)
VALUES
  ('Barbie'
  ,114
  ,2);
INSERT INTO film
  (cim
  ,hossz_perc
  ,kategoria_id)
VALUES
  ('Avatar: A víz útja'
  ,192
  ,3);
COMMIT;

INSERT INTO vetites
  (film_id
  ,terem_id
  ,kezdes_ido)
VALUES
  ((SELECT film_id FROM film WHERE cim = 'Mission Impossible')
  ,1
  ,SYSDATE + 2 / 24);

INSERT INTO vetites
  (film_id
  ,terem_id
  ,kezdes_ido)
VALUES
  ((SELECT film_id FROM film WHERE cim = 'Barbie')
  ,2
  ,to_date('2025-05-20 18:00', 'YYYY-MM-DD HH24:MI'));
COMMIT;

INSERT INTO ugyfel
  (nev
  ,email
  ,torzsvasarloi_pontok)
VALUES
  ('Minta János'
  ,'janos@example.com'
  ,10);
INSERT INTO ugyfel
  (nev
  ,email
  ,torzsvasarloi_pontok)
VALUES
  ('Teszt Elek'
  ,'elek@example.com'
  ,60);
COMMIT;
