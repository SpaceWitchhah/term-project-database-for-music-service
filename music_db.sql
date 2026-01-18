CREATE SCHEMA IF NOT EXISTS mstown;

-- пользователи
CREATE TABLE mstown.users(
    id SERIAL PRIMARY KEY,
    first_name TEXT NOT NULL,
    last_name TEXT NOT NULL,
    email TEXT NOT NULL UNIQUE CHECK (
        email LIKE '%@%.%' ),
    hashed_password TEXT NOT NULL,
    avatar_url TEXT,
    has_subscription BOOLEAN NOT NULL DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT NOW(),
    subscribed_at TIMESTAMP, -- чтобы понимать, как быстро подписка будет приобретена после установки приложения
    subscription_ends_at DATE,
    updated_at TIMESTAMP DEFAULT NOW(),
    country TEXT NOT NULL

);

--авторы
CREATE TABLE mstown.authors(
    id SERIAL PRIMARY KEY,
    stage_name TEXT NOT NULL, -- сценическое имя
    stage_avatar_url TEXT NOT NULL,
    user_id INTEGER REFERENCES mstown.users(id) ON DELETE SET NULL

);

-- альбомы
CREATE TABLE mstown.albums(
    id SERIAL PRIMARY KEY,
    title TEXT NOT NULL,
    release_year INTEGER NOT NULL,
    cover_url TEXT NOT NULL,
    album_type TEXT NOT NULL CHECK( album_type IN ('single', 'EP', 'album')),
    author_id INTEGER REFERENCES mstown.authors(id) ON DELETE CASCADE -- ссфлка на автора

);

-- коллаборации(у одного альбома может быть несколько авторов)
CREATE TABLE mstown.album_collaborations(
    author_id INTEGER REFERENCES mstown.authors(id) ON DELETE CASCADE,
    album_id INTEGER REFERENCES mstown.albums(id) ON DELETE CASCADE,

    PRIMARY KEY (author_id, album_id)
);

-- песни
CREATE TABLE mstown.songs(
    id SERIAL PRIMARY KEY,
    title TEXT NOT NULL,
    lyrics_url TEXT,
    duration INTEGER NOT NULL,
    cover_url TEXT NOT NULL,
    release_year INTEGER,
    times_played INTEGER DEFAULT 0,
    album_id INTEGER REFERENCES mstown.albums(id) ON DELETE SET NULL -- песня может существовать и без альбома
     
);

-- коллаборации(у одной песни может быть несколько авторов) и просто связь автора и песни
CREATE TABLE mstown.song_collaborations(
    author_id INTEGER REFERENCES mstown.authors(id) ON DELETE CASCADE,
    song_id INTEGER REFERENCES mstown.songs(id) ON DELETE CASCADE,

    PRIMARY KEY (author_id, song_id)
);

-- жанры
CREATE TABLE mstown.genres(
    id SERIAL PRIMARY KEY,
    gen_name TEXT NOT NULL -- название жанра

);

-- связь жанров и песен, т.к. у песни может быть несколько жанров
CREATE TABLE mstown.song_genres(
    song_id INTEGER REFERENCES mstown.songs(id) ON DELETE CASCADE,
    genre_id INTEGER REFERENCES mstown.genres(id) ON DELETE CASCADE,

    PRIMARY KEY (song_id, genre_id)

);

-- плэйлисты
CREATE TABLE mstown.playlists(
    id SERIAL PRIMARY KEY,
    title TEXT NOT NULL,
    is_public BOOLEAN NOT NULL DEFAULT TRUE,
    user_id INTEGER REFERENCES mstown.users(id) ON DELETE SET NULL

);

--избранное
CREATE TABLE mstown.favorites(
    user_id INTEGER REFERENCES mstown.users(id) ON DELETE CASCADE,
    song_id INTEGER REFERENCES mstown.songs(id) ON DELETE CASCADE,
    added_at TIMESTAMP DEFAULT NOW(),

    PRIMARY KEY (user_id, song_id)
);

-- песни в плэйлистах
CREATE TABLE mstown.playlist_songs(
    playlist_id INTEGER REFERENCES mstown.playlists(id) ON DELETE CASCADE,
    song_id INTEGER REFERENCES mstown.songs(id) ON DELETE CASCADE,
    added_at TIMESTAMP DEFAULT NOW(),

    PRIMARY KEY (playlist_id, song_id)
);

ALTER TABLE mstown.playlist_songs
ADD COLUMN position INTEGER NOT NULL DEFAULT 0;

-- история прослушиваний
CREATE TABLE mstown.play_history(
    id SERIAL PRIMARY KEY,
    user_id INTEGER REFERENCES mstown.users(id) ON DELETE SET NULL,
    song_id INTEGER REFERENCES mstown.songs(id) ON DELETE CASCADE,
    played_at TIMESTAMP DEFAULT NOW()
);

ALTER TABLE mstown.play_history
ADD COLUMN listened_in_seconds INTEGER;

-- подписка пользователя на другого пользователя
CREATE TABLE mstown.user_follows(
    follower_user_id INTEGER REFERENCES mstown.users(id) ON DELETE CASCADE,
    following_user_id INTEGER REFERENCES mstown.users(id) ON DELETE CASCADE,
    followed_at TIMESTAMP DEFAULT NOW(),

    PRIMARY KEY (follower_user_id, following_user_id)
);
-- подписка пользователя на автора 
CREATE TABLE mstown.author_follows(
    user_id INTEGER REFERENCES mstown.users(id) ON DELETE CASCADE,
    author_id INTEGER REFERENCES mstown.authors(id) ON DELETE CASCADE,
    followed_at TIMESTAMP DEFAULT NOW(),

    PRIMARY KEY (user_id, author_id)
);


-- история платежей
CREATE TABLE mstown.payments(
    id SERIAL PRIMARY KEY,
    user_id INTEGER REFERENCES mstown.users(id) ON DELETE CASCADE,
    amount DECIMAL(10, 2) NOT NULL,
    currency TEXT NOT NULL,
    payment_status TEXT NOT NULL CHECK(payment_status IN ('completed', 'failed')),
    created_at TIMESTAMP DEFAULT NOW(),
    paid_at TIMESTAMP DEFAULT NOW()

);
-- история поиска
CREATE TABLE mstown.search_history(
    id SERIAL PRIMARY KEY,
    user_id INTEGER REFERENCES mstown.users(id) ON DELETE CASCADE,
    query TEXT NOT NULL,
    searched_at TIMESTAMP DEFAULT NOW()
);