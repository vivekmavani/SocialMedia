-- create database
CREATE DATABASE socialmedia1

USE socialmedia1
Create Table Location(
Locationid INT PRIMARY KEY IDENTITY(1,1),
City VARCHAR(20) not null,
State VARCHAR(20) not null,
Country VARCHAR(20) not null,
)


CREATE TABLE Users
(
Uid int  CONSTRAINT uid_User PRIMARY KEY  IDENTITY(1,1),
Name varchar(50) not null,
Locationid int  CONSTRAINT Cityid_Users FOREIGN KEY  REFERENCES  Location(Locationid) ON DELETE CASCADE ON UPDATE CASCADE,
Address nvarchar(200) not null,
Email nvarchar(50) not null CONSTRAINT Email_validation CHECK(Email LIKE '%_@__%.__%'),
PhoneNumber varchar(10) not null CONSTRAINT pn CHECK(PhoneNumber LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),
Created_date DATE  DEFAULT GETDATE(),
Dateofbirth DATE not null,
Visible TINYINT DEFAULT 1 CONSTRAINT employees_date CHECK(Visible IN (0,1)), 
Password varbinary(200) not null,
Gender varchar(2)  CONSTRAINT employees_Gender check(Gender IN('M','F','O')) 
)
CREATE TABLE Categories
(
Category_ID int PRIMARY KEY IDENTITY(1,1),
Category_Name varchar(20) not null
)

CREATE TABLE Post
(
Pid int  not null CONSTRAINT pid_Post PRIMARY KEY  IDENTITY(1,1),
Title nvarchar(20) not null,
Description ntext not null,
Image nvarchar(MAX) not null CONSTRAINT Post_Image CHECK(Image LIKE('%.png')),
Likes int DEFAULT 0,
Category_ID int not null CONSTRAINT Category_ID_Post FOREIGN KEY  REFERENCES  Categories(Category_ID) ON DELETE CASCADE ON UPDATE CASCADE,
Uid int not null CONSTRAINT uid_Post FOREIGN KEY  REFERENCES  Users(Uid) ON DELETE CASCADE ON UPDATE CASCADE,
Post_Date Date DEFAULT GETDATE()
)

CREATE TABLE FriendRequest
(
FriendRequestid int  CONSTRAINT FriendRequestid_Post PRIMARY KEY  IDENTITY(1,1),
Uid_s int  not null CONSTRAINT Uid_s_FriendRequest FOREIGN KEY  REFERENCES  Users(Uid) ,
Frid_r int not null CONSTRAINT Frid_r_FriendRequest FOREIGN KEY  REFERENCES  Users(Uid),
CONSTRAINT unique_FriendRequest UNIQUE(Uid_s,Frid_r)
)

CREATE TABLE FriendAccapte
(
FriendAccapteid int   CONSTRAINT FriendAccapteid_FriendAccapte PRIMARY KEY  IDENTITY(1,1),
Uid int not null CONSTRAINT Uid_FriendAccapte FOREIGN KEY  REFERENCES  Users(Uid) ,
Frid int not null CONSTRAINT Frid_FriendAccapte FOREIGN KEY  REFERENCES  Users(Uid),
CONSTRAINT unique_FriendAccapte UNIQUE(Uid,Frid)
)
CREATE TABLE Chat
(
Chat_id int PRIMARY KEY IDENTITY(1,1),
Sender int not null CONSTRAINT SEND_FK FOREIGN KEY REFERENCES Users(uid),
Receiver int not null CONSTRAINT RECEIVE_FK FOREIGN KEY REFERENCES Users(uid),
Msg ntext not null,
msg_time datetime DEFAULT GETDATE()
)

Create Table Comment(
Comment_Id INT PRIMARY KEY IDENTITY(1,1),
Comment_Text NVARCHAR(100),
Uid INT not null Constraint Ufk FOREIGN key REFERENCES USERS(Uid),
Pid INT not null Constraint Pfk FOREIGN key REFERENCES Post(Pid)
)
-- add Likebyuser Table 
CREATE TABLE Likebyuser
(
Likeid int  not null CONSTRAINT Likeid_Likebyuser PRIMARY KEY  IDENTITY(1,1),
Pid int  CONSTRAINT Pid_Likebyuser FOREIGN KEY  REFERENCES  Post(Pid) ON DELETE CASCADE ON UPDATE CASCADE,
Uid int not null CONSTRAINT Uid_Likebyusers FOREIGN KEY  REFERENCES  Users(Uid) 
)

-- group table
CREATE TABLE Groups
(
GroupId int not null PRIMARY KEY IDENTITY(1,1),
grp_name varchar(30) not null,
grp_description varchar(100) not null,
created_by int not null CONSTRAINT grp_lead FOREIGN KEY REFERENCES Users(Uid),
createdAt datetime default GETDATE()
)

-- group members
CREATE TABLE GroupMember
(
GrpMembar_id int not null PRIMARY KEY IDENTITY(1,1),
Group_id int not null CONSTRAINT grp_member FOREIGN KEY REFERENCES Groups(GroupId) ON DELETE CASCADE ON UPDATE CASCADE,
UserId int not null CONSTRAINT grpUid FOREIGN KEY REFERENCES Users(Uid) ON DELETE CASCADE ON UPDATE CASCADE,
date_joined date DEFAULT GETDATE(),
CONSTRAINT unqMember UNIQUE(Group_id,UserId)
)

-- group message
CREATE TABLE GroupMessage
(
grpMsg_id int not null PRIMARY KEY IDENTITY(1,1),
grp_id int not null CONSTRAINT grpid FOREIGN KEY REFERENCES Groups(GroupId),
UserID int not null CONSTRAINT grpMsgUid FOREIGN KEY REFERENCES Users(Uid),
Message ntext not null,
Sendtime Datetime DEFAULT GETDATE()
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

INSERT INTO [dbo].[Location]
           ([City]
           ,[State]
           ,[Country])
     VALUES
           ('Bhavnagar'
           ,'Gujarat'
           ,'India'),
		    ('Rajkot'
           ,'Gujarat'
           ,'India'),
		    ('Ahmedabad'
           ,'Gujarat'
           ,'India'),
		    ('Surat'
           ,'Gujarat'
           ,'India'),
		     ('Mumbai'
           ,'Maharashtra'
           ,'India'),
		    ('Pune'
           ,'Maharashtra'
           ,'India')
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

INSERT INTO [dbo].[Users]
           ([Name]
           ,[Locationid]
           ,[Address]
           ,[Email]
           ,[PhoneNumber]
           ,[Created_date]
           ,[Dateofbirth]
           ,[Visible]
           ,[Password]
           ,[Gender])
     VALUES
          ('Romish',1,'Address 1','romish@gmail.com',2545874962,GETDATE(),'1999-02-01',0,EncryptByPassPhrase('key', 'romish123' ),'M'),
('Prit',1,'Address 2','prit@gmail.com',7458963215,GETDATE(),'1998-02-01',1,EncryptByPassPhrase('key', 'prit123' ),'M'),
('Vivek',2,'Address 3','Vivek@gmail.com',1205874965,GETDATE(),'1997-02-01',1,EncryptByPassPhrase('key', 'vivek123' ),'M'),
('Neel',2,'Address 4','nell@gmail.com',9657432018,GETDATE(),'1996-02-01',0,EncryptByPassPhrase('key', 'neel135' ),'M'),
('Jay',2,'Address 5','jay@gmail.com',7452013601,GETDATE(),'1995-02-01',0,EncryptByPassPhrase('key', 'jay456' ),'M'),
('Pratik',3,'Address 6','pratik@gmail.com',9658002341,GETDATE(),'1994-02-01',0,EncryptByPassPhrase('key', 'pratik123' ),'M'),
('Karan',4,'Address 7','karan@gmail.com',1234567890,GETDATE(),'1993-02-01',0,EncryptByPassPhrase('key', 'karan147' ),'M'),
('Veera',5,'Address 8','veer@gmail.com',1518960214,GETDATE(),'1992-02-01',0,EncryptByPassPhrase('key', 'veer123' ),'O'),
('Meena',6,'Address 9','meet@gmail.com',7850123604,GETDATE(),'1991-02-01',0,EncryptByPassPhrase('key', 'meet745' ),'F');
GO

update Users
set Visible = 1 
where Uid IN (6,7)


select * from Users
--Decrypt
Select Name,City,Email,PhoneNumber,convert(varchar(100),DecryptByPassPhrase('key',Password )) as Password from Users
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

--TODAY'S Tranding post like vias
SELECT P.Pid,P.Title,P.Likes,P.Post_Date FROM Post P WHERE P.Post_Date = CONVERT(DATE,GETDATE())  ORDER BY P.Likes DESC

--Display 18+ user name
SELECT Name AS '18+ NAME',DATEDIFF(YY,dateofbirth,getdate()) as age FROM Users WHERE DATEDIFF(YY,dateofbirth,getdate())>18

--less than 18 to not show album , financial service,home improvement etc. like categories post

SELECT * FROM Post WHERE Category_ID IN 
(SELECT Category_ID FROM Categories WHERE Category_Name NOT IN ('album','financial service','home improvement'))
AND (SELECT DATEDIFF(YY,dateofbirth,GETDATE()) FROM Users WHERE Uid = 9)<18

--search post by name of user
SELECT P.Pid,P.Title,P.Image,P.Likes FROM Post P JOIN Users U ON U.Uid = P.Uid WHERE U.Name = 'Jay'

--search post by categories name
SELECT P.Pid,P.Title,P.Image,P.Likes FROM Post P JOIN Categories C ON C.Category_ID = P.Category_ID
WHERE C.Category_Name = 'Album'


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

SELECT * FROM Categories

SELECT * FROM Users

-- Display category name of user post

SELECT c.Category_Name FROM Categories c
	INNER JOIN Post p ON p.Category_ID = c.Category_ID
	INNER JOIN Users u ON u.Uid = p.Uid
WHERE u.Name = 'Prit'


-- Display mutual friends

SELECT u.Name FROM Users u WHERE u.Uid IN 
(
SELECT fa.Frid FROM FriendAccapte fa
WHERE fa.Uid = 2
INTERSECT
SELECT fa.Frid FROM FriendAccapte fa
WHERE fa.Uid = 5
)


-- All users with its category name of Post

SELECT u.Name,p.Pid,p.Title,c.Category_ID,c.Category_Name FROM Users u
	LEFT JOIN Post p ON p.Uid = u.Uid
	LEFT JOIN Categories c ON c.Category_ID = p.Category_ID




-- List of friends
SELECT f.Frid,(SELECT u.Name FROM Users u WHERE u.Uid = f.Frid) as 'friend_name' FROM FriendAccapte f
	JOIN Users u ON u.Uid = f.Uid 
WHERE u.Name = 'Hiren'
ORDER BY f.Frid



-- List of users who have not posted anything
SELECT Name,Uid FROM Users
WHERE uid NOT IN (SELECT Uid FROM Post)


-- Number of Post of all users
SELECT COUNT(Pid) as 'no. of post',
		Uid,
		(SELECT Name FROM Users WHERE Uid = Post.Uid) as 'Name' 
FROM Post 
GROUP BY Uid



-- List of users with 0 friends
SELECT Uid FROM Users 
WHERE Uid NOT IN (SELECT Uid FROM FriendAccapte)



-- Users with total friends
SELECT u.Uid,
		u.Name,
		(SELECT COUNT(f.Frid) FROM FriendAccapte f WHERE f.Uid = u.Uid GROUP BY f.Uid) as 'No of friends'
FROM Users u

-- friend suggestions 
SELECT Name,Uid FROM  Users WHERE  Uid <>1  AND Uid  IN (Select DISTINCT Uid FROM  FriendAccapte WHERE Frid  
IN(SELECT Frid FROM FriendAccapte WHERE Uid  =1)) OR Uid  IN (Select DISTINCT Frid FROM  FriendAccapte WHERE Uid  
IN(SELECT Frid FROM FriendAccapte WHERE Uid  =1)) 



/*1. Write a query to display all details of private account */

select * from Users where Visible = 0;

/*2. Write query to display total account from city */

select count(uid) "Account",City from Users group by city order by Account DESC

/*3. Write a query to display name and city of users who are from rajkot or jamnagar*/

select Name,City from Users where City IN ('Rajkot','Jamnagar')

/*write a query to display category name start with H*/

select category_name from Categories where Category_Name like 'H%'

/*4. Write a query to display title of post and catagary name of user neeel*/

select name,Title,Category_Name 
from Users
join Post
on Users.Uid=post.Uid
join Categories
on Categories.Category_ID = post.Category_ID
where Users.Name = 'Neel'

/*5. write a query to display friend name of user romish*/

select u.name from Users "u" where u.Uid IN 
(select fa.frid from FriendAccapte "fa" where fa.uid = 
(select uid from Users where name = 'Romish')) 
OR
u.Uid IN 
(select fa.uid from FriendAccapte "fa" where fa.Frid = 
(select uid from Users where name = 'Romish'))

/*6. write a query to display all the message send by hiren*/

select Msg from Chat
join Users
on users.Uid = chat.Sender
where name = 'Hiren' 

/*7. write a query to display total number of friend of user hiren*/

select count(frid) from FriendAccapte as "friend of hiren" where Uid IN (select uid from users where name = 'Hiren')

/*8. write a query to display catagory all categories used by user order by category name*/

select Category_Name from Categories where Category_ID IN (select Category_ID from Post) ORDER by Category_Name

/*9. write a query display category name which is never possted by any user*/

select category_ID, category_name from Categories where Category_ID NOT IN (select Category_ID from post)

/* Comment table */


INSERT INTO Comment
Values
('Nice Pic',1,2),
('Beautifull',2,3),
('Great Picture',2,4),
('Good',5,3),
('Nice Place',3,6)

select * from Comment



--highest post in categories
SELECT DENSE_RANK() OVER(ORDER BY COUNT(P.PID) DESC),C.Category_Name,COUNT(P.Pid) FROM Categories C  JOIN Post P ON C.Category_ID = P.Category_ID
GROUP BY Category_Name

-- add dob in users
ALTER TABLE Users ADD dateofbirth DATE


-- Display username with max like on photo and users photo belongs to category name starts with A


SELECT TOP 1 u.name as 'name',MAX(p.Likes) as 'max_like' FROM Users u
	JOIN Post p ON p.Uid = u.Uid
	JOIN Categories c ON c.Category_ID = p.Category_ID
WHERE c.Category_Name LIKE 'A%'
GROUP BY u.Name
ORDER BY max_like DESC


-- List of users commented on Prit's post

SELECT c.Uid,u.Name FROM Comment c
	JOIN Users u ON u.Uid = c.Uid
WHERE c.Pid = (SELECT Uid FROM Users WHERE Name = 'prit')



-- Name of user on which Romish commented

SELECT u.Name FROM Users u
WHERE u.Uid IN 
( SELECT p.Uid FROM Post p WHERE p.Pid IN 
(SELECT c.Pid FROM Comment c WHERE c.Uid = (SELECT Uid FROM Users WHERE Name = 'Romish')))

/*10. Write a query to display comment made by Prit*/

Select Comment_Text from Comment where Uid = 
(select Uid from users where name = 'Prit')

/*11. Write a query to display comment made on vivek's post*/

select comment_text from comment where pid IN 
(select pid from post where uid = 
(select uid from users where name = 'vivek'))

/*12. Write a query to display comment made on vivek's post with username*/

select comment_text,name from comment 
join users 
on Comment.Uid = Users.Uid 
where pid IN 
(select pid from post where uid = 
(select uid from users where name = 'vivek'))

/*13. Write a query to display a post on which maximum comments are made*/

select title from post where pid = 
(select pid from 
(select TOP 1 count(pid) "comment",pid 
from comment group by pid order by comment DESC )temp)

----- Like ------

--TODAY'S Tranding post like vias
SELECT Pid,Title,Likes,dateofpost FROM Post  WHERE dateofpost = CONVERT(DATE,GETDATE())  ORDER BY Likes DESC

Select * FROM Likebyuser

--add like by users
DECLARE @POSTID INT
SET @POSTID = 4
UPDATE Post SET Likes = Likes + 1 WHERE Pid = @POSTID
INSERT INTO Likebyuser VALUES(@POSTID,1) 
UPDATE Post SET Likes = Likes + 1 WHERE Pid = 4
INSERT INTO Likebyuser VALUES(4,2) 
-- delete dislike by user
UPDATE Post SET Likes = Likes - 1 WHERE Pid = 4 AND Likes  <>0
DELETE Likebyuser WHERE Pid = 4 AND Uid = 1

--display post like by user
SELECT * FROM Post WHERE Pid IN(SELECT Pid FROM Likebyuser WHERE Uid = 1)

-- who likes the post 
SELECT a.Name,a.Uid FROM Users a JOIN Likebyuser b ON a.Uid = b.Uid WHERE Pid = 3


 
-- display post by your friends likes
   SELECT a.Pid,a.Title,a.Description,a.Image,a.Likes,b.Category_Name,a.dateofpost,a.Uid
   FROM Post a JOIN Categories b ON a.Category_ID = b.Category_ID WHERE b.Category_ID
   IN (SELECT a.Category_ID FROM POST a JOIN Likebyuser b ON a.Pid = b.Pid WHERE b.Uid = 1)

--  display recommended post like by your friend 
SELECT a.Pid,a.Title,a.Description,a.Image,a.Likes,b.Category_Name,a.dateofpost,a.Uid FROM Post a JOIN Categories b
ON a.Category_ID = b.Category_ID WHERE a.Pid IN(SELECT Pid FROM Likebyuser WHERE Uid IN (SELECT Uid FROM  Users WHERE
Uid  IN (Select DISTINCT Uid FROM  FriendAccapte WHERE Frid = 5)
OR  Uid  IN (Select DISTINCT Frid FROM  FriendAccapte WHERE Uid  = 5))) 

--
-- location
SELECT * FROM dbo.Location