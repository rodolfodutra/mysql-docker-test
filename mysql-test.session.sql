-- user: root
-- db: test
-- PORT: 3306

-- @block Create Users table
CREATE TABLE Users(
    id INT PRIMARY KEY AUTO_INCREMENT, 
    email VARCHAR(255) NOT NULL UNIQUE, 
    bio TEXT, 
    country VARCHAR(2)
);

-- @block Populate Users table
INSERT INTO Users (email, bio, country)
VALUES
    ('ola@mundo.pt', 'foo', 'PT'),
    ('hello@world.com', 'bar', 'UK'),
    ('hallo@welt.de', 'baz', 'DE');

-- @block Show up to 4 portuguese users
SELECT * FROM Users

WHERE country = "PT"
OR email LIKE '%pt'

ORDER BY id ASC
LIMIT 4;

-- @block Create Rooms table
CREATE TABLE Rooms(
    id INT AUTO_INCREMENT, 
    street VARCHAR(255),
    owner_id INT NOT NULL, 
    PRIMARY KEY (id), 
    FOREIGN KEY (owner_id) REFERENCES Users(id)
);

-- @block Populate Rooms table
INSERT INTO Rooms (owner_id, street)
VALUES
    (1, 'alameda d.afonso'), 
    (1, 'praca do chile'), 
    (1, 'mouraria'),
    (1, 'campo de ourique');

-- @block Show all users that own rooms
SELECT 
    Users.id AS user_id,
    Rooms.id AS room_id,
    email,
    street
FROM Users
INNER JOIN Rooms ON Rooms.owner_id = Users.id;

-- @block Create Bookings table
CREATE TABLE Bookings(
    id INT AUTO_INCREMENT, 
    guest_id INT NOT NULL,
    room_id INT NOT NULL, 
    PRIMARY KEY (id), 
    FOREIGN KEY (guest_id) REFERENCES Users(id),
    FOREIGN KEY (room_id) REFERENCES Rooms(id)
);

-- @block Populate Bookings table
INSERT INTO Bookings (guest_id, room_id)
VALUES
    (2, 1), 
    (2, 2), 
    (3, 1)

-- @block Delete Bookings table
DROP TABLE Bookings;

-- @block Rooms a user has booked
SELECT 
    Rooms.id AS rooms_id,
    street,
    guest_id
FROM Rooms
INNER JOIN Bookings ON Bookings.room_id = Rooms.id
WHERE guest_id = 2;

-- @block Guests who stayed in a room 
SELECT 
    room_id,
    street,
    guest_id
FROM Bookings
INNER JOIN Rooms ON Rooms.id = room_id
where room_id = 1;
    
