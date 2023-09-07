-- Usuwanie istniejących tabel

DROP TABLE IF EXISTS klient;
DROP TABLE IF EXISTS klient_typ_konta;
DROP TABLE IF EXISTS adres_klienta;
DROP TABLE IF EXISTS zamowienie_produktu CASCADE;
DROP TABLE IF EXISTS zamowienie;
DROP TABLE IF EXISTS produkt;
DROP TABLE IF EXISTS producent;

-- Tworzenie tabeli klient

CREATE TABLE klient (
  klient_id              SERIAL PRIMARY KEY,
  imie                   VARCHAR(50),
  nazwisko               VARCHAR(50),
  data_urodzenia         DATE,
  numer_identyfikacyjny  INTEGER
);

-- Wstawianie danych do tabeli klient

INSERT INTO klient (imie, nazwisko, data_urodzenia, numer_identyfikacyjny) 
VALUES 
('Jan', 'Kowalski', '1990-01-15', 12345),
('Anna', 'Nowak', '1985-06-20', 67890),
('Marcin', 'Wiśniewski', '1995-03-10', 54321),
('Magda', 'Lewandowska', '1992-11-30', 98765),
('Piotr', 'Dąbrowski', '1988-09-25', 24680),
('Karolina', 'Zielińska', '1993-08-12', 13579),
('Michał', 'Król', '1987-04-05', 97531),
('Alicja', 'Jankowska', '1991-02-18', 86420),
('Krzysztof', 'Kaczmarek', '1998-07-22', 74185),
('Ewa', 'Wójcik', '1984-12-03', 36987);

-- Tworzenie tabeli klient_typ_konta

CREATE TABLE klient_typ_konta (
  klient_typ_konta_id   SERIAL PRIMARY KEY,
  klient_id             INTEGER,
  typ_konta             VARCHAR(50),
  profil_klienta        VARCHAR(50)
);

-- Wstawianie danych do tabeli klient_typ_konta

INSERT INTO klient_typ_konta (klient_id, typ_konta, profil_klienta)
VALUES
  (1, 'Premium', 'Indywidualny'),
  (2, 'Gold', 'Firmowy'),
  (3, 'Standard', 'Indywidualny'),
  (4, 'Standard', 'Firmowy'),
  (5, 'Standard', 'Indywidualny'),
  (6, 'Gold', 'Firmowy'),
  (7, 'Gold', 'Indywidualny'),
  (8, 'Premium', 'Indywidualny'),
  (9, 'Premium', 'Firmowy'),
  (10, 'Premium', 'Firmowy');

-- Tworzenie tabeli adres_klienta

CREATE TABLE adres_klienta (
  adres_id      SERIAL PRIMARY KEY,
  klient_id     INTEGER,
  miasto        VARCHAR(50),
  kraj          VARCHAR(50),
  ulica         VARCHAR(50)
);

-- Wstawianie danych do tabeli adres_klienta

INSERT INTO adres_klienta (klient_id, miasto, kraj, ulica)
VALUES
  (1, 'Warsaw', 'Poland', 'Śliczna 54/3'),
  (2, 'Krakow', 'Poland', 'Szeroka 134'),
  (3, 'Radom', 'Poland', 'Lipowa 78/4'),
  (4, 'Kielce', 'Poland', 'Wiosenna 83/3'),
  (5, 'Londyn', 'UK', 'Main Street 11'),
  (6, 'Glasgow', 'UK', 'Narrow Street 78'),
  (7, 'Leeds', 'UK', 'Pretty Street 467'),
  (8, 'Berlin', 'Germany', 'Wide Street 564/3'),
  (9, 'Monachium', 'Germany', 'Green Street 12'),
  (10, 'Oslo', 'Norwegia', 'Water Street 34');

-- Tworzenie tabeli zamowienie

CREATE TABLE zamowienie (
  zamowienie_id     SERIAL PRIMARY KEY,
  klient_id         INTEGER,
  data_zamowienia   DATE,
  status_zamowienia VARCHAR(50)
);

-- Wstawianie danych do tabeli zamowienie

INSERT INTO zamowienie (klient_id, data_zamowienia, status_zamowienia)
VALUES
  (1, '2023-08-01', 'Nowe'),
  (2, '2023-08-05', 'W trakcie'),
  (3, '2023-07-25', 'Wysłane'),
  (4, '2023-08-10', 'Nowe'),
  (5, '2023-08-02', 'Wysłane'),
  (6, '2023-07-28', 'Zakończone'),
  (7, '2023-08-04', 'W trakcie'),
  (8, '2023-08-08', 'Nowe'),
  (9, '2023-07-30', 'Zakończone'),
  (10, '2023-08-03', 'Wysłane');

-- Tworzenie tabeli producent

CREATE TABLE producent (
  producent_id      SERIAL PRIMARY KEY,
  nazwa             VARCHAR(50),
  umowa_wspolpraca  BOOLEAN
);

-- Wstawianie danych do tabeli producent

INSERT INTO producent (nazwa, umowa_wspolpraca)
VALUES
  ('Firma A', TRUE),
  ('Firma B', FALSE),
  ('Firma C', TRUE),
  ('Firma D', TRUE),
  ('Firma E', FALSE),
  ('Firma F', TRUE),
  ('Firma G', FALSE),
  ('Firma H', TRUE),
  ('Firma I', FALSE),
  ('Firma J', TRUE);

-- Tworzenie tabeli Produkt

CREATE TABLE produkt (
  produkt_id            SERIAL PRIMARY KEY,
  cena                  NUMERIC(10, 2),
  nazwa                 VARCHAR(50),
  dostepna_ilosc_magazyn INTEGER,
  kategoria             VARCHAR(50),
  producent_id          INTEGER,
  CONSTRAINT producent_id_fk FOREIGN KEY (producent_id) REFERENCES producent (producent_id)
);

-- Wstawianie danych do tabeli produkt

INSERT INTO produkt (cena, nazwa, dostepna_ilosc_magazyn, kategoria)
VALUES
  (25.99, 'Laptop', 10, 'Elektronika'),
  (9.99, 'Mysz komputerowa', 50, 'Akcesoria komputerowe'),
  (199.00, 'Smartfon', 20, 'Telefony'),
  (49.99, 'Słuchawki', 30, 'Akcesoria audio'),
  (399.00, 'Telewizor', 5, 'Elektronika'),
  (29.50, 'Klawiatura', 25, 'Akcesoria komputerowe'),
  (59.99, 'Aparat fotograficzny', 15, 'Fotografia'),
  (12.75, 'Powerbank', 40, 'Akcesoria mobilne'),
  (149.99, 'Konsola do gier', 8, 'Gry'),
  (7.25, 'Podkładka pod mysz', 100, 'Akcesoria komputerowe');

-- Tworzenie tabeli zamowienie_produktu

CREATE TABLE zamowienie_produktu (
  zamowienie_produktu_id   SERIAL PRIMARY KEY,
  produkt_id               INTEGER,
  zamowienie_id            INTEGER,
  ilosc_zamowiona          INTEGER,
  cena_za_sztuke           NUMERIC(10, 2),
  dokument_zakupu          VARCHAR(50),

  CONSTRAINT produkt_id_fk FOREIGN KEY (produkt_id) REFERENCES produkt (produkt_id),
  CONSTRAINT zamowienie_id_fk FOREIGN KEY (zamowienie_id) REFERENCES zamowienie (zamowienie_id)
);

-- Wstawianie danych do tabeli zamowienie_produktu

INSERT INTO zamowienie_produktu (produkt_id, zamowienie_id, ilosc_zamowiona, cena_za_sztuke, dokument_zakupu)
VALUES
  (1, 1, 5, 10.99, 'ZK123'),
  (2, 1, 2, 25.50, 'ZK124'),
  (3, 2, 10, 5.75, 'ZK125'),
  (4, 3, 3, 8.20, 'ZK126'),
  (5, 3, 7, 15.00, 'ZK127'),
  (6, 4, 1, 100.00, 'ZK128'),
  (7, 5, 4, 12.75, 'ZK129'),
  (8, 6, 6, 50.25, 'ZK130'),
  (9, 7, 8, 18.99, 'ZK131'),
  (10, 8, 2, 30.00, 'ZK132');

-- Operacje na tabelach

-- Aktualizacja danych

SELECT * FROM adres_klienta;

UPDATE adres_klienta
SET kraj = 'United Kingdom'
WHERE kraj = 'UK';

SELECT * FROM adres_klienta;
SELECT * FROM produkt;


-- Wybieranie i filtrowanie danych 
-- Pokaż wszystkie produkty (id, cena, nazwa, dostępność w magazynie i kategoria), które mają cenę powyżej 10.00 i dostepną ilość w magazynie powyżej 10

SELECT produkt_id, cena, nazwa, kategoria, dostepna_ilosc_magazyn
FROM produkt
WHERE cena > 10.00 
AND dostepna_ilosc_magazyn > 10;

-- produkt_id ASC -- order data from small to big
-- produkt_id DESC -- order data from big to small

-- Pokaż wszystkie produkty (id, cena, nazwa, dostępność w magazynie i kategoria), które mają cenę powyżej 10.00 i dostepną ilość w magazynie powyżej 10. Posegreguj wiersze od najmniejszej wartości do największej

SELECT produkt_id, cena, nazwa, kategoria, dostepna_ilosc_magazyn
FROM produkt
WHERE cena > 10.00 
AND dostepna_ilosc_magazyn > 10
ORDER BY cena ASC;

-- Kombinacja IN oraz BETWEEN
-- Pokaż wszystkie produkty (id, cena, nazwa, dostępność w magazynie i kategoria), które mają cenę od 10.00 do 200.00 i dostepną ilość w magazynie od 10 do 100.. Posegreguj wiersze od najmniejszej wartości do największej

SELECT produkt_id, cena, nazwa, kategoria, dostepna_ilosc_magazyn
FROM produkt
WHERE
  cena BETWEEN 30.00 AND 200.00
  AND
  dostepna_ilosc_magazyn BETWEEN 20 AND 100
ORDER BY
  cena ASC;

-- Wild card - symbole wieloznaczne
-- Pokaż wszystkich Klientów (id, imie i nazwisko), których imię zaczyna się od dużej litery A 'A%'
-- - single character, % cały string, A/a case sensitive

SELECT
imie, nazwisko, klient_id
FROM
klient
WHERE
imie LIKE 'A%'
;

-- Pokaż wszystkich Klientów (id, imie i nazwisko), których trzecia litera imienia to '__a'

SELECT
imie, nazwisko, klient_id
FROM
klient
WHERE
imie LIKE '__a'
;

-- Filtrowanie dat
-- Pokaż wszystkie zamowienia (id, data_zamowienia, klient_id), z datą dzisiejszą

SELECT zamowienie_id, data_zamowienia, klient_id
FROM zamowienie
WHERE data_zamowienia = CURRENT_DATE;

-- Pokaż wszystkie zamowienia (id, data_zamowienia, klient_id), z datą 2023-07-28

SELECT zamowienie_id, data_zamowienia, klient_id
FROM zamowienie
WHERE data_zamowienia = '2023-07-28';

-- Pokaż wszystkie zamowienia (id, data_zamowienia, klient_id), które zostały zamówione 15 dni temu
-- Do obliczania daty odejmowania/dodawania dni, minut, miesięcy etc. używamy INTERVAL

SELECT zamowienie_id, data_zamowienia, klient_id
FROM zamowienie
WHERE data_zamowienia = CURRENT_DATE - INTERVAL '15 days';

-- Pokaż wszystkie zamowienia (id, data_zamowienia, klient_id), które zostały zamówione w przeciągu ostatnich 15 dni

SELECT zamowienie_id, data_zamowienia, klient_id
FROM zamowienie
WHERE data_zamowienia 
BETWEEN CURRENT_DATE - INTERVAL '15 days' 
AND CURRENT_DATE;

-- Pokaż wszystkie zamowienia (id, data_zamowienia, klient_id), które zostały zamówione w przeciągu ostatnich 30 dni. A wyniki uszeruguj od najmniejszego do największego

SELECT zamowienie_id, data_zamowienia, klient_id
FROM zamowienie
WHERE data_zamowienia >= CURRENT_DATE - INTERVAL '30 days'
ORDER BY data_zamowienia;

-- Pokaż wszystkie zamowienia (id, data_zamowienia, klient_id), które zostały zamówione w przeciągu dat od 1 sierpnia do 30 sierpnia

SELECT zamowienie_id, data_zamowienia, klient_id
FROM zamowienie
WHERE data_zamowienia BETWEEN DATE '2023-08-01' AND DATE '2023-08-30';

-- Funkcja TO_CHAR
-- funkcja służąca do konwersji wartości na łańcuch znaków (string) w określonym formacie
-- TO_CHAR(transaction_time, 'MM') = TO_CHAR(CURRENT_DATE, 'MM'); Pokazuje transakcje z bieżącego miesiąca niezależnie od lat
-- TO_CHAR(transaction_time, 'MMYY') = TO_CHAR(CURRENT_DATE, 'MMYY'); Pokazuje transakcje uwzględniając bieżący miesiąc i bieżący rok

-- Pokaż wszystkie zamowienia (id, data_zamowienia, klient_id), które zostały zamówione w przeciągu ostatniego miesiąca (pokaże: dziś odjąć miesiąc)

SELECT zamowienie_id, data_zamowienia, klient_id
FROM zamowienie
WHERE data_zamowienia >= CURRENT_DATE - INTERVAL '1 month';

-- Pokaż wszystkie zamowienia (id, data_zamowienia, klient_id), które zostały zamówione w przeciągu ostatniego miesiąca za pomocą TO_CHAR (pokaże wszystkie z lipca, nie z sierpnia)

SELECT zamowienie_id, data_zamowienia, klient_id
FROM zamowienie
WHERE TO_CHAR(data_zamowienia, 'YYYY-MM') = TO_CHAR(CURRENT_DATE - INTERVAL '1 month', 'YYYY-MM');

-- Łączenie tabel
-- Pokaż Klientów (klient_id, imię, nazwisko i miasto), którzy mieszkaja w "United Kingdom" i mają profil klienta "indywidualny"

SELECT klient.klient_id, klient.imie, klient.nazwisko, adres_klienta.miasto
FROM klient
JOIN adres_klienta ON klient.klient_id = adres_klienta.klient_id
JOIN klient_typ_konta ON klient.klient_id = klient_typ_konta.klient_id
WHERE adres_klienta.kraj = 'United Kingdom' AND klient_typ_konta.profil_klienta = 'Indywidualny';

-- Pokaż listę Klientów firmowych (klient_id, imię, nazwisko i miasto), których imię rozpoczyna się na literę "M"

SELECT
klient_id, imie, nazwisko, data_urodzenia
FROM
klient
WHERE 
imie LIKE 'M%';

-- Pokaż listę wszystkich zamówień o statusie wysłane wraz z ilością zamówionych produktów, 
-- ilością zamówionych sztuk oraz wartością zamowienia

SELECT zamowienie.zamowienie_id, zamowienie.status_zamowienia,
       COUNT(zamowienie_produktu.produkt_id) AS ilosc_produktow,
       SUM(zamowienie_produktu.ilosc_zamowiona) AS ilosc_sztuk,
       SUM(zamowienie_produktu.ilosc_zamowiona * produkt.cena) AS wartosc_zamowienia
FROM zamowienie
JOIN zamowienie_produktu ON zamowienie.zamowienie_id = zamowienie_produktu.zamowienie_id
JOIN produkt ON zamowienie_produktu.produkt_id = produkt.produkt_id
WHERE zamowienie.status_zamowienia = 'Wysłane'
GROUP BY zamowienie.zamowienie_id, zamowienie.status_zamowienia;

-- Pokaż listę produktów, które nigdy nie byly zamowione

SELECT
produkt.produkt_id, produkt.nazwa, produkt.kategoria
FROM
produkt
LEFT JOIN
zamowienie_produktu ON produkt.produkt_id = zamowienie_produktu.produkt_id
WHERE
zamowienie_produktu.produkt_id IS NULL;

-- Pokaż listę 5 klientow o najwiekszej lacznej sumie wartosci zamowien

SELECT
klient.klient_id, klient.imie, klient.nazwisko,
SUM(zamowienie_produktu.ilosc_zamowiona * produkt.cena) AS suma_wartosci_zamowienia
FROM
klient
JOIN zamowienie ON klient.klient_id = zamowienie.klient_id
JOIN zamowienie_produktu ON zamowienie.zamowienie_id = zamowienie_produktu.zamowienie_id
JOIN produkt ON zamowienie_produktu.produkt_id = produkt.produkt_id
GROUP BY klient.klient_id, klient.imie, klient.nazwisko
ORDER BY suma_wartosci_zamowienia DESC
LIMIT 5;

-- Pokaż listę 


