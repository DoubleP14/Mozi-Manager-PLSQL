# Mozi Manager - Adatbázis Dokumentáció

Ez a repository a **Mozi Manager** projekt adatbázis rétegét tartalmazza. A rendszer Oracle adatbázisra épül, és PL/SQL nyelven íródott. A projekt célja egy mozi jegyértékesítési, teremkezelési és statisztikai rendszerének backend megvalósítása.

## Telepítési útmutató

A szkriptek lefuttatásakor **kiemelten fontos a sorrend betartása** a függőségek miatt.

### Futtatási sorrend

Az adatbázis felépítéséhez az alábbi sorrendben szükséges lefuttatni a fájlokat SQL Developer-ben:

#### 0. Környezet előkészítése (Adminisztrátorként)
* `create_user.sql` (A `MOZI_GAZDA` felhasználó létrehozása és jogosultságok megadása. Ezt `SYSTEM` vagy `SYS` felhasználóként futtasd!)

#### 1. Szekvenciák
* `Scripts/sequence.sql` (Ez hozza létre az automatikus ID generáláshoz szükséges szekvenciákat.)

#### 2. Adattáblák létrehozása
* `Tables/tables.sql` (Ez a fájl tartalmazza a CREATE TABLE utasításokat és a megszorításokat.)

#### 3. Objektum típusok (Types)
* `Types/ty_film_adat.sql` (Egyedi objektum típus a filmek adatainak memóriában történő kezeléséhez.)

#### 4. Adatok feltöltése
* `Scripts/insert_data.sql` (Kezdeti dummy adatok betöltése: kategóriák, termek, filmek, vetítések, ügyfelek.)

#### 5. Nézetek (Views)
* `Views/create_views.sql` (Lekérdezéseket segítő nézetek: Műsorújság és Bevételek filmenként.)

#### 6. Csomagok (Packages)
* `Packages/pkg_mozi_manager.sql` (A csomag specifikációja/fejléce.)
* `Packages/pkg_mozi_manager_body.sql` (A csomag törzse: Jegyvásárlás tranzakciókezeléssel, Statisztikák kurzorokkal, Dinamikus SQL.)

#### 7. Triggerek
* `Triggers/trg_pontgyujtes.sql` (Automatikus törzsvásárlói pontjóváírás fizetett jegyek után.)
* `Triggers/trg_jegy_naplozas.sql` (Részletes auditálás/naplózás a `JEGY_HISTORY` táblába minden művelet után.)

---

## Tesztek futtatása

A rendszer működésének ellenőrzéséhez az alábbi tesztszkriptek állnak rendelkezésre:

* `Tests/test_jegyvasarlas.sql` (Teljes jegyvásárlási folyamat tesztelése: szabad helyek ellenőrzése, foglalás, tranzakció.)
* `Tests/test_pontgyujtes.sql` (Annak ellenőrzése, hogy a vásárlás után a pontok jóváírásra kerültek-e az ügyfélnél.)
* `Tests/test_pkg_mozi_manager.sql` (A statisztikai kurzorok és a dinamikus SQL sor-számláló függvény tesztelése.)
* `Tests/test_objects_and_arrays.sql` (Az objektum típusok és asszociatív tömbök működésének demonstrálása.)

---

## 🛠️ Használt technológiák

* **Adatbázis:** Oracle Database
* **Nyelv:** PL/SQL
* **Eszközök:** SQL Developer / Datagrip
* **Project Status:** Finalized (2025-01-15)

---

## 👤 Szerző

**Név:** [Pintér Patrik]  
**Neptun kód:** [IEKOO6]
