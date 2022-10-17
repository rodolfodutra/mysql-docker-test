/*
Initialization script to bootstrap a test database. 
It includes users, rooms and bookings, with relations
between them.
*/

-- create root password to access the db with SQL tools
ALTER USER 'root' IDENTIFIED WITH mysql_native_password BY 'password';

CREATE DATABASE test;
USE test;

-- Create Users table and add dummy values
CREATE TABLE Users(
    id INT PRIMARY KEY AUTO_INCREMENT, 
    email VARCHAR(255) NOT NULL UNIQUE, 
    bio TEXT, 
    country VARCHAR(2)
);

INSERT INTO Users (email, bio, country)
VALUES
    ('ola@mundo.pt', 'foo', 'PT'),
    ('hello@world.com', 'bar', 'UK'),
    ('hallo@welt.de', 'baz', 'DE');

-- Create Rooms table and add dummy values
CREATE TABLE Rooms(
    id INT AUTO_INCREMENT, 
    street VARCHAR(255),
    owner_id INT NOT NULL, 
    PRIMARY KEY (id), 
    FOREIGN KEY (owner_id) REFERENCES Users(id)
);

INSERT INTO Rooms (owner_id, street)
VALUES
    (1, 'alameda d.afonso'), 
    (1, 'praca do chile'), 
    (1, 'mouraria'),
    (1, 'campo de ourique');

-- Create Bookings table and add dummy values
CREATE TABLE Bookings(
    id INT AUTO_INCREMENT, 
    guest_id INT NOT NULL,
    room_id INT NOT NULL, 
    PRIMARY KEY (id), 
    FOREIGN KEY (guest_id) REFERENCES Users(id),
    FOREIGN KEY (room_id) REFERENCES Rooms(id)
);

INSERT INTO Bookings (guest_id, room_id)
VALUES
    (2, 1), 
    (2, 2), 
    (3, 1)