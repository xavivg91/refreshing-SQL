# Creamos la base de datos
CREATE DATABASE library;

# Utilizamos la base de datos 'library'
USE library;

# Creamos la tabla 'users'
CREATE TABLE IF NOT EXISTS users(
	_id INT NOT NULL AUTO_INCREMENT, 
	name VARCHAR(45) NOT NULL,
    lastname VARCHAR(45) NOT NULL,
    email VARCHAR(45) NOT NULL,
    primary key (_id)
);

# Creamos la tabla 'thematic'
CREATE TABLE IF NOT EXISTS thematic(
	_id INT NOT NULL AUTO_INCREMENT, 
    name VARCHAR(45) NULL,
	primary key (_id)
);

# Creamos la tabla 'author'
CREATE TABLE IF NOT EXISTS author(
	_id INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(45) NULL,
    primary key (_id)
);

# Creamos la tabla 'books'
CREATE TABLE IF NOT EXISTS `library`.`books` (
  `_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `author_id` INT NOT NULL,
  `thematic_id` INT NOT NULL,
  `year` VARCHAR(4) NULL,
  PRIMARY KEY (`_id`),
  INDEX `author_id_idx` (`author_id` ASC),
  INDEX `thematic_id_idx` (`thematic_id` ASC),
  CONSTRAINT `author_id`
    FOREIGN KEY (`author_id`)
    REFERENCES `library`.`author` (`_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `thematic_id`
    FOREIGN KEY (`thematic_id`)
    REFERENCES `library`.`thematic` (`_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

# Creamos la tabla 'lends'
CREATE TABLE IF NOT EXISTS `library`.`lends` (
  `_id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NOT NULL,
  `book_id` INT NOT NULL,
  `date` DATE NOT NULL,
  `returned` INT NOT NULL,
  PRIMARY KEY (`_id`),
  INDEX `user_id_idx` (`user_id` ASC),
  INDEX `book_id_idx` (`book_id` ASC),
  CONSTRAINT `user_id`
    FOREIGN KEY (`user_id`)
    REFERENCES `library`.`users` (`_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `book_id`
    FOREIGN KEY (`book_id`)
    REFERENCES `library`.`books` (`_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

# Introducimos valores en la tabla 'users'
INSERT INTO users (name, lastname, email) VALUES ("Antonio", "García", "antonio23@hotmail.com");
INSERT INTO users (name, lastname, email) VALUES ("Mireia", "Rodríguez", "mirerodricn@gmail.com");
INSERT INTO users (name, lastname, email) VALUES ("Javi", "Mateo", "javim85@hotmail.com");

# Introducimos valores en la tabla 'thematic'
INSERT INTO thematic (name) VALUES ("Fantasía");
INSERT INTO thematic (name) VALUES ("Terror");
INSERT INTO thematic (name) VALUES ("Ciencia ficción");

# Introducimos valores en la tabla 'author'
INSERT INTO author (name) VALUES ("J.R.R. Tolkien");
INSERT INTO author (name) VALUES ("Stephen King");
INSERT INTO author (name) VALUES ("H. G. Wells");

# Introducimos valores en la tabla 'books'
INSERT INTO books (name, author_id, thematic_id, year) VALUES ("El Señor de los Anillos: Las Dos Torres", 1, 1, 1979);
INSERT INTO books (name, author_id, thematic_id, year) VALUES ("La Niebla", 2, 2, 1980);
INSERT INTO books (name, author_id, thematic_id, year) VALUES ("La Guerra de los Mundos", 3, 3, 1898);

# Introducimos valores en la tabla 'lends'
INSERT INTO lends (user_id, book_id, date, returned) VALUES (1, 1, '2020-06-20', 1);
INSERT INTO lends (user_id, book_id, date, returned) VALUES (1, 2, '2020-07-10', 0);
INSERT INTO lends (user_id, book_id, date, returned) VALUES (2, 3, '2020-07-06', 0);


# CONSULTAS 
# Consultar la lista de usuarios/libros/autores/temáticas
SELECT name, lastname, email FROM users;
SELECT name FROM books;
SELECT name FROM author;
SELECT name FROM thematic;

# Consultar los libros que pertenecen a un autor
SELECT a.name, b.name 
FROM books b 
JOIN author a 
ON b.author_id = a._id 
WHERE a.name = 'Stephen King'

# Consultar cuántos libros hay de cada autor
SELECT a.name, COUNT(*)
FROM books b 
JOIN author a 
ON b.author_id = a._id
GROUP BY a.name

# QUERIES PARA LA BASE DE DATOS CLASSICMODELS
# Consultar cuántos trabajadores hay en cada oficina, 
# devolviendo el nombre de la oficina y el total de trabajadores
SELECT addressline1, COUNT(*)
FROM employees e 
JOIN offices o 
ON e.officeCode = o.officeCode 
GROUP BY o.officeCode

# Consultar los clientes que han realizado más de 3 pagos
SELECT c.customerName , COUNT(*)
FROM customers c
JOIN payments p
ON c.customerNumber = p.customerNumber
GROUP BY p.customerNumber
HAVING COUNT(*) > 3

# Consultar los clientes cuya media de pagos sea superior a 40000
SELECT c.customerName , AVG(amount)
FROM customers c
JOIN payments p
ON c.customerNumber = p.customerNumber
GROUP BY p.customerNumber
HAVING AVG(amount) > 40000

# Obtener el desglose del pedido de un usuario (pedido 10100)
SELECT * 
FROM customers c
JOIN orders o
ON c.customerNumber = o.customerNumber
JOIN orderdetails od
ON o.orderNumber = od.orderNumber
WHERE od.orderNumber = 10100

