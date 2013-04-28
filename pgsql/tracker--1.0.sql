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

-- list of roles.
-- first version includes the following
-- player: has toons and their items
-- writer: associated with campaigns and adventures
CREATE TABLE role (
    role text PRIMARY KEY
);
GRANT SELECT ON role TO player;
GRANT SELECT ON role TO writer;

CREATE TABLE campaigns (
    id serial PRIMARY KEY,
    name text NOT NULL
);
GRANT SELECT ON campaigns TO player;
GRANT SELECT, UPDATE, INSERT, DELETE ON campaigns TO writer;

CREATE TABLE campaign_membership (
    player int NOT NULL REFERENCES players ON DELETE CASCADE,
    role text NOT NULL REFERENCES role ON UPDATE CASCADE,
    campaign int NOT NULL REFERENCES campaigns ON UPDATE CASCADE ON DELETE CASCADE
);
GRANT SELECT, INSERT, DELETE ON campaign_membership TO player;
GRANT SELECT, INSERT, UPDATE, DELETE ON campaign_membership to writer;

CREATE TABLE toons (
    id serial PRIMARY KEY,
    player int NOT NULL REFERENCES players ON DELETE CASCADE,
    name text NOT NULL
);
GRANT SELECT, UPDATE, DELETE ON toons TO player;

CREATE TABLE adventures (
    id serial PRIMARY KEY,
    campaign int REFERENCES campaigns ON UPDATE CASCADE ON DELETE CASCADE,
    author text
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
