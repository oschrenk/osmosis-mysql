# README #

This project enables the use of [Osmosis](http://wiki.openstreetmap.org/wiki/Osmosis) ([Github](https://github.com/openstreetmap/osmosis)) to import (an extract of) the [planet.osm](http://wiki.openstreetmap.org/wiki/Planet.osm) using OSM 0.6 API into a MySQL database.

The support officially has been dropped, but I needed a MySQL compatible representation of the data.

I found an (the?) old mysql schema on [Brett Henderson](https://github.com/brettch)'s Homepage and started from there. If you are interested in the changes I made, take a look into the [problems](PROBLEMS.md) and the history of git repository.

## Import planet.osm.bz2 into a MySQL Database ##

Install Omosis

	$ brew install osmosis

Install MySQL

	$ brew install mysql
	$ unset TMPDIR
    $ mysql_install_db --verbose --user=`whoami` --basedir="$(brew --prefix mysql)" --datadir=/usr/local/var/mysql --tmpdir=/tmp
	$ mysql.server start
    $ /usr/local/opt/mysql/bin/mysql_secure_installation

We follow the naming scheme in the script and create database and user accordingly

	$ mysql -u root -p
	mysql> CREATE DATABASE api06_test;
	mysql> GRANT ALL PRIVILEGES ON api06_test.* TO osm@localhost IDENTIFIED BY 'osm';
	mysql > exit;

Get the latest version of my mysql schema script based on Brett Henderson's work

	$ wget https://raw.github.com/oschrenk/osmosis-mysql/master/mysql-apidb06.sql

Create the schema using the sql script

	mysql -u osm -p -h localhost api06_test < mysql-apidb06.sql

Read data and populate database

	osmosis --read-xml file="bremen.osm.bz2" --write-apidb-0.6 host="127.0.0.1" dbType="mysql" database="api06_test" user="osm" password="osm" validateSchemaVersion=no

## Usage ##

Return all main streets in a bounding box

	select w.`id`, w.sequence_id, latitude, longitude, t1.v as name, t2.v as type
	from current_way_nodes w, current_nodes n, current_way_tags t1, current_way_tags t2
	where w.`node_id` = n.`id`
	and w.`id` = t1.`way_id`
	and w.`id` = t2.`way_id`
	and t1.k = 'name'
	and t1.v <>  ''
	and t2.k = 'highway'
	and t2.v in ('primary', 'secondary', 'tertiary', 'motorway', 'residential', 'road', 'track', 'trunk')
	and n.latitude > 53 * 10000000
	and n.latitude < 54 * 10000000
	and n.longitude > 8 * 10000000
	and n.longitude < 9 * 10000000
	order by w.`id` asc, w.sequence_id asc;

OSM uses Fixed Precision Integer for the geographical location. Instead of persisting `53,0749415` as a floating point number in the database, it will be persisted as `530749415`. The precision of the floating point number is [defined](http://wiki.openstreetmap.org/wiki/Node#Structure) as `7` decimal places, so you have to multiply or divide with `10^7`.