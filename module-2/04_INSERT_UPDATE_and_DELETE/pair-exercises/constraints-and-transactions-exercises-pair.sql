-- Write queries to return the following:
-- Make the following changes in the "world" database.

-- 1. Add Superman's hometown, Smallville, Kansas to the city table. The 
-- countrycode is 'USA', and population of 45001. (Yes, I looked it up on 
-- Wikipedia.)

BEGIN TRANSACTION;
INSERT INTO city (name, countrycode, district, population)
VALUES ('Smallville', 'USA', 'Kansas', 45001);
COMMIT;
ROLLBACK;

SELECT *
FROM city
WHERE countrycode ILIKE 'usa'
  AND district = 'Kansas';

-- 2. Add Kryptonese to the countrylanguage table. Kryptonese is spoken by 0.0001
-- percentage of the 'USA' population.

BEGIN TRANSACTION;
INSERT INTO countrylanguage (countrycode, language, isofficial, percentage)
VALUES ('USA', 'Kryptonese', FALSE, .0001);
COMMIT;
ROLLBACK;

SELECT *
FROM countrylanguage
WHERE language ILIKE '%krypto%';

-- 3. After heated debate, "Kryptonese" was renamed to "Krypto-babble", change 
-- the appropriate record accordingly.

BEGIN TRANSACTION;
UPDATE countrylanguage
SET language = 'Krypto-babble'
WHERE language = 'Kryptonese';
COMMIT;
ROLLBACK;

SELECT *
FROM countrylanguage
WHERE language ILIKE '%krypto%';

-- 4. Set the US captial to Smallville, Kansas in the country table.

--Smallville ID 4080
BEGIN TRANSACTION;
UPDATE country
SET capital = 4080
WHERE code = 'USA';
COMMIT;
ROLLBACK;

SELECT *
FROM country
WHERE code ILIKE 'usa';

-- 5. Delete Smallville, Kansas from the city table. (Did it succeed? Why?)
-- Did not succeed.
--[23503] ERROR: update or delete on table "city" violates foreign key constraint
-- "country_capital_fkey" on table "country" Detail: Key (id)=(4080)
-- is still referenced from table "country

BEGIN TRANSACTION;
DELETE
FROM city
WHERE name ILIKE 'smallville';
COMMIT;
ROLLBACK;

-- 6. Return the US captial to Washington.

BEGIN TRANSACTION;
UPDATE country
SET capital = 3813
WHERE code = 'USA';
COMMIT;
ROLLBACK;

SELECT capital
FROM country
WHERE code ILIKE '%usa%';

-- 7. Delete Smallville, Kansas from the city table. (Did it succeed? Why?)
-- Yes it succeeded.  Because it was not being used elsewhere as a dependent.

BEGIN TRANSACTION;
DELETE
FROM city
WHERE name ILIKE 'smallville';
COMMIT;
ROLLBACK;



-- 8. Reverse the "is the official language" setting for all languages where the
-- country's year of independence is within the range of 1800 and 1972 
-- (exclusive). 
-- (590 rows affected)

BEGIN TRANSACTION;
UPDATE isoffical
from countrylanguage
SET isofficial = FALSE
WHERE indepyear FROM country WHERE indepyear <= 1972 AND indepyear >= 1800
RETURNING *;
COMMIT;
ROLLBACK;

select *
from countrylanguage
join country c ON countrylanguage.countrycode = c.code
where isofficial = TRUE and indepyear >= 1800 and indepyear <= 1972;


-- 9. Convert population so it is expressed in 1,000s for all cities. (Round to
-- the nearest integer value greater than 0.)
-- (4079 rows affected)



-- 10. Assuming a country's surfacearea is expressed in square miles, convert it to 
-- square meters for all countries where French is spoken by more than 20% of the 
-- population.
-- (7 rows affected)
