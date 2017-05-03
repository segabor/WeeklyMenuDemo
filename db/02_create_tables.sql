use menu;
create table menu(id int NOT NULL AUTO_INCREMENT, title varchar(32) not null, subtitle varchar(64) not null, description varchar(1024) not null, imgUrl varchar(256) not null, primary key(id));

-- test data
insert into menu(title, subtitle, description, imgUrl) values('paprikás ccsirke', 'Csirke paprikás magyaros módon galuska körettel', 'Leírás', '/images/csirke.png');
