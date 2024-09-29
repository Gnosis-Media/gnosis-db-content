CREATE DATABASE content_db;

USE content_db;

CREATE TABLE content (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    file_name VARCHAR(255) NOT NULL,
    file_type VARCHAR(50) NOT NULL,
    upload_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    file_size INT NOT NULL,
    s3_key VARCHAR(255),
    chunk_count INT DEFAULT 0,
    custom_prompt TEXT
);

CREATE TABLE content_chunk (
    id INT AUTO_INCREMENT PRIMARY KEY,
    content_id INT,
    chunk_order INT NOT NULL,
    chunk_text TEXT NOT NULL,
    embedding JSON,
    FOREIGN KEY (content_id) REFERENCES content(id)
);

CREATE DATABASE conversation_db;

USE conversation_db;

CREATE TABLE conversation (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    start_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    last_update DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);


CREATE TABLE message (
    id INT AUTO_INCREMENT PRIMARY KEY,
    conversation_id INT,
    sender ENUM('user', 'ai') NOT NULL,
    content_chunk_id INT,
    message_text TEXT NOT NULL,
    timestamp DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (conversation_id) REFERENCES conversation(id)
);
