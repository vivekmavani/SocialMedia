-- create database
CREATE DATABASE socialmedia
USE socialmedia
CREATE TABLE Users
(
Uid int  CONSTRAINT uid_User PRIMARY KEY  IDENTITY(1,1),
Name varchar(20) not null,
City varchar(20) not null,
Email varchar(30) not null CONSTRAINT Email_validation CHECK(Email LIKE'%_@__%.__%')
PhoneNumber varchar(10) not null CONSTRAINT pn CHECK(PhoneNumber LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),
Created_date DATE  DEFAULT GETDATE(),
Visible TINYINT DEFAULT 1 CONSTRAINT employees_date CHECK(Visible IN (0,1)), 
Password varchar(200) not null
)
CREATE TABLE Categories
(
Category_ID int PRIMARY KEY IDENTITY(1,1),
Category_Name varchar(20) not null
)

CREATE TABLE Post
(
Pid int  not null CONSTRAINT pid_Post PRIMARY KEY  IDENTITY(1,1),
Title varchar(20) not null,
Description varchar(100) not null,
Image varchar(100) not null,
Likes int,
Category_ID int  CONSTRAINT Category_ID_Post FOREIGN KEY  REFERENCES  Categories(Category_ID) ON DELETE CASCADE ON UPDATE CASCADE,
Uid int  CONSTRAINT uid_Post FOREIGN KEY  REFERENCES  Users(Uid) ON DELETE CASCADE ON UPDATE CASCADE,
)

CREATE TABLE FriendRequest
(
FriendRequestid int  CONSTRAINT FriendRequestid_Post PRIMARY KEY  IDENTITY(1,1),
Uid_s int  CONSTRAINT Uid_s_FriendRequest FOREIGN KEY  REFERENCES  Users(Uid),
Frid_r int CONSTRAINT Frid_r_FriendRequest FOREIGN KEY  REFERENCES  Users(Uid),
CONSTRAINT unique_FriendRequest UNIQUE(Uid_s,Frid_r)
)

CREATE TABLE FriendAccapte
(
FriendAccapteid int   CONSTRAINT FriendAccapteid_FriendAccapte PRIMARY KEY  IDENTITY(1,1),
Uid int  CONSTRAINT Uid_FriendAccapte FOREIGN KEY  REFERENCES  Users(Uid) ,
Frid int  CONSTRAINT Frid_FriendAccapte FOREIGN KEY  REFERENCES  Users(Uid),
CONSTRAINT unique_FriendAccapte UNIQUE(Uid_s,Frid_r)
)
CREATE TABLE Chat
(
Chat_id int PRIMARY KEY IDENTITY(1,1),
Sender int CONSTRAINT SEND_FK FOREIGN KEY REFERENCES Users(uid),
Receiver int CONSTRAINT RECEIVE_FK FOREIGN KEY REFERENCES Users(uid),
Msg varchar(max) not null,
msg_time datetime DEFAULT GETDATE()
)

USE [socialmedia]
GO
-- Categories Add,Update,Delete,Display
INSERT INTO [dbo].[Categories]
           ([Category_Name])
     VALUES
           ('Album'),
		   ('Amateur Sports Team'),
		   ('Art'),
		   ('Financial Service'),
		   ('Book'),
		   ('Doctor'),
		   ('Education'),
		   ('Gaming'),
		   ('Hotel'),
		   ('Home Decor'),
		   ('Home Improvement'),
		   ('Internet Company'),
		   ('Kitchen'),
		   ('Library'),
		   ('Movie'),
		   ('Newspaper'),
		    ('Restaurant'),
		   ('School'),
		   ('Song'),
		    ('Traffic School'),
		   ('Visual Arts'),
		   ('Website'),
		   ('Zoo')
GO
SELECT Category_Name 'Categories' FROM Categories ORDER BY Category_Name

UPDATE [dbo].[Categories]
   SET [Category_Name] = 'Albums'
 WHERE Category_ID = 26
GO

USE [socialmedia]
GO

DELETE FROM [dbo].[Categories]
      WHERE Category_ID = 27
GO

INSERT INTO Users(Name,City,Email,PhoneNumber,Password)
VALUES
('Hiren','Jamnagar','hiren@gmail.com',5687412894,'hiren123');

INSERT INTO Users(Name,City,Email,PhoneNumber,Visible,Password)
VALUES
('Romish','Rajkot','romish@gmail.com',2545874962,0,'romish123'),
('Prit','Navasari','prit@gmail.com',7458963215,1,'prit123'),
('Vivek','Bhavnagar','Vivek@gmail.com',1205874965,1,'vivek123'),
('Neel','Gandhinagar','nell@gmail.com',9657432018,0,'neel135'),
('Jay','Rajkot','jay@gmail.com',7452013601,0,'jay456'),
('Pratik','Surat','pratik@gmail.com',9658002341,0,'pratik123'),
('Karan','Morbi','karan@gmail.com',1234567890,0,'karan147'),
('Veer','Jamnagar','veer@gmail.com',1518960214,0,'veer123'),
('Meet','Surat','meet@gmail.com',7850123604,0,'meet745');

update Users
set Visible = 1 
where Uid IN (6,7)


select * from Users

-- Queries for Chat database

INSERT INTO Chat VALUES
(1,2,'hello','2021-08-19 13:25:52.813'),
(2,1,'hi','2021-08-19 13:26:25.813'),
(2,1,'how are you','2021-08-19 13:26:52.836'),
(1,2,'I am fine','2021-08-19 13:26:53.713'),
(3,4,'HI','2021-08-19 13:27:50.813'),
(3,4,'I am COmputer Engineer','2021-08-19 13:27:55.813'),
(4,3,'Same here','2021-08-19 13:28:32.813'),
(3,4,'I am learning SQL','2021-08-19 13:28:52.813'),
(4,3,'I am learning HTML','2021-08-19 13:29:22.713')


INSERT INTO Chat VALUES
((SELECT DISTINCT Uid FROM FriendAccapte WHERE Uid = 2) ,(SELECT DISTINCT Frid FROM FriendAccapte WHERE Frid = 4),'hi','2021-08-19 16:21:22.713')

INSERT INTO Chat VALUES
((SELECT DISTINCT Uid FROM FriendAccapte WHERE Uid = 2) ,(SELECT DISTINCT Frid FROM FriendAccapte WHERE Frid = 4),'how are you','2021-08-19 16:22:22.713'),
((SELECT DISTINCT Frid FROM FriendAccapte WHERE Frid = 4) ,(SELECT DISTINCT Uid FROM FriendAccapte WHERE Uid = 2),'I am fine','2021-08-19 17:22:22.713')

DECLARE @Sender int
SET @Sender = 2

DECLARE @Receiver int
SET @Receiver = 4

SELECT 
	(SELECT u.Name FROM Users u WHERE u.Uid = c.Sender) as 'Sender', 
	(SELECT u.Name FROM Users u WHERE u.Uid = c.Receiver) as 'Receiver', 
	c.Msg
FROM Chat c
WHERE (Sender = @Sender AND Receiver = @Receiver) OR (Sender = @Receiver AND Receiver = @Sender)
ORDER BY msg_time


UPDATE Chat
SET Msg = 'I am creating database of Social media'
WHERE msg_time = '2021-08-19 13:29:22.713'


-- DELETE FROM Chat WHERE msg_time = '2021-08-19 13:29:22.713'
-- DELETE FROM Chat WHERE Sender = 1 AND Receiver = 2

USE socialmedia
GO

--DISPLAY ALL POST
SELECT P.Pid,P.Description,P.Image,P.Likes,P.Title FROM Post P JOIN Users U ON P.Uid = U.Uid 
WHERE U.Visible = 1

--DISPLAY ALL POST FOR ONLY FRIEND
SELECT P.Pid,P.Description,P.Image,P.Likes,P.Title FROM Post P JOIN FriendAccapte FA ON P.Uid = FA.Uid

--DISPLAY POST BUT CATAGORIES VISE
SELECT P.Pid,P.Description,P.Image,P.Likes,P.Title FROM Post P JOIN Categories C ON 
P.Category_ID = C.Category_ID where C.Category_Name = 'Art'

--UPDATE POST LIKE
DECLARE @POSTID INT
SET @POSTID = 1
UPDATE Post SET Likes = Likes + 1 WHERE Pid = @POSTID

--ADD POST BY FRIEND
INSERT INTO Post VALUES ('photos','check this post','img_10',20,1,1),
	('like photo','check this post','img_101',10,2,3),
	('educational','post','img_101',20,7,4),
	('pubg','player','img_20',31,8,6),
	('dr.','operation','img_31',2,6,5),
	('new place','check out this post','img_100',30,1,4),
	('sport','fun news','img_110',24,2,5),
	('bajaj','loan work','img_50',2,4,5),
	('decoration','fastival decor','img_21',30,10,8)

--UPDATE POST BUT FRIEND
UPDATE [dbo].[Post]
   SET [Title] = <Title, varchar(20),>
      ,[Description] = <Description, varchar(100),>
      ,[Image] = <Image, varchar(100),>
      ,[Likes] = <Likes, int,>
      ,[Category_ID] = <Category_ID, int,>
      ,[Uid] = <Uid, int,>

--DELETE POST 

DELETE FROM [dbo].[Post]


--FRIEND ACCAPTE TABLE DATA
INSERT INTO FriendAccapte VALUES (1,3),
	(2,3),
	(2,4),
	(1,5),
	(2,6),
	(5,4),
	(1,2),
	(3,4)

--DISPLAY FRIEND

SELECT U.Uid,U.Name FROM FriendAccapte FA JOIN Users U ON FA.Uid = U.Uid WHERE FA.Frid = 3

--UN FRIEND
DECLARE @UNFriendAccid INT
SET @UNFriendAccid = 1
DELETE FROM [dbo].[FriendAccapte] WHERE FriendAccapteid = @UNFriendAccid 

-- send friend request 
INSERT INTO FriendRequest VALUES (1,3),
	(2,3),
	(2,4),
	(1,5),
	(2,6),
	(5,4),
	(1,2),
	(3,4)

GO
SELECT * FROM [FriendRequest]
-- dispaly friend request by id
SELECT a.Name,a.Uid FROM Users a JOIN FriendRequest b ON a.Uid = b.Frid_r WHERE b.Uid_s = 1  
-- delete request 
DELETE FROM FriendRequest WHERE Frid_r = 1  AND Uid_s  = 1
--  acceapte request


INSERT INTO FriendAccapte VALUES ((SELECT Uid_s FROM FriendRequest WHERE FriendRequestid = 6),
                                  (SELECT Frid_r FROM FriendRequest WHERE FriendRequestid = 6)) 
DELETE FROM FriendRequest WHERE FriendRequestid = 6
SELECT * FROM FriendAccapte 
SELECT * FROM FriendRequest



--Select convert(varchar(100),DecryptByPassPhrase('key',@Encrypt )) as Decrypt  
--Declare @Encrypt varbinary(200)  
--Select @Encrypt = EncryptByPassPhrase('key', 'Jothish' )  
--Select @Encrypt as Encrypt 


SELECT * FROM Chat