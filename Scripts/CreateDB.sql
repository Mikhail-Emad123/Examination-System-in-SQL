-- drop  database [ExaminationSystem]

create database [ExaminationSystem]
ON 
(
	NAME=projects_dat, --logical name
	FILENAME = 'F:\ITI\study\projects\SQL Project\DataFiles\projects_dat.mdf',
	SIZE = 50,
	FILEGROWTH = 100
)
LOG ON
(
	NAME=projects_log,
	FILENAME = 'F:\ITI\study\projects\SQL Project\DataFiles\projects_log.ldf',
	SIZE = 10,
	FILEGROWTH = 100
);

