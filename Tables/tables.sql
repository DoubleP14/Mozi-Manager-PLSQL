-- 1. KATEGORIA
CREATE TABLE kategoria (
    kategoria_id NUMBER CONSTRAINT pk_kategoria PRIMARY KEY,
    megnevezes VARCHAR2(50) NOT NULL,
    letrehozva DATE DEFAULT SYSDATE,
    letrehozta VARCHAR2(50),
    modositva DATE,
    modositotta VARCHAR2(50)
);

CREATE TABLE kategoria_history (
    kategoria_id NUMBER,
    megnevezes VARCHAR2(50),
    muvelet VARCHAR2(10),
    modositas_ideje DATE,
    modosito_felhasznalo VARCHAR2(50)
);

-- 2. TEREM
CREATE TABLE terem (
    terem_id NUMBER CONSTRAINT pk_terem PRIMARY KEY,
    nev VARCHAR2(50) NOT NULL,
    kapacitas NUMBER NOT NULL,
    letrehozva DATE DEFAULT SYSDATE,
    letrehozta VARCHAR2(50),
    modositva DATE,
    modositotta VARCHAR2(50)
);

CREATE TABLE terem_history (
    terem_id NUMBER,
    nev VARCHAR2(50),
    kapacitas NUMBER,
    muvelet VARCHAR2(10),
    modositas_ideje DATE,
    modosito_felhasznalo VARCHAR2(50)
);

-- 3. FILM
CREATE TABLE film (
    film_id NUMBER CONSTRAINT pk_film PRIMARY KEY,
    cim VARCHAR2(100) NOT NULL,
    hossz_perc NUMBER NOT NULL,
    kategoria_id NUMBER CONSTRAINT fk_film_kat REFERENCES kategoria(kategoria_id),
    letrehozva DATE DEFAULT SYSDATE,
    letrehozta VARCHAR2(50),
    modositva DATE,
    modositotta VARCHAR2(50)
);

CREATE TABLE film_history (
    film_id NUMBER,
    cim VARCHAR2(100),
    hossz_perc NUMBER,
    kategoria_id NUMBER,
    muvelet VARCHAR2(10),
    modositas_ideje DATE,
    modosito_felhasznalo VARCHAR2(50)
);

-- 4. VETITES
CREATE TABLE vetites (
    vetites_id NUMBER CONSTRAINT pk_vetites PRIMARY KEY,
    film_id NUMBER CONSTRAINT fk_vetites_film REFERENCES film(film_id),
    terem_id NUMBER CONSTRAINT fk_vetites_terem REFERENCES terem(terem_id),
    kezdes_ido DATE NOT NULL,
    letrehozva DATE DEFAULT SYSDATE,
    letrehozta VARCHAR2(50),
    modositva DATE,
    modositotta VARCHAR2(50)
);

CREATE TABLE vetites_history (
    vetites_id NUMBER,
    film_id NUMBER,
    terem_id NUMBER,
    kezdes_ido DATE,
    muvelet VARCHAR2(10),
    modositas_ideje DATE,
    modosito_felhasznalo VARCHAR2(50)
);

-- 5. UGYFEL
CREATE TABLE ugyfel (
    ugyfel_id NUMBER CONSTRAINT pk_ugyfel PRIMARY KEY,
    nev VARCHAR2(100) NOT NULL,
    email VARCHAR2(100) UNIQUE,
    torzsvasarloi_pontok NUMBER DEFAULT 0,
    letrehozva DATE DEFAULT SYSDATE,
    letrehozta VARCHAR2(50),
    modositva DATE,
    modositotta VARCHAR2(50)
);

CREATE TABLE ugyfel_history (
    ugyfel_id NUMBER,
    nev VARCHAR2(100),
    email VARCHAR2(100),
    torzsvasarloi_pontok NUMBER,
    muvelet VARCHAR2(10),
    modositas_ideje DATE,
    modosito_felhasznalo VARCHAR2(50)
);

-- 6. JEGY
CREATE TABLE jegy (
    jegy_id NUMBER CONSTRAINT pk_jegy PRIMARY KEY,
    vetites_id NUMBER CONSTRAINT fk_jegy_vetites REFERENCES vetites(vetites_id),
    ugyfel_id NUMBER CONSTRAINT fk_jegy_ugyfel REFERENCES ugyfel(ugyfel_id),
    szek_szam NUMBER NOT NULL,
    ar NUMBER NOT NULL,
    status VARCHAR2(20) CHECK (status IN ('FOGLALT', 'FIZETVE', 'TOROLT')),
    letrehozva DATE DEFAULT SYSDATE,
    letrehozta VARCHAR2(50),
    modositva DATE,
    modositotta VARCHAR2(50)
);

CREATE TABLE jegy_history (
    jegy_id NUMBER,
    vetites_id NUMBER,
    ugyfel_id NUMBER,
    szek_szam NUMBER,
    ar NUMBER,
    status VARCHAR2(20),
    muvelet VARCHAR2(10),
    modositas_ideje DATE,
    modosito_felhasznalo VARCHAR2(50)
);

-- 7. HIBA NAPLÓ (Exception Log)
CREATE TABLE hiba_naplo (
    hiba_id NUMBER PRIMARY KEY,
    hiba_kod NUMBER,
    hiba_uzenet VARCHAR2(4000),
    eljaras_neve VARCHAR2(100),
    idopont DATE DEFAULT SYSDATE,
    felhasznalo VARCHAR2(50)
);
