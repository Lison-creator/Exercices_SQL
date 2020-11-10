CREATE TABLE Album(
    albumId int AUTO_INCREMENT PRIMARY KEY NOT NULL,
    albumName varchar(50) NOT Null,
);


SELECT student_id, first_name, last_name, birth_date, login, year_result from student ;

SELECT concat (first_name," ",last_name) as "Nom complet", student_id, birth_date from student;

ALTER TABLE student ADD COLUMN  Info Étudiant varchar(50);
SELECT concat (student_id," / ", first_name," / ", last_name," / ", birth_date," / ",login," / ", year_result," / ", section_id," / ", course_id" / ",) as "Infos étudiants"
from student;

/* Exercice 2.2.1 – 
Ecrire une requête pour présenter le login et le résultat de tous les étudiants ayant obtenu un résultat annuel supérieur à 16 */

SELECT login, year_result from student
WHERE year_result > 16;

/*Exercice 2.2.2 – 
Ecrire une requête pour présenter le nom et l’id de section des étudiants dont le prénom est Georges */

SELECT first_name,last_name, student_id from student
WHERE first_name == "Georges";

/* Exercice 2.2.3 – 
Ecrire une requête pour présenter le nom et le résultat annuel de tous les étudiants ayant obtenu un résultat annuel compris entre 12 et 16 */

SELECT concat (first_name,last_name) as "Nom Complet", year_result from student
WHERE year_result BETWEEN 12 and 16;

/*Exercice 2.2.4 – 
Ecrire une requête pour présenter le nom, l’id de section et le résultat annuel de tous les étudiants qui ne font pas partie des sections 1010, 1020 et 1110*/
SELECT concat (first_name," ",last_name) as "Nom Complet",section_id, year_result from student
WHERE section_id NOT IN (1010, 1020, 1110);

/*Exercice 2.2.5 – 
Ecrire une requête pour présenter le nom et l’id de section de tous les étudiants qui ont un nom de famille qui termine par « r »*/

SELECT concat (first_name," ",last_name) as "Nom Complet",section_id from student
WHERE last_name LIKE "%r";

/*Exercice 2.2.6 – 
Ecrire une requête pour présenter le nom et le résultat annuel de tous les étudiants qui ont un nom de famille pour lequel la troisième lettre est un « n » et qui ont obtenu un résultat annuel supérieur à 10 */

SELECT concat (first_name," ",last_name) as "Nom Complet",year_result from student
WHERE last_name LIKE "__n%" and year_result > 10;

/*Exercice 2.2.7 – 
Ecrire une requête pour présenter le nom et le résultat annuel classé par résultats annuels décroissants de tous les étudiants qui ont obtenu un résultat annuel inférieur ou égal à 3 */

SELECT concat (first_name," ",last_name) as "Nom Complet",year_result from student
WHERE year_result <= 3;
ORDER BY year_result DESC;

/*Exercice 2.2.8 – 
Ecrire une requête pour présenter le nom complet (nom et prénom séparés par un espace) et le résultat annuel classé par nom croissant sur le nom de tous les étudiants appartenant à la section 1010 */

SELECT concat (first_name," ",last_name) as "Nom Complet",year_result from student
WHERE section_id IN 1010 
ORDER BY last_name ASC;

/*Exercice 2.2.9 – 
Ecrire une requête pour présenter le nom, l’id de section et le résultat annuel classé par ordre croissant sur la section de tous les étudiants appartenant aux sections 1010 et 1020 ayant un résultat annuel qui n’est pas compris entre 12 et 18*/

SELECT concat (first_name," ",last_name) as "Nom Complet",section_id, year_result from student
WHERE section_id IN (1010,1020) AND year_result NOT BETWEEN 12 and 18 
ORDER BY section_id ASC;

/*Exercice 2.2.10 – 
Ecrire une requête pour présenter le nom, l’id de section et le résultat annuel sur 100 (nommer la colonne « Résultat sur 100 ») classé par ordre décroissant du résultat de tous les étudiants appartenant aux sections commençant par 13 et ayant un résultat annuel sur 100 inférieur ou égal à 60*/

SELECT concat (first_name," ",last_name," ",section_id," ", year_result," ") as "Résultat sur 100" from student
WHERE section_id LIKE "%13" 
ORDER BY year_result DESC;



