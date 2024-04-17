DROP DATABASE IF EXISTS cs336project;
CREATE DATABASE cs336project;
use cs336project;

CREATE TABLE Users (id int AUTO_INCREMENT , username varchar(25), password varchar(25), PRIMARY KEY (id));

CREATE TABLE Items (i_id int AUTO_INCREMENT, item_name varchar(25), unit_price float, description varchar(100), cid varchar(20), foreign key (cid) references Category (cid), PRIMARY KEY (i_id));
CREATE TABLE Category(cid varchar(20), cname varchar(20), i_id int, PRIMARY KEY (cid));
INSERT INTO Items (item_name, unit_price) VALUES ('RED SHIRT', 12.00);
INSERT INTO Items (item_name, unit_price) VALUES ('BLUE SHIRT', 40.63);

INSERT INTO Users (username, password)
VALUES ('zach', 'password123');

INSERT INTO Users (username, password)
VALUES ('user', '12345');

SELECT * FROM Users; 
