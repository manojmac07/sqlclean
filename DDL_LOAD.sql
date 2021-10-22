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

  
  
   