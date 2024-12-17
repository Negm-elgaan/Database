CREATE DATABASE Moharm_Gmail;

USE Mohram_Gmail;

 -- Create User Table
CREATE TABLE User 
(
    User_ID INT PRIMARY KEY,
    Name VARCHAR(100),
    Email VARCHAR(100) UNIQUE,
    Password VARCHAR(100)
);

-- Create Mailbox Table
CREATE TABLE Mailbox 
(
    Mailbox_ID INT PRIMARY KEY,
    User_ID INT,
    FOREIGN KEY (User_ID) REFERENCES User(User_ID)
);

-- Create Email Table
CREATE TABLE Email 
(
    Email_ID INT PRIMARY KEY,
    Subject VARCHAR(200),
    Body TEXT,
    Timestamp TIMESTAMP,
    Sender_ID INT,
    Receiver_ID INT,
    Mailbox_ID INT,
    FOREIGN KEY (Sender_ID) REFERENCES User(User_ID),
    FOREIGN KEY (Receiver_ID) REFERENCES User(User_ID),
    FOREIGN KEY (Mailbox_ID) REFERENCES Mailbox(Mailbox_ID)
);

-- Insert data into User table
INSERT INTO User (User_ID, Name, Email, Password) VALUES
(1, 'John Doe', 'john.doe@example.com', 'password123'),
(2, 'Jane Smith', 'jane.smith@example.com', 'password456');

-- Insert data into Mailbox table
INSERT INTO Mailbox (Mailbox_ID, User_ID) VALUES
(1, 1),  -- John Doe's mailbox
(2, 2);  -- Jane Smith's mailbox

-- Insert data into Email table
INSERT INTO Email (Email_ID, Subject, Body, Timestamp, Sender_ID, Receiver_ID, Mailbox_ID) VALUES
(1, 'Hello John', 'Hi John, how are you?', '2024-12-16 10:00:00', 2, 1, 1),
(2, 'Meeting Reminder', 'Reminder about the meeting tomorrow.', '2024-12-16 11:00:00', 1, 2, 2);

SELECT 
	E.Email_ID, 
    E.Subject, 
    E.Body, 
    E.Timestamp, 
    U.Name AS Sender
FROM 
	Email E
INNER JOIN 
	User U 
ON 
	E.Sender_ID = U.User_ID
WHERE 
	U.Name = 'John Doe';

SELECT 
	E.Email_ID, 
	E.Subject, 
	E.Body, 
	E.Timestamp, 
    U.Name AS Sender
FROM 
	Email E
INNER JOIN 
	User U 
ON 
	E.Sender_ID = U.User_ID
WHERE 
	E.Receiver_ID = (SELECT User_ID FROM User WHERE Name = 'Jane Smith');
    
SELECT 
	E.Email_ID, 
    E.Subject, 
    E.Body, 
    E.Timestamp, 
    U.Name AS Sender
FROM 
	Email E
INNER JOIN 
	Mailbox M 
ON 
	E.Mailbox_ID = M.Mailbox_ID
INNER JOIN 
	User U 
ON 
	E.Sender_ID = U.User_ID
WHERE 
	M.User_ID = (SELECT User_ID FROM User WHERE Name = 'John Doe');

SELECT 
	* 
FROM 
	Mailbox
WHERE 
	User_ID = (SELECT User_ID FROM User WHERE Name = 'John Doe');
