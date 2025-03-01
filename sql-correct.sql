SELECT
    u.id,
    u.name,
    u.age,
    o.order_id,
    o.order_date
FROM users AS u
LEFT JOIN orders AS o
    ON u.id = o.user_id
WHERE u.age > 18
ORDER BY u.name;
