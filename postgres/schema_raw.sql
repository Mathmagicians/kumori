DROP TABLE IF EXISTS files;

CREATE TABLE files (
    filename VARCHAR(300) NOT NULL,
    last_modified DATE NOT NULL,
    modified_count INT NOT NULL
);
