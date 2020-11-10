/* Exercice 2.3.1 – 
Pourquoi lorsque l’on utilise la fonction « MAX » ou « MIN » les valeurs « NULL » sont-elles ignorées ? 
'Null' n'a pas de valeur;
Exercice 2.3.2 – 
Pourquoi le type des données n’a-t-il pas d’importance lorsque l’on utilise la fonction « COUNT » ?
Il compte les lignes seuelment

Exercice 2.3.7 – Donner le résultat annuel moyen pour l’ensemble des étudiants 
 */
SELECT AVG (year_result) as "Moyenne" from student;

/* Exercice 2.3.8 – Donner le plus haut résultat annuel obtenu par un étudiant */

SELECT MAX (year_result) as "Résultat le plus haut" from student;

/*Exercice 2.3.9 – Donner la somme des résultats annuels */

SELECT SUM (year_result) as "Somme des résultats annuels" from student;

/*Exercice 2.3.10 – Donner le résultat annuel le plus faible */

SELECT MIN (year_result) as "Résultat le plus bas" from student;

/*Exercice 2.3.11 – Donner le nombre de lignes qui composent la table « STUDENT » */

SELECT COUNT(*) as "Nombre d'étudiants" from student;

/*Exercice 2.3.12 – Donner la liste des étudiants (login et année de naissance) nés après 1970 */

SELECT login, YEAR(birth_date)
from student
WHERE YEAR(birth_date) > 1970 as "Personnes nées après 1970";

/*Exercice 2.3.13 – 
Donner le login et le nom de tous les étudiants qui ont un nom composé d’au moins 8 lettres */

SELECT last_name, login from student
WHERE CHAR_LENGTH (last_name) >= 8 as "Personnes dont le nom a plus de 8 lettres"
;

/*Exercice 2.3.14 – 
Donner la liste des étudiants ayant obtenu un résultat annuel supérieur ou égal à 16. 
La liste présente le nom de l’étudiant en majuscules (nommer la colonne « Nom de Famille ») et le prénom de l’étudiant dans l’ordre décroissant des résultats annuels obtenus */

SELECT UPPER(last_name) as "Nom de famille", first_name, year_result from student
WHERE year_result >= 16 as "Résultats supérieurs ou égal à 16"
ORDER BY year_result DESC ;

/*Exercice 2.3.15 – 
Donner un nouveau login à chacun des étudiants ayant obtenu un résultat annuel compris entre 6 et 10. 
Le login se compose des deux premières lettres du prénom de l’étudiant suivi par les quatre premières lettres de son nom le tout en minuscule. 
Le résultat reprend pour chaque étudiant, son nom, son prénom l’ancien et le nouveau login (colonne « Nouveau login ») 
*/

SELECT last_name, first_name, login, LOWER(CONCAT(left(first_name, 2), left(last_name, 4))) as "Nouveau Login",
FROM student
WHERE year_result BETWEEN 6 and 10 ;

/*Exercice 2.3.16 – 
Donner un nouveau login à chacun des étudiants ayant obtenu un résultat annuel égal à 10, 12 ou 14. 
Le login se compose des trois dernières lettres de son prénom suivi du chiffre obtenu en faisant la différence entre l’année en cours et l’année de leur naissance. 
Le résultat reprend pour chaque étudiant, son nom, son prénom l’ancien et le nouveau login (colonne « Nouveau login »)
*/

SELECT last_name, first_name, login, CONCAT(right(first_name, 3), YEAR(CURDATE())-YEAR(birth_date)) as "Nouveau Login",
FROM student
WHERE year_result = 10 OR year_result = 12 OR year_result = 14 ; /* where year_result in (10,12,14)*/

/*Exercice 2.3.17 – 
Donner la liste des étudiants (nom, login, résultat annuel) qui ont un nom commençant par « D », « M » ou « S ». 
La liste doit présenter les données dans l’ordre croissant des dates de naissance des étudiants 
*/

SELECT first_name, last_name, login, year_result
FROM student
WHERE last_name LIKE "d%" OR last_name LIKE "m%" OR last_name LIKE "s%"
ORDER BY birth_date ASC;

/*Exercice 2.3.18 – 
Donner la liste des étudiants (nom, login, résultat annuel) qui ont obtenu un résultat impair supérieur à 10. 
La liste doit être triée du plus grand résultat au plus petit 
*/

SELECT first_name, last_name, login, year_result 
FROM student
WHERE NOT (year_result %2 =0) AND year_result > 10
ORDER BY year_result DESC;

/*Exercice 2.3.19 – 
Donner le nombre d’étudiants qui ont au moins 7 lettres dans leur nom de famille */

SELECT COUNT(last_name) as "alias"
FROM student
WHERE CHAR_LENGTH (last_name) >= 7;


/*Exercice 2.3.20 – 
Pour chaque étudiant né avant 1955, donner le nom, le résultat annuel et le statut. 
Le statut prend la valeur « OK » si l’étudiant à obtenu au moins 12 comme résultat annuel et « KO » dans le cas contraire

ALTER TABLE student ADD COLUMN "Statut" varchar(50)
ALTER TABLE student ADD CONSTRAINT FK_Statut FOREIGN KEY (WHERE year_result >= 12 )
*/

SELECT last_name, first_name, year_result,
CASE
WHEN year_result >= 12 THEN 'OK'
ELSE 'You suck'
END AS "Statut"
FROM student
WHERE YEAR(birth_date) < 1955 

/* Exercice 2.3.21 – 
Donner pour chaque étudiant né entre 1955 et 1965 le nom, le résultat annuel et la catégorie à laquelle il appartient. 
La catégorie est fonction du résultat annuel obtenu : 
un résultat inférieur à 10 appartient à la catégorie « inférieure », un résultat égal à 10 appartient à la catégorie « neutre », un résultat autre appartient à la catégorie « supérieure » 
*/

SELECT last_name, first_name, year_result,
CASE
WHEN year_result < 10 THEN 'Inférieure'
WHEN year_result = 10 THEN "Neutre"
ELSE 'Supérieure'
END AS "Catégorie"
FROM student
WHERE YEAR(birth_date) BETWEEN 1955 AND 1965;

/* Exercice 2.3.22 – 
Donner pour chaque étudiant né entre 1975 et 1985, son nom, son résultat annuel et sa date de naissance sous la forme:
jours en chiffre, mois en lettre et années en quatre chiffres (ex : 11 juin 2005) */

SELECT last_name, year_result,concat(day(birth_date), ' ',
CASE month(birth_date)
WHEN 1 THEN 'janvier'
WHEN 2 THEN 'février'
WHEN 3 THEN 'mars'
WHEN 4 THEN 'avril'
WHEN 5 THEN 'mai'
WHEN 6 THEN 'juin'
WHEN 7 THEN 'juillet'
WHEN 8 THEN 'aout'
WHEN 9 THEN 'septembre'
WHEN 10 THEN 'octobre'
WHEN 11 THEN 'novembre'
WHEN 12 THEN 'décembre'
END, ' ', year(birth_date)
) AS Literal_date
from student
where year(birth_date) between 1975 and 1985

/*Exercice 2.3.23 – 
Donner pour chaque étudiant né en dehors des mois d’hiver et ayant obtenu un résultat inférieur à 7, son nom, le mois de sa naissance (en chiffre) son résultat annuel et son résultat annuel corrigé (« Nouveau résultat ») tel que si le résultat annuel est égal à 4, la valeur proposée est « NULL » 
*/
SELECT first_name, last_name, MONTH(birth_date) as "Mois de naissance", year_result,
CASE 
    WHEN year_result = 4 THEN NULL
    ELSE year_result
    END AS "Nouveau résultat"
FROM student
WHERE MONTH(birth_date) NOT IN (12, 1, 2, 3) AND year_result < 7
