DROP DATABASE IF EXISTS foolish_man;
CREATE DATABASE IF NOT EXISTS foolish_man;
USE foolish_man;

DROP TABLE IF EXISTS pets;
CREATE TABLE IF NOT EXISTS pets
(	
	id INT NOT NULL PRIMARY KEY,
    kind_of_animal VARCHAR(20),
    name_animal VARCHAR(20)
    );
INSERT pets
VALUES
	(1,"кошка", "Муся"),
    (2, "собака", "Дружок"),
    (3, "хомяк", "Шмяк"),
    (4, "собака", "Барабака"),
    (5, "кошка", "Киса"),
    (6, "хомяк", "Байден");
    
DROP TABLE IF EXISTS cat;
CREATE TABLE IF NOT EXISTS cat
(
	id INT,
    FOREIGN KEY (id) REFERENCES pets (id) ON DELETE CASCADE,
	name_animal VARCHAR(20),
    aviary INT(3),
    date_of_bith DATE NOT NULL,
    command VARCHAR(1000)
    );

INSERT cat
VALUES
	(1, "Муся", 001, "2001-12-31", "Сидеть, Лежать, Жрать, Молчать"),
    (5, "Киса", 002, "2015-03-08", "Голос, Лежать, Спать");
    
DROP TABLE IF EXISTS dog;
CREATE TABLE IF NOT EXISTS dog
(
	id INT,
    FOREIGN KEY (id) REFERENCES pets (id) ON DELETE CASCADE,
	name_animal VARCHAR(20),
    aviary INT(3),
    date_of_bith DATE NOT NULL,
    command VARCHAR(1000)
    );
 
 INSERT dog
 VALUES
	(2, "Дружок", 003, "2010-11-25", "Сидеть, Лежать, Голос"),
    (4, "Барабака", 004, "2015-06-14", "Фас, Нельзя, Рядом");
    
 DROP TABLE IF EXISTS hamster;
CREATE TABLE IF NOT EXISTS hamster
(
	id INT,
    FOREIGN KEY (id) REFERENCES pets (id) ON DELETE CASCADE,
	name_animal VARCHAR(20),
    aviary INT(3),
    date_of_bith DATE NOT NULL,
    command VARCHAR(1000)
    );

INSERT hamster
VALUES
	(3, "Шмяк", 005, "2020-05-12", "Прячь еду, запасы к осмотру"),
    (6, "Байден", 006, "2023-01-20", "В бой");

DROP TABLE IF EXISTS pack_animals;
CREATE TABLE IF NOT EXISTS pack_animals
(	
	id INT NOT NULL PRIMARY KEY,
    kind_of_animal VARCHAR(20),
    name_animal VARCHAR(20)
    );

INSERT pack_animals
VALUES
(7, "конь", "Ретивый"),
(8, "осел", "Професор"),
(9, "верблюд", "Сушняк"),
(10, "конь", "Педальный"),
(11, "осел", "Покладистый"),
(12, "верблюд", "Осанистый");

DROP TABLE IF EXISTS horses;
CREATE TABLE IF NOT EXISTS horses
(
	id INT,
    FOREIGN KEY (id) REFERENCES pack_animals (id) ON DELETE CASCADE,
	name_animal VARCHAR(20),
    aviary INT(3),
    date_of_bith DATE NOT NULL,
    command VARCHAR(1000)
    );
    
INSERT horses
VALUES
(7, "Ретивый", 007, "2020-05-25", "Галоп, Рысь, Еле тащись"),
(10, "Педальный", 008, "2021-08-02", "Галоп, Рысь, Еле тащись");

DROP TABLE IF EXISTS camels;
CREATE TABLE IF NOT EXISTS camels
(
	id INT,
    FOREIGN KEY (id) REFERENCES pack_animals (id) ON DELETE CASCADE,
	name_animal VARCHAR(20),
    aviary INT(3),
    date_of_bith DATE NOT NULL,
    command VARCHAR(1000)
    );
 
 INSERT camels
VALUES
(9, "Сушняк", 009, "2018-02-02", "Пей воду, Беги"),
(12, "Осанистый", 010, "2019-09-04", "Плюнь на него, Беги");

 DROP TABLE IF EXISTS donkeys;
CREATE TABLE IF NOT EXISTS donkeys
(
	id INT,
    FOREIGN KEY (id) REFERENCES pack_animals (id) ON DELETE CASCADE,
	name_animal VARCHAR(20),
    aviary INT(3),
    date_of_bith DATE NOT NULL,
    command VARCHAR(1000)
    );    

INSERT donkeys
VALUES
(8, "Професор", 011, "2019-06-14", "Иди, Беги"),
(11, "Покладистый", 012, "2015-11-15", "Стоять, Лежать");
    
DELETE FROM pack_animals
WHERE kind_of_animal="верблюд"
LIMIT 1000;

DROP TEMPORARY TABLE IF EXISTS animals;
CREATE TEMPORARY TABLE IF NOT EXISTS animals AS 
SELECT *, 'Лошади' as genus FROM horses
UNION SELECT *, 'Ослы' AS genus FROM donkeys
UNION SELECT *, 'Собаки' AS genus FROM dog
UNION SELECT *, 'Кошки' AS genus FROM cat
UNION SELECT *, 'Хомяки' AS genus FROM hamster;

DROP TABLE IF EXISTS yang_animal;
CREATE TABLE IF NOT EXISTS yang_animal AS
SELECT name_animal, date_of_bith, command, aviary, TIMESTAMPDIFF(MONTH, date_of_bith, CURDATE()) AS Age_in_month
FROM animals WHERE date_of_bith BETWEEN ADDDATE(curdate(), INTERVAL -3 YEAR) AND ADDDATE(CURDATE(), INTERVAL -1 YEAR);
 
SELECT * FROM yang_animal;

SELECT h.id, pa.kind_of_animal, h.name_animal, h.date_of_bith, h.command, ya.Age_in_month 
FROM horses h
LEFT JOIN yang_animal ya ON ya.name_animal = h.name_animal
LEFT JOIN pack_animals pa ON pa.id = h.id
UNION 
SELECT d.id, pa.kind_of_animal, d.name_animal, d.date_of_bith, d.command, ya.Age_in_month 
FROM donkeys d 
LEFT JOIN yang_animal ya ON ya.name_animal = d.name_animal
LEFT JOIN pack_animals pa ON pa.id = d.id
UNION
SELECT c.id, p.kind_of_animal, c.name_animal, c.date_of_bith, c.command, ya.Age_in_month 
FROM cat c
LEFT JOIN yang_animal ya ON ya.name_animal = c.name_animal
LEFT JOIN pets p ON p.id = c.id
UNION
SELECT d.id, p.kind_of_animal, d.name_animal, d.date_of_bith, d.command, ya.Age_in_month 
FROM dog d
LEFT JOIN yang_animal ya ON ya.name_animal = d.name_animal
LEFT JOIN pets p ON p.id = d.id
UNION
SELECT hm.id, p.kind_of_animal, hm.name_animal, hm.date_of_bith, hm.command, ya.Age_in_month 
FROM hamster hm
LEFT JOIN yang_animal ya ON ya.name_animal = hm.name_animal
LEFT JOIN pets p ON p.id = hm.id;

