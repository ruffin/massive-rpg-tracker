massive-rpg-tracker
===================

Tracks item access and storyline progression for large shared RPG campaigns like Living Greyhawk.

Obviously a work in progress. Requires PostgreSQL. For initial setup, log in using psql as user postgres and type the following commands.

CREATE ROLE owner;
ALTER USER owner createdb;
CREATE ROLE writer;
CREATE ROLE player;

Copy the files in /pgsql into your postgres extensions folder. From your extensions folder, type 

psql -u owner -f tracker-install.sql

This should create the proper table layout.

When I finish the application code I'll clean up this process a bit.
