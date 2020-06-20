# Gang War - MTA Game Mode - 1.0

This gamemode was made based on GTA gang systems.

## Getting Started

Make a repository clone in your MTA "resources/gamemodes" folder.

### Prerequisites

What things you need to install the software and how to install them:

```
	1 - Mysql or MariaDB.
	2 - MTA 1.5.3
	3 - GTA San Andreas
```

### Installing

First of all, configure the file "Class / database.lua" with correct configs and create the database.

Example: 

```
	static.dbName = "db_gangwar"
	static.host = "localhost"
	static.user = "dba_gangwar"
	static.password = "ianitolindo"
	static.port = "3306"
	static.typeConnection = "mysql"
```

Check if the database exists in your database.

After, in folder "[gameplay]" delete "deathpickups" and "realdriveby".

And now, start the resource.

## Authors

* **Iaan Mesquita (Ianito)** - Leader of project and owner.
* **ZoLo** - *For all help for us* 
* **Shinigami** - *Thanks for your help.* 
* **iNeewbie** - *Scriptings for gameplay.* 
* **Boypaki** - *Testing and feedback.* 

## Changelog

* **Base of gamemode added** 

## Bugs Founds
* **Database wont work with sqlite**
* **Login system not saved xml config file**


## Next Version
* **Special Vehicles **
* ** Car modification **
