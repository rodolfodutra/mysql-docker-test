-- user: root
-- db: test
-- PORT: 3306

-- @block
CREATE TABLE Users(
    id INT PRIMARY KEY AUTO_INCREMENT, 
    email VARCHAR(255) NOT NULL UNIQUE, 
    bio TEXT, 
    country VARCHAR(2)
);

-- @block 
INSERT INTO Users (email, bio, country)
VALUES
    ('ola@mundo.pt', 'foo', 'PT'),
    ('hello@world.com', 'bar', 'UK'),
    ('hallo@welt.de', 'baz', 'DE');

-- @block 
SELECT * FROM Users

WHERE country = "PT"
OR email LIKE '%de'

ORDER BY id ASC
LIMIT 4;

-- @block
CREATE INDEX email_index ON Users(email);

-- @block
CREATE TABLE Rooms(
    id INT AUTO_INCREMENT, 
    street VARCHAR(255),
    owner_id INT NOT NULL, 
    PRIMARY KEY (id), 
    FOREIGN KEY (owner_id) REFERENCES Users(id)
);

-- @block 
INSERT INTO Rooms (owner_id, street)
VALUES
    (1, 'alameda d.afonso'), 
    (1, 'praca do chile'), 
    (1, 'mouraria'),
    (1, 'campo de ourique');

-- @block 
SELECT 
    Users.id AS user_id,
    Rooms.id AS room_id,
    email,
    street
FROM Users
RIGHT JOIN Rooms ON Rooms.owner_id = Users.id;

-- @block
CREATE TABLE Bookings(
    id INT AUTO_INCREMENT, 
    guest_id INT NOT NULL,
    room_id INT NOT NULL, 
    PRIMARY KEY (id), 
    FOREIGN KEY (guest_id) REFERENCES Users(id),
    FOREIGN KEY (room_id) REFERENCES Rooms(id)
);

-- @block 
INSERT INTO Bookings (guest_id, room_id)
VALUES
    (2, 1), 
    (2, 2), 
    (3, 1)

-- @block 
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
    
