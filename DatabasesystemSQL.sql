drop database GolfCupVG;
create database GolfCupVG;
use GolfCupVG;

-- Create tables:
create table player(
	socialSecurityNumber char(13),
    playerName varchar(20),
    age int,
    primary key(socialSecurityNumber)
)engine=innodb;

create table contest(
	contestName varchar(20),
    occurs date,
    primary key(contestName)
)engine=innodb;

create table rain(
	rainType varchar(20),
    windSpeed int,
    primary key(rainType)
)engine=innodb;

create table construction(
	serialNumber char(5),
    hardness int,
    primary key(serialNumber)
)engine=innodb;

create table jacket(
	brand varchar(20),
	size char(2),
    jacketMaterial varchar(20),
    socialSecurityNumber char(13),
    primary key(socialSecurityNumber, brand),
    foreign key(socialSecurityNumber) references player(socialSecurityNumber) on delete cascade
)engine=innodb;

create table club(
	clubNumber int,
	clubMaterial varchar(20),
    socialSecurityNumber char(13),
    serialNumber char(5),
    primary key(socialSecuritynumber, clubNumber),
    foreign key(socialSecurityNumber) references player(socialSecurityNumber) on delete cascade,
    foreign key(serialNumber) references construction(serialNumber) on delete cascade
)engine=innodb;

create table playerContestAssociation(
	pCAId int,
    socialSecurityNumber char(13),
    contestName varchar(20),
    primary key(pCAId),
    foreign key(socialSecurityNumber) references player(socialSecurityNumber) on delete cascade,
    foreign key(contestName) references contest(contestName) on delete cascade
)engine=innodb;

create table contestRainAssociation(
	cRId int,
	contestName varchar(20),
    rainType varchar(20),
    rainOccurs time,
    primary key(cRId),
    foreign key(contestName) references contest(contestName) on delete cascade,
    foreign key(rainType) references rain(rainType) on delete cascade
)engine=innodb;

-- Insert data:
insert into `player` values ('19800128-3757', 'Johan Andersson', 39);
insert into `player` values ('19931016-2856', 'Nicklas Jansson', 26);
insert into `player` values ('19850312-5776', 'Annika Persson', 34);

insert into `contest` values ('Big Golf Cup Skövde', '2021-06-10');

insert into `playerContestAssociation` values (1, '19800128-3757', 'Big Golf Cup Skövde');
insert into `playerContestAssociation` values (2, '19931016-2856', 'Big Golf Cup Skövde');
insert into `playerContestAssociation` values (3, '19850312-5776', 'Big Golf Cup Skövde');

insert into `rain` values ('hagel', '10');
insert into `contestRainAssociation` values (1, 'Big Golf Cup Skövde', 'hagel', '12:00:00');

insert into `jacket` values ('Adidas', 'L', 'fleece', '19800128-3757');
insert into `jacket` values ('Helly Hansen', 'XL', 'goretex', '19800128-3757');

insert into `construction` values ('00001', 10);
insert into `construction` values ('00002', 5);
insert into `club` values (10115, 'trä', '19931016-2856', '00001');
insert into `club` values (10267, 'trä', '19850312-5776', '00002');

-- Queries:
select age from player where playerName= 'Johan Andersson';
select occurs from contest where contestName= 'Big Golf Cup Skövde';
select clubMaterial from club where socialSecurityNumber= (select socialSecurityNumber from player where playerName= 'Johan Andersson');
select * from jacket where socialSecurityNumber= (select socialSecurityNumber from player where playerName= 'Johan Andersson');
select * from player where socialSecurityNumber= (select socialSecurityNumber from contest where contestName= 'Big Golf Cup Skövde');
select windSpeed from rain where rainType= (select rainType from contestRainAssociation where contestName= 'Big Golf Cup Skövde'); 
select * from player where age < 30;

delete from jacket where socialSecurityNumber= (select socialSecurityNumber from player where playerName= 'Johan Andersson');
delete from player where socialSecurityNumber= '19931016-2856';

select avg(age) from player;