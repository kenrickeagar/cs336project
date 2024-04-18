DROP DATABASE IF EXISTS cs336project;
CREATE DATABASE cs336project;
use cs336project;

CREATE TABLE Users (id int AUTO_INCREMENT , username varchar(25), password varchar(25), PRIMARY KEY (id));
CREATE TABLE Items (i_id int AUTO_INCREMENT, item_name varchar(25), unit_price float, description varchar(100), cid varchar(20), foreign key (cid) references Category (cid), subcatAttribute varchar(20), PRIMARY KEY (i_id));
CREATE TABLE Category(cid varchar(20), cname varchar(20), PRIMARY KEY (cid));
CREATE TABLE Bids(int amount, time_date datetime, id int, i_id int, primary key(id,i_id), foreign key (id) references users (id), foreign key (i_id) references items (i_id));


INSERT INTO Category(cid, cname) VALUES ('PANTS', 'PANTS'); 
INSERT INTO Category(cid,cname) VALUES ('SHIRTS', 'SHIRTS');
INSERT INTO Category(cid,cname) VALUES ('SHOES', 'SHOES');

#default shirts - shirt subcatAttribute is like small medium large xl etc
INSERT INTO Items (item_name, unit_price, description, cid, subcatAttribute) VALUES ('Black Jersey', 12.00, 'lightly used', 'SHIRTS', 'small');
INSERT INTO Items (item_name, unit_price, description,cid, subcatAttribute) VALUES ('Green Jersey', 6.00, 'very green very good', 'SHIRTS', 'small');
INSERT INTO Items (item_name, unit_price, description,cid, subcatAttribute) VALUES ('Red Jersey', 7.00, 'super red', 'SHIRTS', 'small');

#default pants - pants subcatAttribute is waist size so 28 32 34 etc
INSERT INTO Items (item_name, unit_price, description,cid, subcatAttribute) VALUES ('Shorts', 10.00, 'comfortable', 'PANTS', '28');
INSERT INTO Items (item_name, unit_price, description,cid, subcatAttribute) VALUES ('Ripped Jeans', 20.00, 'good condition', 'PANTS', '34');
INSERT INTO Items (item_name, unit_price, description,cid, subcatAttribute) VALUES ('Dress Pants', 10.00, 'fancy', 'PANTS', '32');

#default shoes - subcatAttribute is like shoe sizes so 7, 8.5, etc
INSERT INTO Items (item_name, unit_price, description,cid, subcatAttribute) VALUES ('Air Force 1s', 50.00, 'creased','SHOES', '7');
INSERT INTO Items (item_name, unit_price, description,cid, subcatAttribute) VALUES ('Jordans', 30.00, 'really good','SHOES', '9');
INSERT INTO Items (item_name, unit_price, description,cid, subcatAttribute) VALUES ('retro 5s', 70.00, 'creased','SHOES', '10');

INSERT INTO Users (username, password) VALUES ('zach', 'password123');
INSERT INTO Users (username, password) VALUES ('jimmy', 'fallon');
INSERT INTO Users (username, password) VALUES ('sponge', 'bob');
INSERT INTO Users (username, password) VALUES ('user', '12345');

SELECT * FROM Users; 
