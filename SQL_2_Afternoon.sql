-- GitHub Repository Located Here
-- https://github.com/AndersonChristian-P/sql-2-afternoon


--Practice Joins--
-- 1.
SELECT *
FROM invoice_line
WHERE unit_price > 0.99;

-- 2.
SELECT c.first_name, c.last_name, i.invoice_date, i.total
FROM customer c
  JOIN invoice i
  ON c.customer_id = i.customer_id;

-- 3.
SELECT c.first_name, c.last_name, sr.first_name, sr.last_name
FROM customer c
  JOIN employee sr
  ON c.support_rep_id = sr.employee_id

-- 4.
SELECT a.title, ar.name
FROM album a
  JOIN artist ar
  on a.artist_id = ar.artist_id;

-- 5.
SELECT pt.track_id
FROM playlist_track pt
  JOIN playlist pl
  ON pt.playlist_id = pl.playlist_id
WHERE pl.name = 'Music';

-- 6.
SELECT t.name
FROM track t
  JOIN playlist_track pt
  ON t.track_id = pt.track_id
WHERE pt.playlist_id = 5;

-- 7.
SELECT t.name, pl.name
FROM playlist pl
  JOIN playlist_track pt ON pl.playlist_id = pt.playlist_id
  JOIN track t ON pt.track_id = t.track_id;

-- 8.
SELECT t.name, a.title
FROM genre g
  JOIN track t ON g.genre_id = t.genre_id
  JOIN album a ON t.album_id = a.album_id
WHERE g.name = 'Alternative & Punk';


-- Black Diamond


--Practice Nested Queries--
-- 1. 
SELECT *
FROM invoice
WHERE invoice_id IN (
	SELECT invoice_id
FROM invoice_line
WHERE unit_price > 0.99
)

-- 2.
SELECT *
FROM playlist_track
WHERE playlist_id IN (
	SELECT playlist_id
FROM playlist
WHERE name = 'Music'
);

-- 3.
SELECT name
FROM track
WHERE track_id IN (
	SELECT track_id
FROM playlist_track
WHERE playlist_id = 5
)

-- 4.
SELECT *
FROM track
WHERE genre_id IN (
	SELECT genere_id
FROM genre
WHERE name = 'Comedy'
);

-- 5.
SELECT *
FROM track
WHERE album_id IN (
	SELECT album_id
FROM album
WHERE title = 'Fireball'
);

-- 6.
SELECT *
FROM track
WHERE album_id IN (
	SELECT album_id
FROM album
WHERE artist_id IN (
  	SELECT artist_id
FROM artist
WHERE name = 'Queen'
  )
);

--Practice Updating Rows--
-- 1.
UPDATE customer
SET fax = null;

-- 2.
UPDATE customer
SET company = 'Self'
WHERE company IS null;
-- when referencing null use 'IS'

-- 3.
UPDATE customer
SET last_name = 'Tompson'
WHERE last_name = 'Barnett' AND first_name = 'Julia';

-- 4.
UPDATE customer
SET support_rep_id = 4
WHERE email = 'luisrojas@yahoo.cl';

-- 5.
UPDATE track
SET composer = 'The darkness around us'
WHERE genre_id IN (
	SELECT genre_id
  FROM genre
  WHERE name = 'Metal'
) AND composer IS null;

--Group By--
-- 1.
SELECT COUNT(*), g.name
FROM track t
  JOIN genre g ON t.genre_id = g.genre_id
GROUP BY g.name;

-- 2.
SELECT COUNT(*), g.name
FROM track t
  JOIN genre g ON t.genre_id = g.genre_id
WHERE g.name IN ('Pop', 'Rock')
GROUP BY g.name

-- 3.
SELECT COUNT(*), a.name
FROM artist a
  JOIN album al on a.artist_id = al.artist_id
GROUP BY a.name;

--Use Distinct--
-- 1.
SELECT DISTINCT composer
FROM track;

-- 2.
SELECT DISTINCT billing_postal_code
FROM invoice;

-- 3.
SELECT DISTINCT company
FROM customer;

--Delete--
-- 2.
SELECT *
FROM practice_delete
WHERE type = 'bronze';

DELETE
FROM practice_delete
WHERE type = 'bronze';

-- always do a select before a delete to make sure you get back exactly what you want and only want to delete

-- 3.
SELECT *
FROM practice_delete
WHERE type = 'silver';

DELETE
FROM practice_delete
WHERE type = 'silver';

-- 4.
SELECT *
FROM practice_delete
WHERE value = 150;

DELETE
FROM practice_delete
WHERE value = 150;


--eCommerce Simulation--

-- Create 3 tables
CREATE TABLE users
(
  user_id SERIAL PRIMARY KEY,
  name VARCHAR(50),
  email TEXT
);

CREATE TABLE product
(
  product_id SERIAL PRIMARY KEY,
  name VARCHAR(50),
  price DECIMAL
);

CREATE TABLE orders
(
  order_id SERIAL PRIMARY KEY,
  customer_id INT,
  product_id INT REFERENCES product
);

-- Create dummy data
INSERT INTO users
  (
  name,
  email
  )
VALUES
  (
    'Christian',
    'CA@gmail.com'
),
  (
    'Eric',
    'EC@gmail.com'
),
  (
    'Jason',
    'JH@mail.com'
);

INSERT INTO product
  (
  name,
  price
  )
VALUES
  (
    'shoes',
    10
),
  (
    'socks',
    9
),
  (
    'pant',
    26
);

INSERT INTO orders
  (
  customer_id,
  product_id
  )
VALUES
  (
    1,
    1
),
  (
    2,
    2
),
  (
    3,
    3
);





-- get the total cost of an order - order 1
SELECT SUM(price)
FROM product p
  JOIN orders o
  ON p.product_id = o.product_id
WHERE order_id = 1;

-- add a foreign key reference from orders to users
-- update the orders table to link a user to each order

ALTER TABLE orders
ADD FOREIGN KEY (product_id)
REFERENCES users;




-- SELECT a.title FROM album a
-- WHERE a.album_id IN (
--   SELECT tr.album_id
--   FROM invoice_line il
--   JOIN track tr
--   on il.track_id = tr.track_id
--   GROUP BY tr.album_id
--   HAVING sum(il.unit_price * il.quantity) > 20
-- )

-- DELETE *
-- FROM customer
-- WHERE fax is null;

-- SELECT *
-- FROM customer
-- WHERE fax is null;
