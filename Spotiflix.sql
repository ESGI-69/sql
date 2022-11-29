DROP VIEW IF EXISTS "VIEW_ALBUMS";
CREATE TABLE "VIEW_ALBUMS" ("album" character varying(128), "songs" bigint, "duration" bigint);


DROP VIEW IF EXISTS "VIEW_ARTISTS";
CREATE TABLE "VIEW_ARTISTS" ("artist" character varying(128), "birthdate" date, "songs" bigint);


DROP TABLE IF EXISTS "album";
DROP SEQUENCE IF EXISTS album_id_seq;
CREATE SEQUENCE album_id_seq INCREMENT 1 MINVALUE 1 MAXVALUE 2147483647 START 3 CACHE 1;

CREATE TABLE "public"."album" (
    "id" integer DEFAULT nextval('album_id_seq') NOT NULL,
    "name" character varying(128) NOT NULL,
    CONSTRAINT "album_pkey" PRIMARY KEY ("id")
) WITH (oids = false);

INSERT INTO "album" ("id", "name") VALUES
(1,	'Meddle'),
(2,	'Modal Soul'),
(3,	'Mirage');

DROP TABLE IF EXISTS "album_rent";
CREATE TABLE "public"."album_rent" (
    "album_id" integer NOT NULL,
    "customer_id" integer NOT NULL,
    "borrow_date" date NOT NULL,
    "return_date" date,
    CONSTRAINT "album_rent_album_id_customer_id" PRIMARY KEY ("album_id", "customer_id")
) WITH (oids = false);

INSERT INTO "album_rent" ("album_id", "customer_id", "borrow_date", "return_date") VALUES
(1,	1,	'2022-11-23',	NULL),
(2,	1,	'2022-10-03',	'2022-10-22'),
(3,	2,	'2022-11-26',	NULL);

DROP TABLE IF EXISTS "album_song";
CREATE TABLE "public"."album_song" (
    "album_id" integer NOT NULL,
    "song_id" integer NOT NULL,
    "track" integer NOT NULL,
    CONSTRAINT "album_song_album_id_song_id" PRIMARY KEY ("album_id", "song_id"),
    CONSTRAINT "album_song_album_id_track" UNIQUE ("album_id", "track")
) WITH (oids = false);

INSERT INTO "album_song" ("album_id", "song_id", "track") VALUES
(1,	6,	1),
(1,	5,	2),
(1,	4,	3),
(1,	3,	4),
(1,	2,	5),
(1,	1,	6),
(2,	9,	1),
(2,	10,	2),
(2,	11,	3),
(2,	12,	4),
(2,	13,	5),
(2,	14,	6),
(2,	15,	7),
(2,	16,	8),
(2,	17,	9),
(2,	18,	10),
(2,	19,	11),
(2,	20,	12),
(2,	21,	13),
(2,	22,	14),
(3,	23,	1),
(3,	24,	2),
(3,	25,	3),
(3,	26,	4),
(3,	27,	5);

DROP TABLE IF EXISTS "album_stock";
DROP SEQUENCE IF EXISTS album_stock_id_seq;
CREATE SEQUENCE album_stock_id_seq INCREMENT 1 MINVALUE 1 MAXVALUE 2147483647 START 5 CACHE 1;

CREATE TABLE "public"."album_stock" (
    "id" integer DEFAULT nextval('album_stock_id_seq') NOT NULL,
    "album_id" integer NOT NULL,
    "stock" integer NOT NULL,
    CONSTRAINT "album_stock_pkey" PRIMARY KEY ("id")
) WITH (oids = false);

INSERT INTO "album_stock" ("id", "album_id", "stock") VALUES
(1,	1,	10),
(2,	2,	4),
(3,	3,	16);

DROP TABLE IF EXISTS "artist";
DROP SEQUENCE IF EXISTS artist_id_seq;
CREATE SEQUENCE artist_id_seq INCREMENT 1 MINVALUE 1 MAXVALUE 2147483647 START 11 CACHE 1;

CREATE TABLE "public"."artist" (
    "id" integer DEFAULT nextval('artist_id_seq') NOT NULL,
    "name" character varying(128) NOT NULL,
    "birthdate" date NOT NULL,
    CONSTRAINT "artist_pkey" PRIMARY KEY ("id")
) WITH (oids = false);

INSERT INTO "artist" ("id", "name", "birthdate") VALUES
(1,	'Pink Floyd',	'1966-01-01'),
(2,	'Nujabes',	'1974-02-26'),
(3,	'Camel',	'1970-01-01'),
(4,	'Daft Punk',	'1993-01-01'),
(5,	'Mézigue',	'2016-01-01'),
(6,	'DJ Premier',	'1966-03-21'),
(7,	'Tangerine Dream',	'1967-01-01'),
(8,	'Chromatics',	'2001-01-01'),
(9,	'Magic Sword',	'2013-01-01');

DROP TABLE IF EXISTS "customer";
DROP SEQUENCE IF EXISTS customer_id_seq;
CREATE SEQUENCE customer_id_seq INCREMENT 1 MINVALUE 1 MAXVALUE 2147483647 START 4 CACHE 1;

CREATE TABLE "public"."customer" (
    "id" integer DEFAULT nextval('customer_id_seq') NOT NULL,
    "email" character varying(128) NOT NULL,
    "firstname" character varying(64) NOT NULL,
    "lastname" character varying(64) NOT NULL,
    CONSTRAINT "customer_pkey" PRIMARY KEY ("id")
) WITH (oids = false);

INSERT INTO "customer" ("id", "email", "firstname", "lastname") VALUES
(1,	'quentin.peltier.pro@gmail.com',	'Quentin',	'PELTIER'),
(2,	'gatien.anizan@gmail.com',	'Gatien',	'ANIZAN');

DROP TABLE IF EXISTS "song";
DROP SEQUENCE IF EXISTS song_id_seq;
CREATE SEQUENCE song_id_seq INCREMENT 1 MINVALUE 1 MAXVALUE 2147483647 START 27 CACHE 1;

CREATE TABLE "public"."song" (
    "id" integer DEFAULT nextval('song_id_seq') NOT NULL,
    "name" character varying(128) NOT NULL,
    "duration" integer NOT NULL,
    "artist_id" integer NOT NULL,
    CONSTRAINT "song_pkey" PRIMARY KEY ("id")
) WITH (oids = false);

COMMENT ON COLUMN "public"."song"."duration" IS 'secondes';

INSERT INTO "song" ("id", "name", "duration", "artist_id") VALUES
(1,	'Echoes',	1413,	1),
(2,	'Seamus',	134,	1),
(3,	'San Tropez',	222,	1),
(4,	'Fearless',	367,	1),
(5,	'A Pillow Of Winds',	313,	1),
(6,	'On Of These Days',	355,	1),
(9,	'Feather (feat. Cise Starr & Akin from CYNE)',	175,	2),
(10,	'ordinary joe (feat. Terry Callier)',	308,	2),
(11,	'reflection eternal',	257,	2),
(12,	'Luv(sic.) pt3 (feat. Shing02)',	336,	2),
(13,	'Music is mine',	260,	2),
(14,	'Eclipse (feat. Substantial)',	394,	2),
(15,	'The Sign (feat. Pase Rock)',	289,	2),
(16,	'Thank you (feat. Apani B)',	249,	2),
(17,	'World''s end Rhapsody',	341,	2),
(18,	'Modal Soul (feat. Uyama Hiroto)',	281,	2),
(19,	'flowers',	239,	2),
(20,	'sea of cloud',	181,	2),
(21,	'Light on the land',	235,	2),
(22,	'Horizon',	440,	2),
(23,	'Freefall',	354,	3),
(24,	'Supertwister',	203,	3),
(25,	'Nimrodel / The Procession / The White Rider',	558,	3),
(26,	'Earthrise',	401,	3),
(27,	'Lady Fantasy: Encounter / Smiles for You / Lady Fantasy',	765,	3);

DROP TABLE IF EXISTS "track_deliveries";
DROP SEQUENCE IF EXISTS track_deliveries_id_seq;
CREATE SEQUENCE track_deliveries_id_seq INCREMENT 1 MINVALUE 1 MAXVALUE 2147483647 START 4 CACHE 1;

CREATE TABLE "public"."track_deliveries" (
    "id" integer DEFAULT nextval('track_deliveries_id_seq') NOT NULL,
    "album_stock_id" integer NOT NULL,
    "amount" integer NOT NULL,
    "delivery_date" date NOT NULL,
    CONSTRAINT "track_deliveries_pkey" PRIMARY KEY ("id")
) WITH (oids = false);

INSERT INTO "track_deliveries" ("id", "album_stock_id", "amount", "delivery_date") VALUES
(1,	1,	1,	'2022-11-24'),
(2,	2,	2,	'2022-10-04'),
(3,	3,	4,	'2022-11-27');

ALTER TABLE ONLY "public"."album_rent" ADD CONSTRAINT "album_rent_album_id_fkey" FOREIGN KEY (album_id) REFERENCES album(id) ON DELETE CASCADE NOT DEFERRABLE;
ALTER TABLE ONLY "public"."album_rent" ADD CONSTRAINT "album_rent_customer_id_fkey" FOREIGN KEY (customer_id) REFERENCES customer(id) ON DELETE CASCADE NOT DEFERRABLE;

ALTER TABLE ONLY "public"."album_song" ADD CONSTRAINT "album_song_album_id_fkey" FOREIGN KEY (album_id) REFERENCES album(id) ON DELETE CASCADE NOT DEFERRABLE;
ALTER TABLE ONLY "public"."album_song" ADD CONSTRAINT "album_song_song_id_fkey" FOREIGN KEY (song_id) REFERENCES song(id) ON DELETE CASCADE NOT DEFERRABLE;

ALTER TABLE ONLY "public"."album_stock" ADD CONSTRAINT "album_stock_album_id_fkey" FOREIGN KEY (album_id) REFERENCES album(id) ON DELETE CASCADE NOT DEFERRABLE;

ALTER TABLE ONLY "public"."song" ADD CONSTRAINT "song_artist_id_fkey" FOREIGN KEY (artist_id) REFERENCES artist(id) ON DELETE CASCADE NOT DEFERRABLE;

ALTER TABLE ONLY "public"."track_deliveries" ADD CONSTRAINT "track_deliveries_album_stock_id_fkey" FOREIGN KEY (album_stock_id) REFERENCES album_stock(id) ON DELETE CASCADE NOT DEFERRABLE;

DROP TABLE IF EXISTS "VIEW_ALBUMS";
CREATE VIEW "VIEW_ALBUMS" AS SELECT album.name AS album,
    count(album_song.song_id) AS songs,
    sum(song.duration) AS duration
   FROM ((album
     JOIN album_song ON ((album_song.album_id = album.id)))
     JOIN song ON ((song.id = album_song.song_id)))
  GROUP BY album.name
  ORDER BY album.name;

DROP TABLE IF EXISTS "VIEW_ARTISTS";
CREATE VIEW "VIEW_ARTISTS" AS SELECT artist.name AS artist,
    artist.birthdate,
    count(song.id) AS songs
   FROM (artist
     JOIN song ON ((song.artist_id = artist.id)))
  GROUP BY artist.name, artist.birthdate
  ORDER BY artist.name;

CREATE OR REPLACE FUNCTION ADD_ARTIST(a_name VARCHAR(128), a_birthdate DATE)
  RETURNS boolean
  AS $$
DECLARE
    artist_id integer;
BEGIN
    SELECT id INTO artist_id FROM artist WHERE artist.name = a_name;
    IF artist_id IS NULL THEN
        INSERT INTO artist (name, birthdate) VALUES (a_name, a_birthdate);
        RETURN TRUE;
    ELSE
        RETURN FALSE;
    END IF;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION ADD_ALBUM(a_name VARCHAR(128))
  RETURNS boolean
  AS $$
DECLARE
    album_id integer;
BEGIN
    SELECT id INTO album_id FROM album WHERE album.name = a_name;
    IF album_id IS NULL THEN
        INSERT INTO album (name) VALUES (a_name);
        RETURN TRUE;
    ELSE
        RETURN FALSE;
    END IF;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION ADD_STOCK(a_name VARCHAR(128), a_amount integer)
  RETURNS boolean
  AS $$
DECLARE
    a_id integer;
BEGIN
  IF a_amount < 0 THEN
    RETURN FALSE;
  ELSE
    SELECT id INTO a_id FROM album WHERE album.name = a_name;
    IF a_id IS NULL THEN
      RETURN FALSE;
    ELSE
      UPDATE album_stock SET stock = stock + a_amount WHERE album_id = a_id;
      RETURN TRUE;
    END IF;
  END IF;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION RENT_ALBUM(c_email VARCHAR(128), a_name VARCHAR(128), b_date DATE)
  RETURNS TABLE (result boolean, message text)
  AS $$
DECLARE
    c_id integer;
    a_id integer;
    a_stock integer;
    isBorrow integer;
BEGIN
    SELECT id INTO c_id FROM customer WHERE customer.email = c_email;
    SELECT id INTO a_id FROM album WHERE album.name = a_name;
    SELECT stock INTO a_stock FROM album_stock WHERE album_id = a_id;
    IF c_id IS NULL OR a_id IS NULL OR a_stock = 0 THEN
      RETURN QUERY SELECT FALSE, 'Customer or album doesnt exist or album stock is 0';
    ELSE
        SELECT album_id INTO isBorrow FROM album_rent 
        WHERE album_rent.customer_id = c_id
        AND album_rent.album_id = a_id;
        IF isBorrow IS NULL THEN
          INSERT INTO album_rent (customer_id, album_id, borrow_date) VALUES (c_id, a_id, b_date);
          RETURN QUERY SELECT TRUE, 'Album borrowed';
        ELSE
          RETURN QUERY SELECT FALSE, 'Customer already borrowed this album';
        END IF;
    END IF;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION DURATION_TO_STRING(duration integer)
  RETURNS varchar(16)
  AS $$
DECLARE
    minutes integer;
    secondes integer;
BEGIN
    minutes = duration / 60;
    secondes = duration % 60;
    IF secondes < 10 THEN
        RETURN minutes || ':0' || secondes;
    ELSE
        RETURN minutes || ':' || secondes;
    END IF;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION track_deliveries_update()
  RETURNS trigger
  AS $$
BEGIN
    INSERT INTO track_deliveries (album_stock_id, amount, delivery_date) VALUES (NEW.id, NEW.stock - OLD.stock, now());
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER track_deliveries_update
  AFTER UPDATE ON album_stock
  FOR EACH ROW
  EXECUTE PROCEDURE track_deliveries_update();
