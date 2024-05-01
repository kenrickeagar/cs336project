DROP DATABASE IF EXISTS cs336project;
CREATE DATABASE cs336project;
use cs336project;

CREATE TABLE Users (id int AUTO_INCREMENT , username varchar(25), password varchar(25), PRIMARY KEY (id));
CREATE TABLE Category(cid varchar(20), cname varchar(20), PRIMARY KEY (cid));
CREATE TABLE Items (i_id int AUTO_INCREMENT, item_name varchar(25), unit_price float, min_price float, description varchar(100), cid varchar(20), foreign key (cid) references Category (cid), subcatAttribute varchar(20), closing_date_time datetime,seller_id int,winner_id int, foreign key(seller_id) references Users (id),foreign key(winner_id) references Users (id), PRIMARY KEY (i_id));
CREATE TABLE Bids(amount int, time_of_bid datetime, buyer_id int, i_id int, foreign key (buyer_id) references users (id), foreign key (i_id) references items (i_id));
CREATE TABLE Questions(question varchar(100), answer varchar(100), id int, foreign key (id) references Users (id));
CREATE TABLE Auto_Bids(id int, i_id int, prev_price float, amount float, increment float, foreign key (id) references Users (id),foreign key (i_id) references Items (i_id));
CREATE TABLE Item_Alert(alert_id int AUTO_INCREMENT, id int, item_decription varchar(25), foreign key (id) references users (id), primary key (alert_id));

INSERT INTO users (username, password) VALUES ('admin', 'pass');
INSERT INTO Users (username, password) VALUES ('zach', 'password123');
INSERT INTO Users (username, password) VALUES ('jimmy', 'fallon');
INSERT INTO Users (username, password) VALUES ('sponge', 'bob');
INSERT INTO Users (username, password) VALUES ('user', '12345');

INSERT INTO Category(cid, cname) VALUES ('PANTS', 'PANTS'); 
INSERT INTO Category(cid,cname) VALUES ('SHIRTS', 'SHIRTS');
INSERT INTO Category(cid,cname) VALUES ('SHOES', 'SHOES');

#default shirts - shirt subcatAttribute is like small medium large xl etc
INSERT INTO Items (item_name, unit_price, description, cid, subcatAttribute, closing_date_time,seller_id) VALUES ('Black Jersey', 12.00, 'lightly used', 'SHIRTS', 'small', '2024-06-23 12:34:56',1);
INSERT INTO Items (item_name, unit_price, description,cid, subcatAttribute, closing_date_time,seller_id) VALUES ('Green Jersey', 6.00, 'very green very good', 'SHIRTS', 'small', '2024-06-23 12:34:56',2);
INSERT INTO Items (item_name, unit_price, description,cid, subcatAttribute, closing_date_time,seller_id) VALUES ('Red Jersey', 7.00, 'super red', 'SHIRTS', 'small', '2024-06-23 12:34:56',3);

#default pants - pants subcatAttribute is waist size so 28 32 34 etc
INSERT INTO Items (item_name, unit_price, description,cid, subcatAttribute, closing_date_time,seller_id) VALUES ('Shorts', 10.00, 'comfortable', 'PANTS', '28', '2024-06-23 12:34:56',1);
INSERT INTO Items (item_name, unit_price, description,cid, subcatAttribute, closing_date_time,seller_id) VALUES ('Ripped Jeans', 20.00, 'good condition', 'PANTS', '34', '2024-06-23 12:34:56',2);
INSERT INTO Items (item_name, unit_price, description,cid, subcatAttribute, closing_date_time,seller_id) VALUES ('Dress Pants', 10.00, 'fancy', 'PANTS', '32', '2024-06-23 12:34:56',3);

#default shoes - subcatAttribute is like shoe sizes so 7, 8.5, etc
INSERT INTO Items (item_name, unit_price, description,cid, subcatAttribute, closing_date_time,seller_id) VALUES ('Air Force 1s', 50.00, 'creased','SHOES', '7', '2024-06-23 12:34:56',1);
INSERT INTO Items (item_name, unit_price, description,cid, subcatAttribute, closing_date_time,seller_id) VALUES ('Jordans', 30.00, 'really good','SHOES', '9', '2024-06-23 12:34:56',2);
INSERT INTO Items (item_name, unit_price, description,cid, subcatAttribute, closing_date_time,seller_id) VALUES ('retro 5s', 70.00, 'creased','SHOES', '10', '2024-06-23 12:34:56',3);

#Check Shirts and click black jersey to see bid table example
INSERT INTO Bids(buyer_id, i_id, amount, time_of_bid) VALUES (1, 1, 14 ,NOW());
INSERT INTO Bids(buyer_id, i_id, amount, time_of_bid) VALUES (2, 1,16 ,NOW());
INSERT INTO Bids(buyer_id, i_id, amount, time_of_bid) VALUES (3, 1,17 ,NOW());
UPDATE Items SET unit_price = 17 WHERE i_id = 1;

#Default filler questions
INSERT INTO Questions(question,answer, id) VALUES ('How do I bid for Items?', 'Go to a selected item and click bid', 1);
INSERT INTO Questions(question,answer, id) VALUES ('How many items can I bid for?', 'no limit on items you can bid for', 2);
INSERT INTO Questions(question,answer, id) VALUES ('Is the sky blue?', 'possibly', 3);

SELECT * FROM Users;
SELECT * FROM Items;
