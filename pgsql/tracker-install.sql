CREATE ROLE owner;
ALTER USER owner createdb;
CREATE ROLE writer;
CREATE ROLE player;
SET ROLE owner;
SET SEARCH_PATH TO tracker;
GRANT USAGE ON SCHEMA tracker TO writer;
GRANT USAGE ON SCHEMA tracker TO player;
CREATE OR REPLACE EXTENSION tracker;