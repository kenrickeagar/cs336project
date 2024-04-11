use cs336project;

CREATE TABLE Users (id int AUTO_INCREMENT , username varchar(25), password varchar(25), PRIMARY KEY (id));

#Uncomment below if testing to see items page
#CREATE TABLE Items (i_id int AUTO_INCREMENT, item_name varchar(25), unit_price float, description varchar(100), PRIMARY KEY (i_id));
#INSERT INTO Items (item_name, unit_price) VALUES ('RED SHIRT', 12.00);
#INSERT INTO Items (item_name, unit_price) VALUES ('BLUE SHIRT', 40.63);

INSERT INTO Users (username, password)
VALUES ('zach', 'password123');

INSERT INTO Users (username, password)
VALUES ('user', '12345');

SELECT * FROM Users; 
