-- creating a database
CREATE DATABASE test;

-- connecting to a database
\c test

-- Dangerous command,will delete the database
DROP DATABASE test,DROP TABLE table_name;

-- creating a table without constraints
 CREATE TABLE person(
    id int,
    first_name text,
    last_name text,
    gender text,
    date_of_birth DATE);

-- to see the table 
\d 
-- to see the details
\d person

-- creating a table with constraints
 CREATE TABLE person(
    -- BIGSERIAL is an autoincrement integer
    id BIGSERIAL NOT NULL PRIMARY KEY,
    first_name text NOT NULL,
    last_name text NOT NULL,
    gender text NOT NULL,
    date_of_birth DATE NOT NULL,
    email text);

-- inserting data into table
-- USE SINGLE QUOTES WHEN INSERTING VALUES
INSERT INTO person(first_name,last_name,gender,date_of_birth,email)
 VALUES('mythic','Jain','male',date '2005-03-28','mythichuman28@gmail.com');

-- if you want to execute file in psql shell
-- before even opening your postgres ,navigate through the command line where the actual file is located and then open postgres and use   \i filename.extension   to execute your file.
\i filepath

-- https://www.mockaroo.com/A website for mock data

-- how to see all data in a table
SELECT * FROM person;

--to see certain column from a table
SELECT column_name1,column_name2 FROM table_name;

-- how to get sorted data by order by keyword //default is ascendeing
SELECT * FROM table_name ORDER BY column_name;

-- how to get sorted data by order by keyword //Descending
SELECT * FROM table_name ORDER BY column_name DESC;

-- Distinct keyword ,only one
SELECT DISTINCT column_name FROM table_name ORDER BY column_name;

-- WHERE Clause ,it filters data by giving conditions
SELECT * FROM person WHERE gender='male';

-- WHERE Clause ,it filters data by giving conditions also using AND ,OR KEYWORD
SELECT * FROM person WHERE gender='Male' AND (country_of_birth='Brazil' OR country_of_birth='China');

-- conditional operators in sql are <,>,=,<=,>=,<>--THIS IS NOT OPEARATOR IN SQL

-- //LIMIT KEYWORDS LIMITS THE NO OF ROWS
SELECT * FROM person LIMIT 20;

-- //OFFSET KEYWORDS SKIPS THE GIVEN NUMBER OF ROWS
SELECT * FROM person OFFSET 10 LIMIT 20;---------------------|
--                                                           |-------->>>BOTH GIVES THE SAME RESULT   
-- //BY USING FETCH KEYWORD                                  |           
SELECT * FROM person OFFSET 10 FETCH FIRST 20 ROW ONLY;------| 

-- //In keyword
 SELECT * FROM person WHERE country_of_birth IN('Brazil','China','Afghanistan')----------------------------------------|
  --                                                                                                                   | ----->>>BOTH GIVES THE SAME RESULT
 SELECT * FROM person WHERE country_of_birth='Brazil' OR country_of_birth='China' OR country_of_birth='Afghanistan';---|

--  //BETWEEN KEYWORD ,gives data between the given ranges
SELECT * FROM person WHERE date_of_birth BETWEEN DATE '2024-06-01' AND '2024-07-01';//GIVES the result in these given dates

-- //LIKE AND ILIKE OPEARATOR
SELECT * FROM person WHERE email LIKE '%.com';
SELECT * FROM person WHERE email LIKE '%google.%';
-- //this command gives all emails which have '.com' in it 
SELECT * FROM person WHERE email LIKE '________@%';
-- this gives all data which have 8 starting letters untils @
SELECT * FROM person WHERE country_of_birth LIKE 'P%';

-- //LIKE OPEARATOR IS CASE SENSETIVE
-- //this will give all countries which is starting from p 
SELECT * FROM person WHERE country_of_birth LIKE 'P%';

-- USE ILIKE OPEARATOR to IGNORE THE CASE SENSITIVITY //IMPORTANT 
SELECT * FROM person WHERE country_of_birth ILIKE 'p%';

-- //GROUP BY KEYWORD
SELECT country_of_birth,COUNT(*) FROM person GROUP BY country_of_birth ORDER BY country_of_birth;
-- //this will give the count of person from each country,COUNT() is a function

-- //GROUP BY HABING KEYWORD
SELECT country_of_birth,COUNT(*) FROM person GROUP BY country_of_birth HAVING COUNT(*) >5 GROUP BY country_of_birth;
-- //this will give the count of person by each country but should have greater than 5 person in each country

-- //how to find a max , min,average,round,sum value
SELECT MAX(price) FROM car;
SELECT MIN(price) FROM car;
SELECT AVG(price) FROM car;
-- //Suppose we need to round the average value
SELECT ROUND(AVG(price)) FROM car;

-- //if we have to find highest price car and lowest price car from a company(make)
SELECT make,MAX(price) FROM car GROUP BY make;
SELECT make,MIN(price) FROM car GROUP BY make;

-- //this statement gives the list of data in ascending order

-- //IMPORTANT NOTE
-- if you want to use ORDER BY you have to first specify in GROUP BY if you are using it 
SELECT make,MIN(price) FROM car GROUP BY make,price ORDER BY price ASC;

-- //sum
SELECT SUM(price) FROM car;

-- //this statement will give sum by each company(MAKE)
SELECT make,SUM(price) FROM car GROUP BY make;

-- //IMPORTANT RULE FOR MODULUS OPEARATOR LEARNED
10%2=0
10%3=1
10&6=4
10%8=2
10%9=1
10%10=0
10%11=10
-- //if RHS>LHS ==>ANSWER=>LHS
10%321312=10
878%9898790=878

-- //if you want to have 15% discounted price on every car;
 SELECT *,ROUND((price-(price/100)*15)) FROM car GROUP BY make,id ;
--  //If you are using * this in SELECT you have to add id in GROUP BY 

-- //if you want to overwrite an column name 
SELECT *,ROUND((price/100)*15,1) AS fifteen_percent,
ROUND((price-(price/100)*15),1) AS discounted_price FROM car GROUP BY make,id ;

-- //coalesce keyword
SELECT COALESCE(null,1);
-- //this statement defines that if first value is null do it 1 
SELECT COALESCE(email,"EMAIL NOT PROVIDED") FROM person;
-- //this will give "EMAIL NOT PROVIDED" TO NULL VALUES IN EMAIL COLUMN

-- //null if keyword
SELECT NULLIF(10,2)==>IT IS NOT NULL =>ANSWER 10
SELECT NULLIF(10,10)==>IT IS NULL =>ANSWER NULL

-- //if someone did 10/0
SELECT COALESCE(10/NULLIF(0,0),0);

-- //TIMESTAMPS AND DATE
SELECT NOW();
-- //will give current date and time
SELECT NOW()::DATE;
-- //this will only give current data
SELECT NOW()::TIME;
-- //this will only give current time
SELECT NOW()-INTERVAL '10 YEAR';
-- this will reduce 10 year from curent time,YOU CAN WRITE MONTHS,WEEKS,DAYS,MINUTES,SECONDS
SELECT (NOW()-INTERVAL '10 YEAR')::DATE;
-- //WILL ONLY GIVE DATE

-- //EXTRACTING COLUMNS 
SELECT EXTRACT(YEAR FROM (NOW()+INTERVAL '10 YEARS')::DATE);

-- //AGE FUNCTION ,takes 2 arguments AGE(NOW(),data_provided)
SELECT * ,AGE(NOW(),date_of_birth) FROM person;

-- //primary key
-- //WHAT IS PRIMARY KEY ==>IT IS A UNIQUE RECORD IN A TABLE AND PRIMARY KEY CAN ONLY BE 1 in a given table

-- //how to drop primary key constraint from a table
ALTER TABLE person DROP CONSTRAINT person_pkey;

-- /adding primary key constraint,primary key column should be unique
ALTER TABLE person add PRIMAY KEY (id);

-- //HOW TO DELETE A ROW IN A COLUMN
DELETE FROM person WHERE given_column_name=given_value;

-- //UNIQUE CONSTRAINT
-- This constraint can be applicable where we have to have unique values like email
ALTER TABLE person ADD CONSTRAINT unique_email_address UNIQUE(email);
ALTER TABLE person ADD UNIQUE(email);
-- //postgres will automatically will name this


-- //to delete this constraint
ALTER TABLE person DROP CONSTRAINT unique_email_address;

-- //Suppose we had to have a condition that gender can only be MALE or Female
-- //IN SQL THE COMPARISON OPEARTOR IS =
ALTER TABLE person ADD CONSTRAINT gender_constraint CHECK(gender='Male' OR gender='Female');

-- //HOW TO DELETE RECORDS
DELETE FROM person WHERE column_name=value;
-- FOR EX:-
DELETE FROM person WHERE id=7;

-- //HOW TO UPDATE RECORDS
UPDATE person SET email='mythichuman28@gmail.com' WHERE id=2;

-- //How to update multiple feilds
UPDATE person SET email='sanchitjain282930@gmail.com', first_name='sanchit',last_name='jain',gender='Male',date_of_birth='2005-03-28',country_of_birth='India' WHERE id=28;
-- //ON CONFLICT DO NOTHING,Try and catch block for SQL
-- //to use ON CONFLICT the column should be unique
INSERT INTO person(id,first_name,last_name,email,gender,date_of_birth,country_of_birth) 
VALUES(28,'sanchit','jain','sanchitjain00028@gmail.com','Male','2005-03-28','India')
ON CONFLICT(id) DO NOTHING;
-- //This will not thrown an error
-- //the output will be INSERT 0 0

-- //UPSERT ,this helps when you have to take action instead ON CONFLICT instead of doing nothing
INSERT INTO person(id,first_name,last_name,email,gender,date_of_birth,country_of_birth) 
VALUES(28,'sanchit','jain','sanchitjain00028@gmail.com','Male','2005-03-28','India')
ON CONFLICT(id) DO UPDATE SET email=EXCLUDED.email;
-- //this statement will replace the old emaiul id with the new email id
-- //for mutiple feilds
INSERT INTO person(id,first_name,last_name,email,gender,date_of_birth,country_of_birth) 
VALUES(28,'sanchit','jain','sanchitjain00028@gmail.com','Male','2005-03-28','India')
ON CONFLICT(id) DO UPDATE SET email=EXCLUDED.email,first_name=EXCLUDED.first_name,last_name=EXCLUDED.last_name;

-- //FOREIGN KEY,CONNECTING TWO TABLES;
-- //ADDING RELATIONSJIP BETWEEN CAR AND PERSON
 UPDATE person SET car_id=2 WHERE id=1;
--  //this sets a relationship between 2 tables

-- //INNER JOINS,COMBINING TWO TABLES
SELECT * FROM person JOIN car ON person.car_id=car.id;
-- //this gives common data from both tables

-- //SELECTING SPECIFIC COLUMNS
SELECT person.first_name,person.gender,car.make,car.model,car.price FROM person JOIN car on person.car_id=car.id;

-- //LEFT JOINS
-- //THIS GIVES ALL DATA FROM LEFT TABLE ,WHICH MEANS IF YOU HAVE NO DATA IN @ND TABLE FOR THAT ROW,IT WILL STILL GIVE
SELECT * FROM person LEFT JOIN car ON person.car_id=car.id;

-- if you want to check NULL values use is keyword
-- FOR EX:-
SELECT * FROM person WHERE car_id is NULL; => ✔✔✔
SELECT * FROM person LEFT JOIN car ON person.car_id=car.id  WHERE car.* is NULL;=> ✔✔✔

-- //THIS IS WRONG
SELECT * FROM person WHERE car_id=NULL; => XXX

-- //BUT FOR UPDATING WE CAN DO
UPDATE person SET car_id=NULL WHERE id=1;

-- // "*" this means ALL
-- //IF YOU WANT TO DELETE RECORDS WITH FORIGH KEYS ==>You directly cannot do it//YOU HAVE TO REMOVE THE FOREIGN KEY
--  CONSTRAINT FROM THAT ROW
-- 2 Options)
-- 1)MAKE the foreign key null in that row ,then delete the row from foreign table
-- 2)OR delete that row,Now you can delete from foreign table

-- //how to export sql data to csv
-- \copy command 

--  Serial & Sequences in sql
-- BIGSERIAL IS AN AUTOINCREMENT ,It is just a BIGINT With a sequence
SELECT nextval('person_id_seq'::regclass);
-- //if you run this command the number will increment

-- //how to change value of a sequence
ALTER SEQUENCE person_id_seq RESTART WITH 28;

-- //UUIDs ==> Universally unique identifiers(UUIDs)==>BEST FOR PRIMARY KEYs.

-- //how to create extension
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- //How to see functions
\df

-- //how to implement a fuction
SELECT uuid_generate_v4();==>
-- THIS IS FUNCTION NAME

SELECT * FROM person LEFT JOIN car ON person.car_uid=car.car_uid;
-- //if both have same column name
SELECT * FROM person LEFT JOIN car USING(car_uid);