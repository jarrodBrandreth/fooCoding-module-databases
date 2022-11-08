CREATE DATABASE HR;
USE HR;

CREATE TABLE location (
store_id int primary key auto_increment not null,
city varchar(100),
address varchar(100)
);

INSERT INTO location (city,address)
VALUES 
('malmo','123 Fakegatan'),
('malmo','2 Notrealgatan'),
('malmo','9 Kungsgatan'),
('malmo','4 Storegatan'),
('malmo','18 Notrealvagen'),
('gothenburg','24 Loremvagen'),
('gothenburg','9 Storgatan'),
('gothenburg','61 Drottningatan'),
('stockholm','23 Lillagatan'),
('stockholm','1 Kingsvagen'),
('stockholm','44 Loremipsomgatan'),
('stockholm','5 Grandgatan')
; 

CREATE TABLE employee (
employee_id int primary key auto_increment not null,
first_name varchar(50) not null,
last_name varchar(50) not null,
birth_date date not null,
email varchar(100) unique,
store_id int,
FOREIGN KEY (store_id) REFERENCES location(store_id)
);

INSERT INTO employee (first_name,last_name,birth_date,email,store_id) 
VALUES
('jerry','seinfeld','1961-04-01','jerry_seinfeld@vandalayindustries.com',1),
('elaine','benes','1962-01-29','elaine_benes@vandalayindustries.com',2),
('cosmo','kramer','1975-08-16','cosmo_kramer@vandalayindustries.com',3),
('george','costanza','1964-06-21','george_costanza@vandalayindustries.com',4),
('art','vandalay','1980-09-18','art_vandalay@vandalayindustries.com',5),
('michael','bluth','1982-08-21','michael_bluth@vandalayindustries.com',6),
('george','michael','1994-01-12','george_michael@vandalayindustries.com',7),
('lucille','austero','1989-07-04','lucille_austero@vandalayindustries.com',8),
('tobias','funke','1996-04-07','tobias_funke@vandalayindustries.com',9),
('lindsey','funke','1992-11-24','lindsey_funke@vandalayindustries.com',10),
('bob','loblaw','1990-09-19','bob_loblaw@vandalayindustries.com',1),
('susan','ross','1999-05-22','susan_ross@vandalayindustries.com',2),
('maggie','lizer','2000-02-14','maggie_lizer@vandalayindustries.com',12),
('tony','wonder','2001-12-24','tony_wonder@vandalayindustries.com',4),
('marta','estrella','1988-03-24','marta_estrella@vandalayindustries.com',5),
('steve','holt','1977-12-04','steve_holt@vandalayindustries.com',6),
('larry','middleman','2002-07-24','larry_middleman@vandalayindustries.com',7),
('jacopo','peterman','1999-03-17','jacopo_peterman@vandalayindustries.com',8),
('david','puddy','2000-04-14','david_puddy@vandalayindustries.com',11),
('estelle','costanza','1987-12-22','estelle_costanza@vandalayindustries.com',10)
;    




 