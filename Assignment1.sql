IF EXISTS (SELECT * 
			FROM INFORMATION_SCHEMA.TABLES
			WHERE TABLE_NAME = 'a1_pets')
			DROP TABLE a1_pets

IF EXISTS (SELECT * 
			FROM INFORMATION_SCHEMA.TABLES
			WHERE TABLE_NAME = 'a1_adopters')
			DROP TABLE a1_adopters

IF EXISTS (SELECT * 
			FROM INFORMATION_SCHEMA.TABLES
			WHERE TABLE_NAME = 'a1_images')
			DROP TABLE a1_images

IF EXISTS (SELECT * 
			FROM INFORMATION_SCHEMA.TABLES
			WHERE TABLE_NAME = 'a1_types_lookup')
			DROP TABLE a1_types_lookup


CREATE TABLE a1_pets (
	pets_id				int identity(1,1)	not null,
	pets_name			varchar(50)			not null,
	pets_breed			varchar(50)			null,
	pets_adoption_fee	money 				not null DEFAULT 200.00 ,
	pets_notes			text				null,
	pets_dob			DATE				null,
	pets_arrival_date	DATE 				not null DEFAULT GETDATE(),
	pets_adopted_date	DATE				null,
	fk_types			varchar(50)			not null,
	fk_adopter			int					null
)




CREATE TABLE a1_adopters (
	adopters_id			int identity(1,1)	not null,
	adopters_fname		varchar(20)			not null,
	adopters_lname		varchar(20)			not null,
	adopters_email		varchar(254) 		not null,
	adopters_approved	bit					not null DEFAULT 0,
)

CREATE TABLE a1_types_lookup (
	types_name	varchar(50)	not null
)

CREATE TABLE a1_images (
	images_id		int identity(1,1)	not null,
	images_name		varchar(50)			not null,
	images_caption	text				null,
	fk_pet			int					null
)


ALTER TABLE a1_pets
ADD
constraint pk_a1_pets_id			PRIMARY KEY (pets_id),
constraint ck_a1_pets_adoption_fee	check (pets_adoption_fee >= 0),
constraint ch_a1_pets_adopted_date	check (pets_adopted_date <= GETDATE() )


ALTER TABLE a1_adopters
ADD
constraint pk_a1_adopters_id	PRIMARY KEY	(adopters_id),
constraint u_a1_adopters_email	unique	(adopters_email)


ALTER TABLE a1_types_lookup
ADD
constraint pk_a1_types_name	PRIMARY KEY (types_name)


ALTER TABLE a1_images
ADD
constraint pk_a1_images_id	PRIMARY KEY (images_id)


ALTER TABLE a1_pets
ADD
constraint fk_a1_types_name		FOREIGN KEY (fk_types)		REFERENCES a1_types_lookup(types_name),
constraint fk_a2_adopters_id	FOREIGN KEY (fk_adopter)	REFERENCES a1_adopters(adopters_id)

ALTER TABLE a1_images
ADD
constraint fk_a1_images_id FOREIGN KEY (fk_pet)	REFERENCES a1_pets(pets_id)


INSERT INTO a1_adopters (adopters_fname, adopters_lname, adopters_email, adopters_approved)
VALUES	('Margaret', 'Harmon', 'mharmon@turpis.com', 1),
		('Emma', 'Martinez', 'emartinez@Sed.net', 1),
		('Laura', 'Hart', 'ljart@Pellent.edu', 0),
		('Seth', 'King', 'sking@port.net', 0),
		('Jenna', 'Roberts', 'jroberts@sorci.edu', 1)

INSERT INTO a1_adopters (adopters_fname, adopters_lname, adopters_email, adopters_approved)
VALUES	('Margaret', 'Harmon', 'mharmon@turpis.com', 1),

select * from a1_adopters
--IS IT OK FOR YES/NO (BIT) TO BE 0 AND 1???

select * from a1_pets

INSERT INTO a1_types_lookup (types_name)
VALUES	('dog'),
		('cat')

select * from a1_types_lookup





INSERT INTO a1_pets
VALUES ('Abby', 'Great Dane/Lab', 200, 'Came from Biloxi shelter.', '1/12/14', '1/21/16', '7/27/16', 'dog' , 1)

INSERT INTO a1_pets
VALUES ('Bear', null , 200, 'A great loving spirit.', '5/8/12', '10/25/12', null , 'dog' , null )

INSERT INTO a1_pets
VALUES	('Clara', 'Persian/Shorthair' , 100, 'knows how to use a doggy door', '1/7/12', '6/1/15', '6/30/15' , 'cat' , 4 ),
		('Cocoa', 'Rotty' , 200, null, '8/4/13', '1/1/17', '1/30/17' , 'dog' , 5 ),
		('Hobbes', 'Pointer Mix', 200, null, '2/22/14', '2/8/17', null, 'dog', null)

INSERT INTO a1_images
VALUES	('Hobbes1.jpg', null, 7),
		('Cocoa1.jpg', null, 6),
		('Clara1.jpg', 'Clara at Foster Home', 5),
		('Bear1.jpg', null, 4),
		('Abby1.jpg', null, 2),
		('Abby2.jpg', null, 2),
		('Abby3.jpg', null, 2)

select * from a1_images
select * from a1_pets
select * from a1_adopters
select * from a1_types_lookup


select pets_name, pets_breed, pets_adoption_fee, pets_notes, pets_dob, pets_arrival_date, images_name
from a1_pets join a1_images on pets_id=fk_pet
where pets_adopted_date = NULL 
order by pets_name

select AVG(DATEDIFF(day, pets_arrival_date, pets_adopted_date))
from a1_pets


