-- Only allow use by create extension
\echo Use "CREATE EXTENSION tracker" to load this file. \quit

CREATE TABLE players (
    id serial PRIMARY KEY,
    name text NOT NULL,
    login text UNIQUE NOT NULL,
    grace int NOT NULL CHECK (grace < 10 ) default 6
);

CREATE TABLE passwords (
    id int PRIMARY KEY REFERENCES players,
    password text NOT NULL
);

CREATE TABLE role (
    role text PRIMARY KEY
);

CREATE TABLE roles (
    role text NOT NULL REFERENCES role ON UPDATE CASCADE ON DELETE CASCADE,
    player int NOT NULL REFERENCES players ON DELETE CASCADE
);

CREATE TABLE toons (
    id serial PRIMARY KEY,
    player int NOT NULL REFERENCES players ON DELETE CASCADE,
    name text NOT NULL
);
GRANT SELECT, UPDATE, DELETE ON toons TO player;

CREATE TABLE available_years (
    id text PRIMARY KEY
);
GRANT SELECT ON available_years to player;
GRANT SELECT, UPDATE, INSERT, DELETE ON available_years to writer;

CREATE TABLE adventures (
    id serial PRIMARY KEY,
    author text,
    year text REFERENCES available_years ON UPDATE CASCADE
);
GRANT SELECT ON adventures to player;
GRANT SELECT, UPDATE, INSERT, DELETE ON adventures to writer;

CREATE TABLE plot_items (
    id serial PRIMARY KEY,
    name text NOT NULL,
    description text NOT NULL
);
GRANT SELECT, INSERT ON plot_items to player;
GRANT SELECT, UPDATE, INSERT, DELETE ON plot_items to writer;

CREATE TABLE access_availability (
    plot_item int NOT NULL REFERENCES plot_items,
    adventure int REFERENCES adventures
);
GRANT SELECT ON access_availability TO player;
GRANT SELECT, UPDATE, INSERT, DELETE ON plot_items TO writer;

CREATE TABLE item_access (
    toon int NOT NULL REFERENCES toons,
    plot_item int NOT NULL REFERENCES plot_items,
    adventure int REFERENCES adventures,
    date_received timestamptz
);
GRANT SELECT, UPDATE, INSERT, DELETE ON item_access to player;
GRANT SELECT, UPDATE, INSERT, DELETE ON item_access to writer;
