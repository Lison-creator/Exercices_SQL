/*Exercice 2.4.7 – 
Donner pour chaque section, le résultat maximum (dans une colonne appelée « Résultat maximum ») obtenu par les étudiants 
*/

SELECT year_result, section_id, MAX(year_result) as "Résultat maximum"
FROM student
GROUP BY section_id;

/*Exercice 2.4.8 – 
Donner pour toutes les sections commençant par 10, 
le résultat annuel moyen PRÉCIS (dans une colonne appelée « Moyenne ») obtenu par les étudiants 
*/

SELECT section_id, avg(year_result) as "Moyenne"
FROM student
WHERE section_id LIKE "10%"
GROUP BY section_id

/*Exercice 2.4.9 – 
Donner le résultat moyen (dans une colonne appelée « Moyenne ») et le mois en chiffre (dans une colonne appelée « Mois de naissance ») 
pour les étudiants nés le même mois entre 1970 et 1985 
*/

SELECT avg(year_result) as "Moyenne", MONTH(birth_date) as "Mois de naissance"
FROM student
WHERE YEAR(birth_date) >= 1970 and YEAR(birth_date) <= 1985
GROUP BY MONTH(birth_date)

/*Exercice 2.4.10 – 
Donner pour toutes les sections qui comptent plus de 3 étudiants, la moyenne PRÉCISE des résultats annuels (dans une colonne appelée « Moyenne ») 
*/

SELECT section_id, avg(year_result) as "Moyenne", MONTH(birth_date) as "Mois de naissance"
FROM student
GROUP BY section_id
HAVING COUNT(section_id) > 3

/*Exercice 2.4.11 – 
Donner le résultat maximum obtenu par les étudiants appartenant aux sections dont le résultat moyen est supérieur à 8 
*/

SELECT section_id, MAX(year_result) as "Résultat max", avg(year_result) as "Moyenne"
FROM student
GROUP BY section_id
HAVING avg(year_result) > 8

/* Exercice 2.6.1 – 
Donner pour chaque cours le nom du professeur responsable ainsi que la section dont le professeur fait partie 
*/

SELECT course.course_name, section.section_name, professor.professor_name
FROM course 
JOIN professor on course.professor_id = professor.professor_id
JOIN section on professor.section_id = section.section_id

/*Exercice 2.6.2 – 
Donner pour chaque section, l’id, le nom et le nom de son délégué. 
Classer les sections dans l’ordre inverse des id de section. Un délégué est un étudiant de la table « STUDENT »
*/

SELECT section.section_name, section.section_id, CONCAT(student.first_name," ", student.last_name) as "STUDENT"
FROM section
JOIN student ON section.delegate_id = student.student_id
ORDER BY student.student_id DESC

/*Exercice 2.6.3 – Donner pour chaque section, le nom des professeurs qui en sont membre */

SELECT section.section_name, section.section_id, CONCAT(professor.professor_name, " ", professor.professor_surname) as "Prof"
FROM professor
RIGHT JOIN section ON section.section_id = professor.section_id

/*Exercice 2.6.4 – 
Même objectif que la question 3 mais seuls les sections comportant au moins un professeur doivent être reprises */

SELECT section.section_name, section.section_id, CONCAT(professor.professor_name, " ", professor.professor_surname) as "Prof"
FROM professor
JOIN section ON section.section_id = professor.section_id

/*Exercice 2.6.5 – 
Donner à chaque étudiant ayant obtenu un résultat annuel supérieur ou égal à 12 son grade en fonction de son résultat annuel et sur base de la table grade. 
La liste doit être classée dans l’ordre alphabétique des grades attribués 
*/

SELECT student.year_result, CONCAT(student.last_name," ", student.first_name) as "Etudiant", grade.grade
FROM grade
JOIN student ON student.year_result BETWEEN grade.lower_bound AND grade.upper_bound
WHERE student.year_result >= 12
ORDER BY grade.grade ASC

/*Exercice 2.6.6 – 
Donner la liste des professeurs et la section à laquelle ils se rapportent ainsi que le(s) cour(s) (nom du cours et crédits) dont le professeur est responsable. 
La liste est triée par ordre décroissant des crédits attribués à un cours  
*/

SELECT CONCAT(professor.professor_name, " ", professor.professor_surname) as "Prof", section.section_name, course.course_name, course.course_ects
FROM professor 
RIGHT JOIN section ON section.section_id = professor.section_id
RIGHT JOIN course ON course.professor_id = professor.professor_id
ORDER BY course.course_ects DESC

/* Exercice 2.6.7 – 
Donner pour chaque professeur son id et le total des crédits ECTS (« ECTS_TOT ») qui lui sont attribués. 
La liste proposée est triée par ordre décroissant de la somme des crédits alloués  
 INVALIDE */

SELECT CONCAT(professor.professor_surname, " ", professor.professor_name) as "Prof", professor.professor_id, SUM(course.course_ects) as "ECTS_TOT"
FROM professor
LEFT JOIN course ON professor.professor_id = course.professor_id
GROUP BY professor.professor_id, "Prof"
ORDER BY course.course_ects DESC

/*Exercice 2.6.8 – 
Donner la liste (nom et prénom) de l’ensemble des professeurs et des étudiants dont le nom est composé de plus de 8 lettres. 
Ajouter une colonne pour préciser la catégorie (S pour « STUDENT », P pour « PROFESSOR ») à laquelle appartient l’individu */

SELECT first_name as "first_name", last_name as "last_name", "S" AS "Catégorie"
FROM student
WHERE LENGTH(last_name) > 8
UNION
SELECT professor_surname as "first_name", professor_name as "last_name", "P" AS "Catégorie"
from professor
WHERE LENGTH(professor_name) > 8


/*Exercice 2.6.9 – Donner l’id de chacune des sections qui n’ont pas de professeur attitré  */

SELECT section.section_id
FROM section 
LEFT JOIN professor ON section.section_id = professor.section_id 
WHERE professor_name is NULL 