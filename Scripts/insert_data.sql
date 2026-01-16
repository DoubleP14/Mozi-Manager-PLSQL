INSERT INTO kategoriak
  (kat_id
  ,megnevezes)
VALUES
  (seq_kategoriak.nextval
  ,'Akció');
INSERT INTO kategoriak
  (kat_id
  ,megnevezes)
VALUES
  (seq_kategoriak.nextval
  ,'Vígjáték');
INSERT INTO kategoriak
  (kat_id
  ,megnevezes)
VALUES
  (seq_kategoriak.nextval
  ,'Sci-Fi');

INSERT INTO termek
  (terem_id
  ,nev
  ,kapacitas)
VALUES
  (seq_termek.nextval
  ,'Nagyterem'
  ,120);

INSERT INTO termek
  (terem_id
  ,nev
  ,kapacitas)
VALUES
  (seq_termek.nextval
  ,'VIP Terem'
  ,30);

INSERT INTO filmek
  (film_id
  ,cim
  ,hossz_perc
  ,korhatar
  ,kat_id)
VALUES
  (seq_filmek.nextval
  ,'Mission Impossible'
  ,140
  ,16
  ,1);

INSERT INTO filmek
  (film_id
  ,cim
  ,hossz_perc
  ,korhatar
  ,kat_id)
VALUES
  (seq_filmek.nextval
  ,'Barbie'
  ,114
  ,0
  ,2);

INSERT INTO filmek
  (film_id
  ,cim
  ,hossz_perc
  ,korhatar
  ,kat_id)
VALUES
  (seq_filmek.nextval
  ,'Avatar: A víz útja'
  ,192
  ,12
  ,3);

INSERT INTO vetitesek
  (vetites_id
  ,film_id
  ,terem_id
  ,kezdes_ido)
VALUES
  (seq_vetitesek.nextval
  ,10000 -- Mission Impossible
  ,1 -- Nagyterem
  ,SYSDATE + 2 / 24);

INSERT INTO vetitesek
  (vetites_id
  ,film_id
  ,terem_id
  ,kezdes_ido)
VALUES
  (seq_vetitesek.nextval
  ,10001 -- Barbie
  ,2 -- VIP
  ,to_date('2025-05-20 18:00', 'YYYY-MM-DD HH24:MI'));

INSERT INTO ugyfelek
  (ugyfel_id
  ,nev
  ,email
  ,torzsvasarloi_pontok)
VALUES
  (seq_ugyfelek.nextval
  ,'Minta J�nos'
  ,'janos@example.com'
  ,10);

INSERT INTO ugyfelek
  (ugyfel_id
  ,nev
  ,email
  ,torzsvasarloi_pontok)
VALUES
  (seq_ugyfelek.nextval
  ,'Teszt Elek'
  ,'elek@example.com'
  ,0);

INSERT INTO jegyek
  (jegy_id
  ,vetites_id
  ,ugyfel_id
  ,szek_szam
  ,ar
  ,vasarlas_datuma
  ,status)
VALUES
  (seq_jegyek.nextval
  ,10000
  ,10000
  ,5
  ,2500
  ,SYSDATE
  ,'FIZETVE');

INSERT INTO jegyek
  (jegy_id
  ,vetites_id
  ,ugyfel_id
  ,szek_szam
  ,ar
  ,vasarlas_datuma
  ,status)
VALUES
  (seq_jegyek.nextval
  ,10000
  ,10001
  ,6
  ,2500
  ,SYSDATE
  ,'FOGLALT');

COMMIT;
