-- Drop the database if it exists and then create it
DROP DATABASE IF EXISTS MusicReviewApp;
CREATE DATABASE MusicReviewApp;
USE MusicReviewApp;

-- Create the tables

CREATE TABLE UserLevels (
    level_id INT AUTO_INCREMENT PRIMARY KEY,
    level_name VARCHAR(50) NOT NULL
);

CREATE TABLE Users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    user_level_id INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_level_id) REFERENCES UserLevels(level_id)
);

CREATE TABLE MusicItems (
    music_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    filename VARCHAR(255) NOT NULL,
    filesize INT NOT NULL,
    media_type VARCHAR(255) NOT NULL,
    title VARCHAR(255) NOT NULL,
    description VARCHAR(255),
    is_album BOOLEAN NOT NULL,
    genre VARCHAR(50) NOT NULL,
    artist_name VARCHAR(100) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

CREATE TABLE Comments (
    comment_id INT AUTO_INCREMENT PRIMARY KEY,
    music_id INT NOT NULL,
    user_id INT NOT NULL,
    comment_text TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (music_id) REFERENCES MusicItems(music_id),
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

CREATE TABLE Likes (
    like_id INT AUTO_INCREMENT PRIMARY KEY,
    music_id INT NOT NULL,
    user_id INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (music_id) REFERENCES MusicItems(music_id),
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

CREATE TABLE Ratings (
    rating_id INT AUTO_INCREMENT PRIMARY KEY,
    music_id INT NOT NULL,
    user_id INT NOT NULL,
    rating_value INT NOT NULL CHECK (rating_value BETWEEN 1 AND 5),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (music_id) REFERENCES MusicItems(music_id),
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

CREATE TABLE Tags (
    tag_id INT AUTO_INCREMENT PRIMARY KEY,
    tag_name VARCHAR(50) NOT NULL
);

CREATE TABLE MusicItemTags (
    music_id INT NOT NULL,
    tag_id INT NOT NULL,
    PRIMARY KEY (music_id, tag_id),
    FOREIGN KEY (music_id) REFERENCES MusicItems(music_id),
    FOREIGN KEY (tag_id) REFERENCES Tags(tag_id)
);

-- Insert the sample data

INSERT INTO UserLevels (level_name) VALUES ('Admin'), ('User'), ('Banned');

INSERT INTO Users (username, password, email, user_level_id) VALUES
('AliceMusicLover', 'alicepwd', 'alice@example.com', 2),
('BobMelodyMaster', 'bobpwd', 'bob@example.com', 2),
('CharlieListener', 'charliepwd', 'charlie@example.com', 2),
('AdminUser', 'adminpwd', 'admin@example.com', 1);

INSERT INTO MusicItems (user_id, filename, filesize, media_type, title, description, is_album, genre, artist_name) VALUES
(1, 'classical_album.mp3', 10240, 'audio/mp3', 'Classical Harmony', 'A collection of classical masterpieces', TRUE, 'Classical', 'Various Artists'),
(2, 'pop_single.mp3', 20480, 'audio/mp3', 'Pop Sensation', 'A hit pop single', FALSE, 'Pop', 'Pop Star'),
(3, 'jazzy_single.mp3', 5120, 'audio/mp3', 'Jazzy Jam', 'A single with a jazzy twist', FALSE, 'Jazz', 'Jazz Maestro'),
(4, 'rock_single.mp3', 8192, 'audio/mp3', 'Rocking Solo', 'An energetic rock single', FALSE, 'Rock', 'Rock Legend');

INSERT INTO Comments (music_id, user_id, comment_text) VALUES
(1, 2, 'Absolutely love the classical vibes!'),
(2, 1, 'Rap Sensation is a catchy hit!'),
(3, 3, 'Jazzy Jam is my go-to single for relaxation.'),
(4, 2, 'Rocking Solo lives up to its name! Amazing.');

INSERT INTO Likes (music_id, user_id) VALUES
(1, 2),
(2, 1),
(2, 2),
(3, 1),
(2, 3),
(3, 3);

INSERT INTO Ratings (music_id, user_id, rating_value) VALUES
(1, 2, 5),
(2, 1, 4),
(1, 3, 4);

INSERT INTO Tags (tag_name) VALUES ('Classical', 'Rap', 'Jazz', 'Rock');

INSERT INTO MusicItemTags (music_id, tag_id) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4);
