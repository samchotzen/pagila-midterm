/*
 * You want to watch a movie tonight.
 * But you're superstitious,
 * and don't want anything to do with the letter 'F'.
 *
 * Write a SQL query that lists the titles of all movies that:
 * 1) do not have the letter 'F' in their title,
 * 2) have no actors with the letter 'F' in their names (first or last),
 * 3) have never been rented by a customer with the letter 'F' in their names (first or last).
 * 4) have never been rented by anyone with an 'F' in their address (at the street, city, or country level).
 *
 * NOTE:
 * Your results should not contain any duplicate titles.
 */

SELECT DISTINCT title
FROM film
WHERE title NOT ILIKE '%F%'
AND film_id NOT IN (
    SELECT film_id
    FROM actor
    JOIN film_actor USING (actor_id)
    WHERE first_name ILIKE '%F%' OR last_name ILIKE '%F%'
)
AND film_id NOT IN (
    SELECT film_id
    FROM inventory
    JOIN rental USING (inventory_id)
    JOIN customer USING (customer_id)
    WHERE first_name ILIKE '%F%' OR last_name ILIKE '%F%'
)
AND film_id NOT IN (
    SELECT film_id
    FROM inventory
    JOIN rental USING (inventory_id)
    JOIN customer USING (customer_id)
    JOIN address USING (address_id)
    JOIN city USING (city_id)
    JOIN country USING (country_id)
    WHERE address ILIKE '%F%' OR address2 ILIKE '%F%' OR city ILIKE '%F%' OR country ILIKE '%F%'
)
ORDER BY title ASC;
