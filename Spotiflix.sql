-- -------------------------------------------------------------
-- TablePlus 5.1.0(468)
--
-- https://tableplus.com/
--
-- Database: Spotiflix
-- Generation Time: 2022-11-24 16:05:34.7250
-- -------------------------------------------------------------


DROP TABLE IF EXISTS "public"."album";
-- This script only contains the table creation statements and does not fully represent the table in the database. It's still missing: indices, triggers. Do not use it as a backup.

-- Sequence and defined type
CREATE SEQUENCE IF NOT EXISTS album_id_seq;

-- Table Definition
CREATE TABLE "public"."album" (
    "id" int4 NOT NULL DEFAULT nextval('album_id_seq'::regclass),
    "name" varchar(128) NOT NULL,
    PRIMARY KEY ("id")
);

DROP TABLE IF EXISTS "public"."album_rent";
-- This script only contains the table creation statements and does not fully represent the table in the database. It's still missing: indices, triggers. Do not use it as a backup.

-- Table Definition
CREATE TABLE "public"."album_rent" (
    "album_id" int4 NOT NULL,
    "customer_id" int4 NOT NULL,
    "borrow_date" date NOT NULL,
    "return_date" date,
    PRIMARY KEY ("album_id","customer_id")
);

DROP TABLE IF EXISTS "public"."album_song";
-- This script only contains the table creation statements and does not fully represent the table in the database. It's still missing: indices, triggers. Do not use it as a backup.

-- Table Definition
CREATE TABLE "public"."album_song" (
    "album_id" int4 NOT NULL,
    "song_id" int4 NOT NULL,
    "track" int4 NOT NULL CHECK (track > 0),
    PRIMARY KEY ("album_id","song_id")
);

DROP TABLE IF EXISTS "public"."album_stock";
-- This script only contains the table creation statements and does not fully represent the table in the database. It's still missing: indices, triggers. Do not use it as a backup.

-- Sequence and defined type
CREATE SEQUENCE IF NOT EXISTS album_stock_id_seq;

-- Table Definition
CREATE TABLE "public"."album_stock" (
    "id" int4 NOT NULL DEFAULT nextval('album_stock_id_seq'::regclass),
    "album_id" int4 NOT NULL,
    "stock" int4 NOT NULL CHECK (stock >= 0),
    PRIMARY KEY ("id")
);

DROP TABLE IF EXISTS "public"."artist";
-- This script only contains the table creation statements and does not fully represent the table in the database. It's still missing: indices, triggers. Do not use it as a backup.

-- Sequence and defined type
CREATE SEQUENCE IF NOT EXISTS artist_id_seq;

-- Table Definition
CREATE TABLE "public"."artist" (
    "id" int4 NOT NULL DEFAULT nextval('artist_id_seq'::regclass),
    "name" varchar(128) NOT NULL,
    "birthdate" date NOT NULL,
    PRIMARY KEY ("id")
);

DROP TABLE IF EXISTS "public"."customer";
-- This script only contains the table creation statements and does not fully represent the table in the database. It's still missing: indices, triggers. Do not use it as a backup.

-- Sequence and defined type
CREATE SEQUENCE IF NOT EXISTS customer_id_seq;

-- Table Definition
CREATE TABLE "public"."customer" (
    "id" int4 NOT NULL DEFAULT nextval('customer_id_seq'::regclass),
    "email" varchar(128) NOT NULL,
    "firstname" varchar(64) NOT NULL CHECK (initcap((firstname)::text) = (firstname)::text),
    "lastname" varchar(64) NOT NULL CHECK (upper((lastname)::text) = (lastname)::text),
    PRIMARY KEY ("id")
);

DROP TABLE IF EXISTS "public"."song";
-- This script only contains the table creation statements and does not fully represent the table in the database. It's still missing: indices, triggers. Do not use it as a backup.

-- Sequence and defined type
CREATE SEQUENCE IF NOT EXISTS song_id_seq;

-- Table Definition
CREATE TABLE "public"."song" (
    "id" int4 NOT NULL DEFAULT nextval('song_id_seq'::regclass),
    "name" varchar(128) NOT NULL,
    "duration" int4 NOT NULL CHECK (duration > 0),
    "artist_id" int4 NOT NULL,
    PRIMARY KEY ("id")
);

-- Column Comment
COMMENT ON COLUMN "public"."song"."duration" IS 'secondes';

DROP TABLE IF EXISTS "public"."track_deliveries";
-- This script only contains the table creation statements and does not fully represent the table in the database. It's still missing: indices, triggers. Do not use it as a backup.

-- Sequence and defined type
CREATE SEQUENCE IF NOT EXISTS track_deliveries_id_seq;

-- Table Definition
CREATE TABLE "public"."track_deliveries" (
    "id" int4 NOT NULL DEFAULT nextval('track_deliveries_id_seq'::regclass),
    "album_stock_id" int4 NOT NULL,
    "amount" int4 NOT NULL,
    "delivery_date" date NOT NULL,
    PRIMARY KEY ("id")
);

INSERT INTO "public"."album" ("id", "name") VALUES
(1, 'Meddle');

INSERT INTO "public"."album_rent" ("album_id", "customer_id", "borrow_date", "return_date") VALUES
(1, 1, '2022-11-23', NULL);

INSERT INTO "public"."album_song" ("album_id", "song_id", "track") VALUES
(1, 1, 6),
(1, 2, 5),
(1, 3, 4),
(1, 4, 3),
(1, 5, 2),
(1, 6, 1);

INSERT INTO "public"."album_stock" ("id", "album_id", "stock") VALUES
(1, 1, 10);

INSERT INTO "public"."artist" ("id", "name", "birthdate") VALUES
(1, 'Pink Floyd', '1966-01-01');

INSERT INTO "public"."customer" ("id", "email", "firstname", "lastname") VALUES
(1, 'quentin.peltier.pro@gmail.com', 'Quentin', 'PELTIER'),
(4, 'gatien.anizan@gmail.com', 'Gatien', 'ANIZAN');

INSERT INTO "public"."song" ("id", "name", "duration", "artist_id") VALUES
(1, 'Echoes', 1413, 1),
(2, 'Seamus', 134, 1),
(3, 'San Tropez', 222, 1),
(4, 'Fearless', 367, 1),
(5, 'A Pillow Of Winds', 313, 1),
(6, 'On Of These Days', 355, 1);

INSERT INTO "public"."track_deliveries" ("id", "album_stock_id", "amount", "delivery_date") VALUES
(1, 1, 1, '2022-11-24');

ALTER TABLE "public"."album_rent" ADD FOREIGN KEY ("customer_id") REFERENCES "public"."customer"("id") ON DELETE CASCADE;
ALTER TABLE "public"."album_rent" ADD FOREIGN KEY ("album_id") REFERENCES "public"."album"("id") ON DELETE CASCADE;
ALTER TABLE "public"."album_song" ADD FOREIGN KEY ("album_id") REFERENCES "public"."album"("id") ON DELETE CASCADE;
ALTER TABLE "public"."album_song" ADD FOREIGN KEY ("song_id") REFERENCES "public"."song"("id") ON DELETE CASCADE;
ALTER TABLE "public"."album_stock" ADD FOREIGN KEY ("album_id") REFERENCES "public"."album"("id") ON DELETE CASCADE;
ALTER TABLE "public"."song" ADD FOREIGN KEY ("artist_id") REFERENCES "public"."artist"("id") ON DELETE CASCADE;
ALTER TABLE "public"."track_deliveries" ADD FOREIGN KEY ("album_stock_id") REFERENCES "public"."album_stock"("id") ON DELETE CASCADE;
