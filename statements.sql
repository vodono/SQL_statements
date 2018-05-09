-- Реализовать наборы стейтментов для PostgreSQL. 

-- 1. Создать базу данных shop.
CREATE DATABASE shop;


-- 2. Создать юзера shop и дать ему полный доступ к БД shop.
CREATE USER shop WITH password 'shop';
GRANT ALL ON DATABASE shop TO shop;


-- 3. Создать юзера viewer и дать ему доступ на чтение БД shop.
CREATE USER viewer WITH password 'viewer';
GRANT SELECT ON ALL TABLES IN SCHEMA public TO viewer;


-- 4. Создать таблицу для хранения категорий (хранить название).
CREATE TABLE category (
	category_name	varchar(35) PRIMARY KEY
);


-- 5. Добавить несколько категорий.
INSERT INTO category (category_name) VALUES
	("Measuring instrument"),
	('Carpenter''s instrument'),
	('Spading instrument');


-- 6. Создать таблицу для хранения товаров (название, категория, цена).
CREATE TABLE merchandises (
	name 	varchar(50) PRIMARY KEY,
	category varchar(35) REFERENCES category (category_name),
	price double precision
);


-- 7. Внести несколько товаров по цене 1.00
INSERT INTO merchandises (name, category, price) VALUES
	('Ruler', 'Measuring instrument', 1.00),
	('Slide calliper', 'Measuring instrument', 1.00),
	('Chisel', 'Carpenter''s instrument', 1.00),
	('Hand plane', 'Carpenter''s instrument', 1.00),
	('Spade', 'Spading instrument', 1.00),
	('Rake', 'Spading instrument', 1.00);


-- 8. Обновить цену первого товара — 3.50
UPDATE merchandises SET price = 3.5 WHERE name = 'Ruler';


-- 9. Увеличить цену всех товаров на 10%.
UPDATE merchandises SET price = price * 1.1;


-- 10. Удалить товар № 2.
DELETE FROM merchandises WHERE name = 'Slide calliper';


-- 11. Выбрать все товары с сортировкой по названию.
SELECT * FROM merchandises ORDER BY name ASC;


-- 12. Выбрать все товары с сортировкой по убыванию цены.
SELECT * FROM merchandises ORDER BY price DESC, name ASC;


-- 13. Выбрать 3 самых дорогих товара.
SELECT * FROM merchandises ORDER BY price DESC, name ASC LIMIT 3;


-- 14. Выбрать 3 самых дешевых товара.
SELECT * FROM merchandises ORDER BY price ASC, name ASC LIMIT 3;


-- 15. Выбрать вторую тройку самых дорогих товаров (с 4 по 6).
SELECT * FROM merchandises ORDER BY price DESC, name ASC LIMIT 3 OFFSET 3;


-- 16. Выбрать наименование самого дорогого товара.
SELECT name FROM merchandises ORDER BY price DESC LIMIT 1;


-- 17. Выбрать наименование самого дешевого товара.
SELECT name FROM merchandises ORDER BY price ASC LIMIT 1;


-- 18. Выбрать количество всех товаров.
SELECT COUNT(*) FROM merchandises;


-- 19. Выбрать среднюю цену всех товаров.
SELECT AVG(price) FROM merchandises;


-- 20. Создать представление (create view) с отображением 3 самых дорогих товаров.
CREATE VIEW top_3_prices AS
	SELECT * FROM merchandises ORDER BY price DESC LIMIT 3;
