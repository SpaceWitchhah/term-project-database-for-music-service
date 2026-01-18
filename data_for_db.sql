INSERT INTO mstown.users(first_name, last_name, email, hashed_password, avatar_url, has_subscription, created_at,
 subscribed_at, subscription_ends_at, updated_at, country)
VALUES
('Ivan', 'Petrov', 'ivan.petrov@example.com', 'HASH_A1', 'ava1.jpg', TRUE, NOW()-INTERVAL '100 days', NOW()-INTERVAL '5 days', NOW()+INTERVAL '25 days', NOW(), 'RU'),
('Anna', 'Smirnova', 'anna.smirnova@example.com', 'HASH_A2', 'ava2.jpg', FALSE, NOW()-INTERVAL '200 days', NOW()-INTERVAL '80 days', NOW()-INTERVAL '50 days', NOW(), 'RU'),
('John', 'Miller', 'john.miller@example.com', 'HASH_A3', 'ava3.jpg', TRUE, NOW()-INTERVAL '60 days', NOW()-INTERVAL '10 days', NOW()+INTERVAL '20 days', NOW(), 'US'),
('Sakura', 'Tanaka', 'sakura.tanaka@example.com', 'HASH_A4', 'ava4.jpg', FALSE, NOW()-INTERVAL '300 days', NOW()-INTERVAL '100 days', NOW()-INTERVAL '70 days', NOW(), 'JP'),
('Lars', 'Hansen', 'lars.hansen@example.com', 'HASH_A5', 'ava5.jpg', TRUE, NOW()-INTERVAL '40 days', NOW()-INTERVAL '3 days', NOW()+INTERVAL '27 days', NOW(), 'DK'),
('Maria', 'Garcia', 'maria.garcia@example.com', 'HASH_A6', 'ava6.jpg', FALSE, NOW()-INTERVAL '150 days', NOW()-INTERVAL '50 days', NOW()-INTERVAL '20 days', NOW(), 'ES'),
('Chen', 'Wei', 'chen.wei@example.com', 'HASH_A7', 'ava7.jpg', TRUE, NOW()-INTERVAL '80 days', NOW()-INTERVAL '15 days', NOW()+INTERVAL '15 days', NOW(), 'CN'),
('Elena', 'Morozova', 'elena.morozova@example.com', 'HASH_A8', 'ava8.jpg', FALSE, NOW()-INTERVAL '70 days', NOW()-INTERVAL '40 days', NOW()-INTERVAL '10 days', NOW(), 'RU'),
('David', 'Brown', 'david.brown@example.com', 'HASH_A9', 'ava9.jpg', TRUE, NOW()-INTERVAL '120 days', NOW()-INTERVAL '7 days', NOW()+INTERVAL '23 days', NOW(), 'GB'),
('Soojin', 'Park', 'soojin.park@example.com', 'HASH_A10', 'ava10.jpg', FALSE, NOW()-INTERVAL '50 days', NOW()-INTERVAL '45 days', NOW()-INTERVAL '15 days', NOW(), 'KR'),
('Alex', 'Johnson', 'alex.johnson@example.com', 'HASH_U11', 'ava11.jpg', TRUE, NOW()-INTERVAL '15 days', NOW()-INTERVAL '1 days', NOW()+INTERVAL '29 days', NOW(), 'US'),
('Maria', 'Lopez', 'maria.lopez@example.com', 'HASH_U12', 'ava12.jpg', TRUE, NOW()-INTERVAL '20 days', NOW()-INTERVAL '2 days', NOW()+INTERVAL '28 days', NOW(), 'ES'),
('Ken', 'Yamamoto', 'ken.yamamoto@example.com', 'HASH_U13', 'ava13.jpg', TRUE, NOW()-INTERVAL '25 days', NOW()-INTERVAL '3 days', NOW()+INTERVAL '27 days', NOW(), 'JP'),
('Sophie', 'Müller', 'sophie.mueller@example.com', 'HASH_U14', 'ava14.jpg', FALSE, NOW()-INTERVAL '30 days', NULL, NULL, NOW(), 'DE'),
('Hidden', 'User1', 'hidden1@example.com', 'HASH_H1', 'ava15.jpg', TRUE, NOW()-INTERVAL '20 days', NOW()-INTERVAL '1 days', NOW()+INTERVAL '29 days', NOW(), 'RU'),
('Hidden', 'User2', 'hidden2@example.com', 'HASH_H2', 'ava16.jpg', FALSE, NOW()-INTERVAL '15 days', NULL, NULL, NOW(), 'US'),
('Leo', 'Smith', 'leo.smith@example.com', 'HASH_U15', 'ava17.jpg', TRUE, NOW()-INTERVAL '12 days', NOW()-INTERVAL '1 days', NOW()+INTERVAL '29 days', NOW(), 'CA'),
('Emma', 'Brown', 'emma.brown@example.com', 'HASH_U16', 'ava18.jpg', TRUE, NOW()-INTERVAL '18 days', NOW()-INTERVAL '2 days', NOW()+INTERVAL '28 days', NOW(), 'GB'),
('Kai', 'Chen', 'kai.chen@example.com', 'HASH_U17', 'ava19.jpg', FALSE, NOW()-INTERVAL '25 days', NULL, NULL, NOW(), 'CN'),
('Lina', 'Kang', 'lina.kang@example.com', 'HASH_U18', 'ava20.jpg', TRUE, NOW()-INTERVAL '22 days', NOW()-INTERVAL '1 days', NOW()+INTERVAL '29 days', NOW(), 'KR');

INSERT INTO mstown.authors(stage_name, stage_avatar_url, user_id)
VALUES
('BTS','bts.jpg',3),
('The Score','score.jpg',5),
('KISS','kiss.jpg',NULL),
('OneRepublic','onerepublic.jpg',10),
('Stray Kids','straykids.jpg',9),
('Coldplay','coldplay.jpg',NULL),
('Imagine Dragons','imagine.jpg',NULL),
('Dua Lipa','dualipa.jpg',NULL),
('Linkin Park','linkinpark.jpg',NULL),
('The Weeknd','weeknd.jpg',NULL);

INSERT INTO mstown.albums(title, release_year, cover_url, album_type, author_id)
VALUES
('Map of the Soul: 7', 2020, 'album1.jpg', 'album',1),
('NOEASY', 2021, 'album2.jpg', 'album',5),
('Destroyer', 1976, 'album3.jpg', 'album',3),
('Native', 2013, 'album4.jpg', 'album',4),
('Evolve', 2017, 'album5.jpg', 'album',7),
('Future Nostalgia', 2020, 'album6.jpg', 'album',8),
('Hybrid Theory', 2000, 'album7.jpg', 'album',9),
('After Hours', 2020, 'album8.jpg', 'album',10),
('Atlas', 2017, 'album9.jpg', 'album',2),
('A Head Full of Dreams', 2015, 'album10.jpg', 'album',6);

INSERT INTO mstown.album_collaborations(author_id, album_id)
VALUES
(1,1),(5,2),(3,3),(4,4),(7,5),(8,6),(9,7),(10,8),(2,9),(6,10),
(1,2),(1,3),(1,4),(5,1),(5,3),(5,4),(2,5),(2,6),(2,7);

INSERT INTO mstown.songs(title, lyrics_url, duration, cover_url, release_year, times_played, album_id)
VALUES
('ON', NULL, 298, 'song1.jpg', 2020, 1200000, 1),
('Life Goes On', NULL, 215, 'song2.jpg', 2020, 850000, 1),
('Thunderous', NULL, 202, 'song3.jpg', 2021, 500000, 2),
('Gods Menu', NULL, 198, 'song4.jpg', 2021, 470000, 2),
('Detroit Rock City', NULL, 214, 'song5.jpg', 1976, 900000, 3),
('Beth', NULL, 178, 'song6.jpg', 1976, 450000, 3),
('Counting Stars', NULL, 257, 'song7.jpg', 2013, 800000, 4),
('If I Lose Myself', NULL, 238, 'song8.jpg', 2013, 600000, 4),
('Believer', NULL, 204, 'song9.jpg', 2017, 750000, 5),
('Thunder', NULL, 187, 'song10.jpg', 2017, 500000, 5),
('Starboy', NULL, 230, 'song11.jpg', 2020, 400000, 8),
('Blinding Lights', NULL, 200, 'song12.jpg', 2020, 350000, 8);

INSERT INTO mstown.song_collaborations(author_id, song_id)
VALUES
(1,1),(1,2),(5,3),(5,4),(3,5),(3,6),(4,7),(4,8),(7,9),(7,10),
(10,11),(10,12),(2,3),(2,9);

INSERT INTO mstown.genres(gen_name)
VALUES
('pop'),('k-pop'),('rock'),('hard rock'),('alternative'),('indie'),
('electronic'),('hip-hop'),('dance'),('punk'),('R&B'),('soul'),('metal'),('folk');

INSERT INTO mstown.song_genres(song_id, genre_id)
VALUES
(1,2),(2,1),(2,2),(3,2),(4,2),(5,4),(6,3),(7,1),(8,5),(9,5),(10,4),(11,11),(12,1);

INSERT INTO mstown.playlists(title, is_public, user_id)
VALUES
('Favorites', TRUE, 1),
('Chill Vibes', FALSE, 2),
('Workout Mix', TRUE, 3),
('Roadtrip Hits', TRUE, 4),
('Top 10', TRUE, 5),
('Evening Chill', FALSE, 6),
('Rock Classics', TRUE, 7),
('Pop Party', TRUE, 8),
('K-pop Mix', FALSE, 9),
('Morning Motivation', TRUE, 10),
('Hidden Mix 1', TRUE, 15),
('Hidden Mix 2', TRUE, 16);

INSERT INTO mstown.playlist_songs(playlist_id, song_id, added_at, position)
VALUES
(1,1,NOW()-INTERVAL '20 days',1),
(2,2,NOW()-INTERVAL '15 days',1),
(3,3,NOW()-INTERVAL '10 days',1),
(4,4,NOW()-INTERVAL '12 days',1),
(5,5,NOW()-INTERVAL '8 days',1),
(6,6,NOW()-INTERVAL '9 days',1),
(7,7,NOW()-INTERVAL '7 days',1),
(8,8,NOW()-INTERVAL '6 days',1),
(9,9,NOW()-INTERVAL '5 days',1),
(10,10,NOW()-INTERVAL '4 days',1),
(11,1,NOW()-INTERVAL '1 days',1),
(11,3,NOW()-INTERVAL '1 days',2),
(12,2,NOW()-INTERVAL '1 days',1),
(12,4,NOW()-INTERVAL '1 days',2);

INSERT INTO mstown.favorites(user_id, song_id, added_at)
VALUES
(1,1,NOW()-INTERVAL '18 days'),
(2,2,NOW()-INTERVAL '16 days'),
(3,3,NOW()-INTERVAL '14 days'),
(4,4,NOW()-INTERVAL '12 days'),
(5,5,NOW()-INTERVAL '10 days'),
(6,6,NOW()-INTERVAL '8 days'),
(7,7,NOW()-INTERVAL '6 days'),
(8,8,NOW()-INTERVAL '5 days'),
(9,9,NOW()-INTERVAL '4 days'),
(10,10,NOW()-INTERVAL '3 days');

INSERT INTO mstown.play_history(user_id, song_id, played_at, listened_in_seconds)
VALUES
(1,1,NOW()-INTERVAL '2 days',298),
(2,2,NOW()-INTERVAL '3 days',215),
(3,3,NOW()-INTERVAL '1 days',202),
(4,4,NOW()-INTERVAL '4 days',198),
(5,5,NOW()-INTERVAL '5 days',214),
(6,6,NOW()-INTERVAL '6 days',178),
(7,7,NOW()-INTERVAL '7 days',257),
(8,8,NOW()-INTERVAL '8 days',238),
(9,9,NOW()-INTERVAL '9 days',204),
(10,10,NOW()-INTERVAL '10 days',187),
(11,5,NOW()-INTERVAL '1 days',214),
(12,6,NOW()-INTERVAL '2 days',178);

INSERT INTO mstown.user_follows(follower_user_id, following_user_id, followed_at)
VALUES
(1,2,NOW()-INTERVAL '20 days'),
(2,3,NOW()-INTERVAL '19 days'),
(3,4,NOW()-INTERVAL '18 days'),
(4,5,NOW()-INTERVAL '17 days'),
(5,6,NOW()-INTERVAL '16 days'),
(6,7,NOW()-INTERVAL '15 days'),
(7,8,NOW()-INTERVAL '14 days'),
(8,9,NOW()-INTERVAL '13 days'),
(9,10,NOW()-INTERVAL '12 days'),
(10,1,NOW()-INTERVAL '11 days');

INSERT INTO mstown.author_follows(user_id, author_id, followed_at)
VALUES
(1,1,NOW()-INTERVAL '25 days'),
(2,2,NOW()-INTERVAL '24 days'),
(3,3,NOW()-INTERVAL '23 days'),
(4,4,NOW()-INTERVAL '22 days'),
(5,5,NOW()-INTERVAL '21 days'),
(6,6,NOW()-INTERVAL '20 days'),
(7,7,NOW()-INTERVAL '19 days'),
(8,8,NOW()-INTERVAL '18 days'),
(9,9,NOW()-INTERVAL '17 days'),
(10,10,NOW()-INTERVAL '16 days'),
(1,5,NOW()-INTERVAL '2 days'),
(2,3,NOW()-INTERVAL '3 days'),
(3,2,NOW()-INTERVAL '1 days');

INSERT INTO mstown.payments(user_id, amount, currency, payment_status, created_at, paid_at)
VALUES
(1, 399, 'RUB', 'completed', NOW()-INTERVAL '5 days', NOW()-INTERVAL '5 days'),
(2, 399, 'RUB', 'completed', NOW()-INTERVAL '80 days', NOW()-INTERVAL '80 days'),
(3, 5, 'USD', 'completed', NOW()-INTERVAL '10 days', NOW()-INTERVAL '10 days'),
(4, 762, 'JPY', 'completed', NOW()-INTERVAL '100 days', NOW()-INTERVAL '100 days'),
(5, 32, 'DKK', 'completed', NOW()-INTERVAL '3 days', NOW()-INTERVAL '3 days'),
(6, 4, 'EUR', 'completed', NOW()-INTERVAL '50 days', NOW()-INTERVAL '50 days'),
(7, 35, 'CNY', 'completed', NOW()-INTERVAL '15 days', NOW()-INTERVAL '15 days'),
(8, 399, 'RUB', 'completed', NOW()-INTERVAL '40 days', NOW()-INTERVAL '40 days'),
(9, 4, 'GBP', 'completed', NOW()-INTERVAL '7 days', NOW()-INTERVAL '7 days'),
(10, 7244, 'KRW', 'completed', NOW()-INTERVAL '45 days', NOW()-INTERVAL '45 days');

INSERT INTO mstown.search_history(user_id, query, searched_at)
VALUES
(1,'ON',NOW()-INTERVAL '1 days'),
(2,'Thunderous',NOW()-INTERVAL '1 days'),
(3,'Believer',NOW()-INTERVAL '1 days'),
(4,'Life Goes On',NOW()-INTERVAL '2 days'),
(5,'Counting Stars',NOW()-INTERVAL '2 days'),
(6,'Gods Menu',NOW()-INTERVAL '3 days'),
(7,'Detroit Rock City',NOW()-INTERVAL '3 days'),
(8,'If I Lose Myself',NOW()-INTERVAL '4 days'),
(9,'Starboy',NOW()-INTERVAL '1 days'),
(10,'Blinding Lights',NOW()-INTERVAL '2 days');
