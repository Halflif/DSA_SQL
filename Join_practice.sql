select
      city.countrycode as '국가코드',
         country.name as '국가명',
         city.district as '지역명',
         city.name as '도시명',
         city.population as '인구수'
         from city
         join country on city.countrycode = country.code
         limit 11;

select
      country.name as '국가명',
       countrylanguage.language as '사용언어',
       countrylanguage.isofficial as '공식언어유무',
       countrylanguage.percentage as '사용비율'
       from countrylanguage
       join country
       on country.code = countrylanguage.countrycode
       limit 15;

SELECT
       country.Name AS '국가명',
       COUNT(city.Name) AS '도시수'
     FROM country
     JOIN city ON country.Code = city.CountryCode
     GROUP BY country.Name
     HAVING COUNT(city.Name) BETWEEN 60 AND 150
     order by COUNT(city.Name) desc;


SELECT
       CASE
         WHEN GROUPING(국가명) = 1 THEN '  '
         ELSE 국가명
       END AS '국가명',
       SUM(도시수) AS '도시수'
     FROM (
       SELECT
         country.Name AS 국가명,
         COUNT(city.Name) AS 도시수
       FROM country
       JOIN city ON country.Code = city.CountryCode
       GROUP BY country.Name
       HAVING COUNT(city.Name) BETWEEN 60 AND 150
       order by COUNT(city.Name) desc
     ) AS sub
     GROUP BY 국가명 WITH ROLLUP
     order by SUM(도시수) desc;
