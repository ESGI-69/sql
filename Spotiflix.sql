-- Adminer 4.8.1 PostgreSQL 14.5 dump

\connect "Spotiflix";

DROP TABLE IF EXISTS "album";
DROP SEQUENCE IF EXISTS album_id_seq;
CREATE SEQUENCE album_id_seq INCREMENT 1 MINVALUE 1 MAXVALUE 2147483647 START 3 CACHE 1;

CREATE TABLE "public"."album" (
    "id" integer DEFAULT nextval('album_id_seq') NOT NULL,
    "name" character varying(128) NOT NULL,
    CONSTRAINT "album_pkey" PRIMARY KEY ("id")
) WITH (oids = false);


DROP TABLE IF EXISTS "album_rent";
CREATE TABLE "public"."album_rent" (
    "album_id" integer NOT NULL,
    "customer_id" integer NOT NULL,
    "borrow_date" date NOT NULL,
    "return_date" date,
    CONSTRAINT "album_rent_album_id_customer_id" PRIMARY KEY ("album_id", "customer_id")
) WITH (oids = false);


DROP TABLE IF EXISTS "album_song";
CREATE TABLE "public"."album_song" (
    "album_id" integer NOT NULL,
    "song_id" integer NOT NULL,
    "track" integer NOT NULL,
    CONSTRAINT "album_song_album_id_song_id" PRIMARY KEY ("album_id", "song_id"),
    CONSTRAINT "album_song_album_id_track" UNIQUE ("album_id", "track")
) WITH (oids = false);


DROP TABLE IF EXISTS "album_stock";
DROP SEQUENCE IF EXISTS album_stock_id_seq;
CREATE SEQUENCE album_stock_id_seq INCREMENT 1 MINVALUE 1 MAXVALUE 2147483647 START 5 CACHE 1;

CREATE TABLE "public"."album_stock" (
    "id" integer DEFAULT nextval('album_stock_id_seq') NOT NULL,
    "album_id" integer NOT NULL,
    "stock" integer NOT NULL,
    CONSTRAINT "album_stock_pkey" PRIMARY KEY ("id")
) WITH (oids = false);


DROP TABLE IF EXISTS "artist";
DROP SEQUENCE IF EXISTS artist_id_seq;
CREATE SEQUENCE artist_id_seq INCREMENT 1 MINVALUE 1 MAXVALUE 2147483647 START 9 CACHE 1;

CREATE TABLE "public"."artist" (
    "id" integer DEFAULT nextval('artist_id_seq') NOT NULL,
    "name" character varying(128) NOT NULL,
    "birthdate" date NOT NULL,
    CONSTRAINT "artist_pkey" PRIMARY KEY ("id")
) WITH (oids = false);


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


DROP VIEW IF EXISTS "view_artists";
CREATE TABLE "view_artists" ("name" character varying(128), "birthdate" date, "songs" bigint);


ALTER TABLE ONLY "public"."album_rent" ADD CONSTRAINT "album_rent_album_id_fkey" FOREIGN KEY (album_id) REFERENCES album(id) ON DELETE CASCADE NOT DEFERRABLE;
ALTER TABLE ONLY "public"."album_rent" ADD CONSTRAINT "album_rent_customer_id_fkey" FOREIGN KEY (customer_id) REFERENCES customer(id) ON DELETE CASCADE NOT DEFERRABLE;

ALTER TABLE ONLY "public"."album_song" ADD CONSTRAINT "album_song_album_id_fkey" FOREIGN KEY (album_id) REFERENCES album(id) ON DELETE CASCADE NOT DEFERRABLE;
ALTER TABLE ONLY "public"."album_song" ADD CONSTRAINT "album_song_song_id_fkey" FOREIGN KEY (song_id) REFERENCES song(id) ON DELETE CASCADE NOT DEFERRABLE;

ALTER TABLE ONLY "public"."album_stock" ADD CONSTRAINT "album_stock_album_id_fkey" FOREIGN KEY (album_id) REFERENCES album(id) ON DELETE CASCADE NOT DEFERRABLE;

ALTER TABLE ONLY "public"."song" ADD CONSTRAINT "song_artist_id_fkey" FOREIGN KEY (artist_id) REFERENCES artist(id) ON DELETE CASCADE NOT DEFERRABLE;

ALTER TABLE ONLY "public"."track_deliveries" ADD CONSTRAINT "track_deliveries_album_stock_id_fkey" FOREIGN KEY (album_stock_id) REFERENCES album_stock(id) ON DELETE CASCADE NOT DEFERRABLE;

DROP TABLE IF EXISTS "view_artists";
CREATE VIEW "view_artists" AS SELECT artist.name,
    artist.birthdate,
    count(song.id) AS songs
   FROM (artist
     JOIN song ON ((song.artist_id = artist.id)))
  GROUP BY artist.name, artist.birthdate
  ORDER BY artist.name;

-- 2022-11-26 15:49:59.806247+00