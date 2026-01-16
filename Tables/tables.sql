CREATE TABLE kategoriak(
    kat_id NUMBER CONSTRAINT kategoriak_pk PRIMARY KEY, 
    megnevezes VARCHAR2(50) NOT NULL
);

CREATE TABLE termek(
    terem_id NUMBER CONSTRAINT termek_pk PRIMARY KEY,
    nev VARCHAR2(50) NOT NULL,
    kapacitas NUMBER NOT NULL CONSTRAINT pozitiv_kapacitas_chk CHECK (kapacitas > 0)
);

CREATE TABLE ugyfelek(
    ugyfel_id NUMBER CONSTRAINT ugyfelek_pk PRIMARY KEY,
    nev VARCHAR2(100) NOT NULL,
    email VARCHAR2(100) NOT NULL CONSTRAINT email_uq UNIQUE,
    torzsvasarloi_pontok NUMBER DEFAULT 0
);

CREATE TABLE filmek(
    film_id NUMBER CONSTRAINT filmek_pk PRIMARY KEY,
    cim VARCHAR2(100) NOT NULL,
    hossz_perc NUMBER NOT NULL,
    korhatar NUMBER DEFAULT 0,
    kat_id NUMBER CONSTRAINT film_kat_fk REFERENCES kategoriak(kat_id) 
);

CREATE TABLE vetitesek(
    vetites_id NUMBER CONSTRAINT vetitesek_pk PRIMARY KEY,
    film_id NUMBER CONSTRAINT vet_film_fk REFERENCES filmek(film_id),
    terem_id NUMBER CONSTRAINT vet_terem_fk REFERENCES termek(terem_id),
    kezdes_ido DATE DEFAULT sysdate NOT NULL
);

CREATE TABLE jegyek(
    jegy_id NUMBER CONSTRAINT jegyek_pk PRIMARY KEY,
    vetites_id NUMBER CONSTRAINT jegy_vetites_fk REFERENCES vetitesek(vetites_id),
    ugyfel_id NUMBER CONSTRAINT jegy_ugyfel_fk REFERENCES ugyfelek(ugyfel_id),
    szek_szam NUMBER NOT NULL,
    ar NUMBER NOT NULL,
    vasarlas_datuma DATE DEFAULT sysdate,
    status VARCHAR2(20) CONSTRAINT jegy_status_chk CHECK (status IN ('FOGLALT', 'FIZETVE', 'TOROLT')) NOT NULL
);

CREATE TABLE jegy_history(
    history_id NUMBER CONSTRAINT history_pk PRIMARY KEY,
    jegy_id NUMBER, 
    regi_status VARCHAR2(20),
    uj_status VARCHAR2(20),
    modositas_datuma DATE DEFAULT sysdate,
    felhasznalo VARCHAR2(50), 
    muvelet VARCHAR2(20)
);
