# Creamos la base de datos 'evaluacion'
CREATE DATABASE evaluacion;

# Utilizamos la base de datos 'evaluacion'
USE evaluacion;

# Creamos tabla 'candidates'
CREATE TABLE `evaluacion`.`candidates` (
  `CANDIDATE_ID` INT NOT NULL AUTO_INCREMENT,
  `CANDIDATE_NAME` VARCHAR(50) NOT NULL,
  `CANDIDATE_SURNAME` VARCHAR(50) NOT NULL,
  `CANDIDATE_EMAIL` VARCHAR(50) NOT NULL,
  `CANDIDATE_PHONE` INT ZEROFILL NULL,
  PRIMARY KEY (`CANDIDATE_ID`),
  UNIQUE INDEX `CANDIDATE_EMAIL_UNIQUE` (`CANDIDATE_EMAIL` ASC));

# Creamos tabla 'jobs'
CREATE TABLE `evaluacion`.`jobs` (
  `JOB_ID` INT NOT NULL AUTO_INCREMENT,
  `JOB_TITLE` VARCHAR(35) NOT NULL,
  `CATEGORY` VARCHAR(35) NOT NULL,
  `MIN_SALARY` DECIMAL(6,0) NULL,
  `MAX_SALARY` DECIMAL(6,0) NULL,
  PRIMARY KEY (`JOB_ID`));
  
  # Creamos tabla 'candidates_jobs'
  CREATE TABLE `evaluacion`.`candidates_jobs` (
  `JOB_ID` INT NOT NULL,
  `CANDIDATE_ID` INT NOT NULL,
  PRIMARY KEY (`JOB_ID`, `CANDIDATE_ID`),
  INDEX `CANDIDATE_ID_idx` (`CANDIDATE_ID` ASC),
  CONSTRAINT `JOB_ID`
    FOREIGN KEY (`JOB_ID`)
    REFERENCES `evaluacion`.`jobs` (`JOB_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `CANDIDATE_ID`
    FOREIGN KEY (`CANDIDATE_ID`)
    REFERENCES `evaluacion`.`candidates` (`CANDIDATE_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

# Escribe una sentencia SQL para añadir una entrada
# a cada una de las tablas con el mínimo de campos
INSERT INTO candidates (CANDIDATE_NAME, CANDIDATE_SURNAME, CANDIDATE_EMAIL, CANDIDATE_PHONE) 
VALUES ("María", "Romero", "maria_romero@hotmail.com", "632452322");
INSERT INTO candidates (CANDIDATE_NAME, CANDIDATE_SURNAME, CANDIDATE_EMAIL, CANDIDATE_PHONE) 
VALUES ("David", "Mesas", "dmesas@hotmail.com", "633567231");
INSERT INTO candidates (CANDIDATE_NAME, CANDIDATE_SURNAME, CANDIDATE_EMAIL, CANDIDATE_PHONE) 
VALUES ("Marc", "Domènech", "mdome@hotmail.com", "633294372");

INSERT INTO jobs (JOB_TITLE, CATEGORY, MIN_SALARY, MAX_SALARY) 
VALUES ("Data Scientist Junior", "Data & Analytics", "40000", "50000");
INSERT INTO jobs (JOB_TITLE, CATEGORY, MIN_SALARY, MAX_SALARY) 
VALUES ("Software Test Engineer", "Tester", "30000", "40000");
INSERT INTO jobs (JOB_TITLE, CATEGORY, MIN_SALARY, MAX_SALARY) 
VALUES ("Data Analyst", "Data & Analytics", "35000", "40000");

INSERT INTO candidates_jobs (JOB_ID, CANDIDATE_ID) 
VALUES ("1", "1");
INSERT INTO candidates_jobs (JOB_ID, CANDIDATE_ID) 
VALUES ("2", "2");
INSERT INTO candidates_jobs (JOB_ID, CANDIDATE_ID) 
VALUES ("1", "3");

# Escribe una sentencia SQL para modificar el salario 
# mínimo y máximo de una entrada concreta de la tabla “Jobs”
UPDATE jobs SET MIN_SALARY = 50000 WHERE JOB_ID = 1;
UPDATE jobs SET MAX_SALARY = 60000 WHERE JOB_ID = 1;

# Escribe una sentencia SQL para modificar el salario mínimo a “35000” 
# de todas las entradas cuya categoría sea “Tester”
UPDATE jobs SET MIN_SALARY = 35000 WHERE CATEGORY = "Tester";

# Escribe una sentencia SQL que devuelva el nombre de las Jobs ordenado primero por salario máximo 
# y luego alfabéticamente de aquellas cuyo salario mínimo sea superior a 20000
SELECT JOB_TITLE 
FROM jobs
WHERE MIN_SALARY > 20000
ORDER BY MAX_SALARY DESC, JOB_TITLE ;

# Escribe una sentencia SQL que devuelva el nombre del candidato 
# y el nombrede la job a la cual está asignado. 
SELECT c.CANDIDATE_NAME, j.JOB_TITLE FROM candidates c
JOIN candidates_jobs cj 
ON c.CANDIDATE_ID = cj.CANDIDATE_ID 
JOIN jobs j
ON cj.JOB_ID = j.JOB_ID;

# Escribe una sentencia SQL que devuelva cuántos 
# candidatos hay asignados a cada una de las diferentes Jobs
SELECT j.JOB_TITLE, COUNT(*) FROM candidates c
JOIN candidates_jobs cj 
ON c.CANDIDATE_ID = cj.CANDIDATE_ID 
JOIN jobs j
ON cj.JOB_ID = j.JOB_ID
GROUP BY j.JOB_TITLE;

# Escribe una sentencia SQL que elimine todos los 
# candidatos que no estén asignados a ninguna job
DELETE c FROM candidates c
JOIN candidates_jobs cj 
ON c.CANDIDATE_ID = cj.CANDIDATE_ID 
WHERE JOB_ID IS NULL;

# Escribe una sentencia SQL que elimine todas las Jobs
# que no tengan ningún candidato asignado
DELETE c FROM candidates c
JOIN candidates_jobs cj 
ON c.CANDIDATE_ID = cj.CANDIDATE_ID 
JOIN jobs j
ON cj.JOB_ID = j.JOB_ID
WHERE CANDIDATE_NAME IS NULL;

# Escribe una sentencia SQL que vacíe la tabla de “candidates_jobs”
TRUNCATE candidates_jobs;
