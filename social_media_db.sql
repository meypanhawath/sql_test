-- USERS
CREATE TABLE Users (
    user_id SERIAL PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    email VARCHAR(100) NOT NULL UNIQUE,
    bio TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- POSTS
CREATE TABLE Posts (
    post_id SERIAL PRIMARY KEY,
    user_id INTEGER NOT NULL REFERENCES Users(user_id) ON DELETE CASCADE,
    content TEXT NOT NULL,
    media_url TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- COMMENTS
CREATE TABLE Comments (
    comment_id SERIAL PRIMARY KEY,
    post_id INTEGER NOT NULL REFERENCES Posts(post_id) ON DELETE CASCADE,
    user_id INTEGER NOT NULL REFERENCES Users(user_id) ON DELETE CASCADE,
    comment_text TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- LIKES
CREATE TABLE Likes (
    like_id SERIAL PRIMARY KEY,
    user_id INTEGER NOT NULL REFERENCES Users(user_id) ON DELETE CASCADE,
    post_id INTEGER NOT NULL REFERENCES Posts(post_id) ON DELETE CASCADE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE(user_id, post_id)  -- Prevent duplicate likes
);

-- FOLLOWERS
CREATE TABLE Followers (
    follower_id SERIAL PRIMARY KEY,
    user_id INTEGER NOT NULL REFERENCES Users(user_id) ON DELETE CASCADE, -- person being followed
    follower_user_id INTEGER NOT NULL REFERENCES Users(user_id) ON DELETE CASCADE -- person who follows
);

-- MESSAGES
CREATE TABLE Messages (
    message_id SERIAL PRIMARY KEY,
    sender_id INTEGER NOT NULL REFERENCES Users(user_id) ON DELETE CASCADE,
    receiver_id INTEGER NOT NULL REFERENCES Users(user_id) ON DELETE CASCADE,
    message_text TEXT NOT NULL,
    sent_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    is_read BOOLEAN DEFAULT FALSE
);