use world;

desc city;

create table t_city
select
	concat(countrycode, name, ' ' ,population) as city_info
from city
order by countrycode desc, population desc
limit 30;

desc t_city;

drop table t_city;


-----Q2_1;
select
 lpad(floor(rand()*1000),3,0) as 'luggage pw';
 
 ------Q2_2;
select
	concat(countrycode, ' : ', name, ' : ', district) as '한미일에서 인구 top10 도시명',
    concat(format(population, 3),'명') as '인구수'
    from city
    where countrycode in('KOR', 'JPN', 'USA')
    Order by  population desc
    limit 10;
 
 -----Q2_3;
select
 *,
 substr(city_info,1,3) as '국가코드',
 locate(' ', city_info, 1),
 substr(city_info, locate(' ', city_info), 99999) as '인구수'
 from t_city;

select
 *,
 substr(city_info,1,3) as '국가코드',
 locate(' ', city_info, 1),
 substr(SUBSTRING(city_info, LOCATE(' ', SUBSTRING(city_info, LOCATE(' ', city_info) + 1)) + 1), locate(' ', city_info), 99999) as '인구수'
 from t_city;
 
 select
 *,
 substr(city_info,1,3) as '국가코드',
 substring_index(city_info, ' ', -1) as '인구수'
 from t_city;

SELECT 
    SUBSTRING(city_info, LOCATE(' ', city_info) + 1)
FROM t_city;

 -----Q2_4;
 
 select 
	current_timestamp() as '특정날짜',
    last_day(current_timestamp()) as '특정날짜의 마지막 일',
    dayname(current_timestamp()) as '요일';
 
 
 
 /* 실습 */
 --- 1. database 생성;
 create database if not exists youDB;
 use youDB;
 select database(), user();
 
 --2 테이블 생성;
 drop table emp;.
 
 create table emp(      --무결성 --> 중복을 최소화 -> 제역조건 담당 -> PK, FK, NN, UNIQUE, CHECK
		id int primary key,    ----not null, unique
		name char(20) not null,   ----- not null, 중복 ok
        age tinyint,
        p_number varchar(20) default '사줘잉~'
        );
 
 /* table copy 명령어 : nn을 제외한 모든 제약조건은 copy되지 않음*/
 create table temp
 select * from emp;
 select * from temp;
 
 desc emp;
 desc temp;
 
 --3 DML (insert, upate)
 desc emp;
 
 select * from emp;
 rollback;
 insert into emp values(1, '박진혁', 25, default);
 insert into emp values(2, '김태원', 24, '010-5235-4341');
 insert into emp values(3, '김석현', 28, '010-7894-6110');
 insert into emp values(4, '김태원', 24, default);
 insert into emp values(5, '박재욱', 55, default);
 insert into emp values(6, '김선우', 47, default);
insert into emp values(7, '김민서', 42, '010-5212-8596');

update emp
set name = '양동근'
where id = 4;

update emp
set age = 19
where id = 3;

commit;

--4. DQL : 이름과 연령대만(20대, 30대,....) 조회해라;

select * from emp
where age between 20 and 30;

---- DB 실습;

create table box_office(
	SEQ_NO int primary key,
    YEARS smallint,
    RANKS int,
    MOVIE_NAME varchar(200),
    RELEASE_DATE datetime,
    SALE_AMT double,
    SHARE_RATE double,
    AUDIENCE_NUM int,
    SCREEN_NUM smallint,
    SHOWING_COUNT int,
    REP_COUNTRY varchar(50),
    COUNTRIES varchar(100),
    DISTRIBUTOR varchar(300),
    MOVIE_TYPE varchar(100),
    GENRE varchar(100),
    DIRECTOR varchar(1000)
    );
    
    drop table box_office;
    
desc box_office;

select years from box_office;

create table if not exists box_office(
   SEQ_NO   int   primary key,
    YEARS   smallint,
    RANKS   int,
    MOVIE_NAME   varchar(200),
    RELEASE_DATE   datetime,
    SALE_AMT   double,
    SHARE_RATE   double,
    AUDIENCE_NUM   int,
    SCREEN_NUM   smallint,
    SHOWING_COUNT   int,
    REP_COUNTRY   varchar(50),
    COUNTRIES   varchar(100),
    DISTRIBUTOR   varchar(300),
    MOVIE_TYPE   varchar(100),
    GENRE   varchar(100),
    DIRECTOR varchar(1000)
);

select count(*) from box_office;

desc box_office;

select years from box_office;

use world;

show tables;

desc country;

select region from country limit 10;

select name from country limit 10;

select governmentform from country;

-----Q review_1;

SELECT
  ROW_NUMBER() OVER (ORDER BY population DESC) AS 'NO.',
  code AS '국가코드',
  CONCAT(name, '<', continent, '>') AS '국가<대륙>',
  region as '대륙내 지역',
  format(population,0) as '인구'
  from country
  where population between 40000000 and 60000000;
  
  
  -----Q review_2;
  
use world;

show tables;

desc box_office;

select
    name as '국가명',
    case 
    when indepyear < 0 then replace(indepyear,'-', 'BC')
    else concat('AD',indepyear)
    end as 개국년도
    from country
    where indepyear is not null
    order by indepyear
    limit 10;

    -----Q review_3;
     SELECT 
     ROW_NUMBER() OVER (ORDER BY audience_num DESC) AS 'No.', 
     years AS '제작년도', 
     movie_name AS '영화제목', 
     DATE_FORMAT(release_date, '%Y-%b-%d') AS '개봉일',
	FORMAT(audience_num, 0) AS '관객수', 
    CONCAT((ROUND(sale_amt / 100000000, 0)), '억') AS '매출'
FROM box_office 
WHERE 
YEAR(release_date) = 2019
AND (audience_num BETWEEN 3000000 AND 7000000 OR ROUND(sale_amt / 100000000, 0) BETWEEN 180 AND 500)
ORDER BY audience_num DESC;

     -----Q review_4;
select 
    seq_no,
    years,
    ranks,
    movie_name,
    release_date,
    sale_amt,
    audience_num,
    screen_num,
    showing_count,
    rep_country,
    countries,
    distributor,
    genre,
    director
from box_office
where years = 2014
and YEAR(release_date) between 2018 and 2019;

-----Q review_5;

    select 
    movie_name as '영화',
    date_format(release_date, '%Y%c') as '개봉년월',
    replace(director, ',', '/')
from box_office
where
date_format(release_date, '%Y%c') = '201711'
and movie_name like '%:%'
and  replace(director, ',', '/') like '%/%';


-----Q review_6;
    desc box_office;
    
select
		years as '제작년도',
        movie_name as '영화명',
        countries as '배포국가',
		date_format(release_date, '%Y%c') as '개봉년월',
        audience_num as '관객수',
        concat((round(sale_amt/100000000)),'억원') as '매출'
        from box_office
        where 
        date_format(release_date, '%Y') between 2018 and 2019
        and countries in ('한국', '미국') 
        and audience_num>10000000;
        
-- Q5. 강사님
desc box_office;

SELECT
  distributor,
  -- release_date,
  -- YEAR(release_date) AS 연도,
  -- QUARTER(release_date) AS 분기,
	count(*) as 영화수,
	concat(format(round(sum(sale_amt)/pow(10,8)),0),'억') as "매출_2016",
  sum(CASE WHEN QUARTER(release_date) = 1 THEN 1 ELSE 0 END) AS Q1,
  sum(CASE WHEN QUARTER(release_date) = 2 THEN 1 ELSE 0 END) AS Q2,
  sum(CASE WHEN QUARTER(release_date) = 3 THEN 1 ELSE 0 END) AS Q3,
  sum(CASE WHEN QUARTER(release_date) = 4 THEN 1 ELSE 0 END) AS Q4
FROM box_office
WHERE YEAR(release_date) = 2016
  AND sale_amt >= 2 * POW(10, 8)
  group by distributor
 having sum(sale_amt)/pow(10,8) between 100 and 1500
 order by sum(sale_amt) desc;