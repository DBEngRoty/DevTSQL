--Generate a unique ID with no order
-- Random function RAND() does not generate a random ID just one number for all rows
-- NEWID() can generate a new unique ID for each row in select statement

SELECT NEWID() Random_ID

