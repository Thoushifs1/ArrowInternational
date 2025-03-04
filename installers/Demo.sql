CREATE TABLE users (
    user_id INT PRIMARY KEY,
    username VARCHAR(50) UNIQUE,
    password_hash VARCHAR(255),
    email VARCHAR(100) UNIQUE,
    role VARCHAR(20) CHECK (role IN ('Admin', 'User', 'Manager'))
);
