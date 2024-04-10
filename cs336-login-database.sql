use cs336project;

CREATE TABLE Users (id int AUTO_INCREMENT , username varchar(25), password varchar(25), PRIMARY KEY (id));

INSERT INTO Users (username, password)
VALUES ('zach', 'password123');

INSERT INTO Users (username, password)
VALUES ('user', '12345');

SELECT * FROM Users; 