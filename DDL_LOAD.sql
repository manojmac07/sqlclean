/*SELECT aws_commons.create_s3_uri(
   'yarapoc',
   'samples/sample.csv',
   'ap-south-1'
) AS s3_uri



SELECT aws_commons.create_aws_credentials(
   '',
   '',
   ''
) AS credentials
*/


create table public.user_details(
address varchar,
latitude decimal,
longitude decimal,
tag varchar(100),
location_id int,
user_id int
)
address	latitude	longitude	tag	location_id	user_id

--drop table public.user_details; commit;
create table public.city(
city varchar(100),
	city_ascii	varchar(100),
	lat	decimal,
	lng	decimal,
	country	varchar(200),
	iso2 varchar(30),
	iso3 varchar(30),
	admin_name varchar(100),
	capital varchar(100),
	population	int,
	id int)
	
	
SELECT aws_s3.table_import_from_s3(
   'public.demo',
   'id',
   '(FORMAT CSV, DELIMITER '','', HEADER true)',
   'yarapoc',
   'sample/sample.csv',
   'ap-south-1',
   '',
   '',
   '')
   
   select * from public.demo;
   
--  s3://yarapoc/world_info/world_cities.csv.gz
  SELECT aws_s3.table_import_from_s3(
   'public.city',
   '',
   '(FORMAT CSV, DELIMITER '','', HEADER true)',
   'yarapoc',
   'world_info/cities.csv',
   'ap-south-1',
   '',
   '',
   '')
   
   select count(*) from public.city;
  
  --s3://yarapoc/user_details/user_location.csv.gz
  
  SELECT aws_s3.table_import_from_s3(
   'public.user_details',
   '',
   '(FORMAT CSV, DELIMITER '','', HEADER true)',
   'yarapoc',
   'user_details/clean_data.csv',
   'ap-south-1',
   '',
   '',
   '')

/* 
* Task 1 QUeries
*/

--Distance from current place or bangalore
select c.*, SQRT(POW(69.1 * (12::float -  c.lat ::float), 2) + 
    POW(69.1 * (79::float - c.lng ::float) * COS(12::float / 57.3), 2)
) as distance from public.city as c

select * from (
SELECT  *,( 3959 * acos( cos( radians(6.414478) ) * cos( radians( lat ) ) * cos( radians( lng ) - radians(12.466646) ) + sin( radians(6.414478) ) * sin( radians( lat ) ) ) ) AS distance 
FROM public.city
) al
where distance <2000
ORDER BY distance
LIMIT 20;


-- All users 

with city_table as (
select * from (
SELECT  *,( 3959 * acos( cos( radians(6.414478) ) * cos( radians( lat ) ) * cos( radians( lng ) - radians(12.466646) ) + sin( radians(6.414478) ) * sin( radians( lat ) ) ) ) AS distance 
FROM public.city
)a1),
user_table as(
select * from (
SELECT  *,( 3959 * acos( cos( radians(6.414478) ) * cos( radians( ud.latitude ) ) * cos( radians( ud.longitude ) - radians(12.466646) ) + sin( radians(6.414478) ) * sin( radians( ud.latitude ) ) ) ) AS distance 
FROM public.user_details ud 
) b1)
select ct.*,ut.* from city_table ct join user_table ut on  ct.distance::int = ut.distance::int;


/*
* Task 2 to build the histogram
*/
-- To build the range from 0 to 35
SELECT (five*5)::text||'-'||(five*5+5)::text AS Distance,
           five*5 AS r_min, five*5+5 AS r_max
      FROM generate_series(0,6) AS t(five)
      
    


  
  
   
