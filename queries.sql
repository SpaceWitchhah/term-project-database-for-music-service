-- пользователи с активной подпиской
SELECT 
  id,
  ROW_NUMBER() OVER(ORDER BY id) AS subscription_rank,
  first_name,
  last_name,
  subscription_ends_at
FROM mstown.users
WHERE has_subscription = TRUE and subscription_ends_at >= CURRENT_DATE;


-- топ 5 самых прослушиваемых авторов по количеству прослушиваний их песен
SELECT 
	a.id AS author_id,
	a.stage_name AS stage_name,
	SUM(COALESCE(s.times_played, 0)) AS total_plays 
FROM mstown.songs AS s
JOIN mstown.song_collaborations AS sc ON s.id = sc.song_id
JOIN mstown.authors AS a ON sc.author_id = a.id
GROUP BY a.id, a.stage_name
ORDER BY total_plays DESC
LIMIT 5;

-- самые популярные жанры за месяц по суммарному времени прослушивания песен с соответствующим жанром
SELECT 
  g.id AS genre_id,
  g.gen_name,
  SUM(COALESCE(ph.listened_in_seconds,0)) AS total_listened_in_seconds
FROM mstown.play_history AS ph
JOIN mstown.songs AS s ON ph.song_id = s.id
JOIN mstown.song_genres AS sg ON s.id = sg.song_id
JOIN mstown.genres AS g ON sg.song_id = g.id
WHERE ph.played_at >= NOW() - INTERVAL '1 month'
GROUP BY g.id, g.gen_name
ORDER BY total_listened_in_seconds DESC;

-- авторы, которые чаще всего слушаются пользователями с активной подпиской

WITH active_subscribers AS(
	SELECT 
  		id
	FROM mstown.users
	WHERE has_subscription = TRUE)
SELECT 
  a.id AS author_id,
  a.stage_name,
  COUNT(ph.id) AS plays_by_active_subscribers
FROM mstown.authors AS a
JOIN mstown.song_collaborations AS sc ON a.id = sc.author_id
JOIN mstown.songs AS s ON sc.song_id = s.id
JOIN mstown.play_history AS ph ON s.id = ph.song_id
WHERE ph.user_id IN (SELECT id FROM active_subscribers)
GROUP BY a.id, a.stage_name
ORDER BY plays_by_active_subscribers DESC;


-- топ 3 пользователя, которые слушают больше всего песен из своих любимых жанров(жанры песен,находящихся в favorites)

WITH fav_genres_of_user AS(
	SELECT 
      u.id AS user_id,
      sg.genre_id
  	FROM mstown.users u
  	JOIN mstown.favorites f ON u.id = f.user_id
  	JOIN mstown.song_genres sg ON f.song_id = sg.song_id
),
user_listens AS(
	SELECT 
      ph.user_id,
      sg.genre_id,
      SUM(ph.listened_in_seconds) AS total_listens_in_seconds
	FROM mstown.play_history ph
	JOIN mstown.songs s ON ph.song_id = s.id
	JOIN mstown.song_genres sg ON s.id = sg.song_id
	GROUP BY ph.user_id, sg.genre_id)
    
SELECT 
	fav_gens.user_id,
    SUM(user_listens.total_listens_in_seconds) AS fav_gen_listens
FROM fav_genres_of_user fav_gens
JOIN user_listens ON fav_gens.user_id = user_listens.user_id 
	AND fav_gens.genre_id = user_listens.genre_id
GROUP BY fav_gens.user_id
ORDER BY fav_gen_listens DESC
LIMIT 3;


-- список всех плэйлистов с их названиями, именем пользователя, количеством песен в плэйлисте и суммырным временем прослушивания

SELECT
	p.id AS playlist_id,
    p.title AS playlist_title,
    u.first_name || ' ' || u.last_name AS user_name,
    COUNT(DISTINCT ps.song_id) AS count_unique_songs,
    COALESCE(SUM(ph.listened_in_seconds), 0) AS total_listened_in_seconds
FROM mstown.playlists p
LEFT JOIN mstown.users u ON p.user_id=u.id
LEFT JOIN mstown.playlist_songs ps ON p.id = ps.playlist_id
LEFT JOIN mstown.play_history ph ON ps.song_id = ph.song_id AND ph.user_id = p.user_id
GROUP BY p.id, p.title, u.first_name, u.last_name
ORDER BY total_listened_in_seconds DESC;

-- получить список всех песен с их авторами и жанрами

SELECT
	s.id AS song_id,
    s.title AS song_title,
    a.stage_name AS author_name,
    g.gen_name as genre_name
FROM mstown.songs s
INNER JOIN mstown.song_collaborations sc ON s.id = sc.song_id
INNER JOIN mstown.authors a ON sc.author_id = a.id
INNER JOIN mstown.song_genres sg ON s.id = sg.song_id
INNER JOIN mstown.genres g ON sg.genre_id = g.id
ORDER BY s.id, a.stage_name, g.gen_name;

-- процедура, которая добавляет оплату пользователю и создаёт новую запись в mstown.payments

CREATE OR REPLACE PROCEDURE mstown.add_payment_data(
	IN pay_user_id INTEGER DEFAULT NULL,
	IN pay_amount DECIMAL(10, 2) DEFAULT 0,
	IN pay_currency TEXT DEFAULT 'USD',
  	IN pay_status TEXT DEFAULT 'completed',
    IN pay_created_at TIMESTAMP DEFAULT NOW(),
    IN pay_paid_at TIMESTAMP DEFAULT NOW()
)
LANGUAGE plpgsql
AS $$
BEGIN
	IF pay_status = 'failed' THEN
    	pay_paid_at := NULL;
    END IF;
	INSERT INTO mstown.payments(user_id, amount, currency, payment_status, created_at, paid_at)
    VALUES( pay_user_id,
        pay_amount,
        pay_currency,
        pay_status,
        pay_created_at,
        pay_paid_at);
    RAISE NOTICE 'Добавлены новые данные в таблицу о платежах user_id=%, amoint=%, currency=%, status=%',
    pay_user_id, pay_amount, pay_currency, pay_status;
END;
$$;

-- вызов процедуры
CALL mstown.add_payment_data(3, 5, 'USD','failed');


-- выводит последние 3 записи из таблицы payments(проверка после вызова процедуры)
SELECT 
	p.user_id,
    u.first_name || ' ' || u.last_name AS user_name,
    p.amount,
    p.currency,
    p.payment_status,
    p.created_at,
    p.paid_at
FROM mstown.payments p
JOIN mstown.users u ON p.user_id = u.id
ORDER BY p.created_at DESC
LIMIT 3;

-- процедура, которая должна вызываться, когда автор прослушивает песню(количество прослушиваний у песни обновляется, добавляется новая запись в историю прослушиваний)
CREATE OR REPLACE PROCEDURE mstown.user_listens_song(
	IN l_user_id INTEGER,
    IN l_song_id INTEGER,
  	IN l_listened_in_seconds INTEGER DEFAULT 0
)
LANGUAGE plpgsql
AS $$
BEGIN
	UPDATE mstown.songs
    SET times_played = times_played + 1
    WHERE id = l_song_id;
    
    INSERT INTO mstown.play_history(user_id, song_id, listened_in_seconds, played_at)
    VALUES(l_user_id, l_song_id, l_listened_in_seconds, NOW());
END;
$$;
    
-- вызов процедуры    
CALL mstown.user_listens_song(7, 9, 180);

-- проверка после вызова процедуры(выводит последние 3 записи из истории прослушиваний и название песни)
SELECT
	ph.user_id AS user_id,
    ph.song_id AS song_id,
    s.title AS song_title,
    s.times_played AS times_played,
    ph.played_at AS played_at
FROM mstown.play_history ph
JOIN mstown.songs s ON ph.song_id = s.id
ORDER BY ph.played_at DESC
LIMIT 3;
