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
Users_Locationid int not null CONSTRAINT Cityid_Users FOREIGN KEY  REFERENCES  Location(Locationid) ON DELETE CASCADE ON UPDATE CASCADE,
Address nvarchar(200) not null,
Email nvarchar(50) not null CONSTRAINT Email_validation CHECK(Email LIKE '%_@__%.__%'),
PhoneNumber varchar(10) not null CONSTRAINT pn CHECK(PhoneNumber LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),
Created_date DATE  DEFAULT GETDATE(),
Dateofbirth DATE not null,
Visible TINYINT DEFAULT 1 CONSTRAINT employees_date CHECK(Visible IN (0,1)), 
Password varbinary(200) not null,
Gender not null nchar(1)  CONSTRAINT employees_Gender check(Gender IN('M','F','O')) 
)
CREATE TABLE Categories
(
Category_ID smallint constraint PK_Categories_Category_ID PRIMARY KEY IDENTITY(1,1),
Category_Name varchar(20) not null
)

CREATE TABLE Post
(
Pid int  not null CONSTRAINT pid_Post PRIMARY KEY  IDENTITY(1,1),
Title nvarchar(20) not null,
Description ntext not null,
Likes int DEFAULT 0,
Post_Category_ID smallint not null CONSTRAINT Category_ID_Post FOREIGN KEY  REFERENCES  Categories(Category_ID) ON DELETE CASCADE ON UPDATE CASCADE,
Post_Uid int not null CONSTRAINT uid_Post FOREIGN KEY  REFERENCES  Users(Uid) ON DELETE CASCADE ON UPDATE CASCADE,
Post_Date Date DEFAULT GETDATE()
)

CREATE TABLE FriendRequest
(
FriendRequestid int  CONSTRAINT FriendRequestid_Post PRIMARY KEY  IDENTITY(1,1),
FriendRequest_Uid int  not null CONSTRAINT Uid_s_FriendRequest FOREIGN KEY  REFERENCES  Users(Uid) ,
FriendRequest_Frid int not null CONSTRAINT Frid_r_FriendRequest FOREIGN KEY  REFERENCES  Users(Uid),
CONSTRAINT unique_FriendRequest UNIQUE(FriendRequest_Uid,FriendRequest_Frid),
FriendStatus bit not null,
Requested_Date DATE  not null DEFAULT GETDATE(),
 Approved_Date DATE 
)
--add columns in FriendRequest
 ALTER TABLE FriendRequest ALTER COLUMN FriendStatus bit  not null 
 ALTER TABLE FriendRequest ADD  Requested_Date DATE  not null DEFAULT GETDATE()
 ALTER TABLE FriendRequest ADD  Approved_Date DATE  null
/*CREATE TABLE FriendAccept
(
FriendAccapteid int   CONSTRAINT FriendAccapteid_FriendAccapte PRIMARY KEY  IDENTITY(1,1),
Uid int not null CONSTRAINT Uid_FriendAccapte FOREIGN KEY  REFERENCES  Users(Uid) ,
Frid int not null CONSTRAINT Frid_FriendAccapte FOREIGN KEY  REFERENCES  Users(Uid),
CONSTRAINT unique_FriendAccapte UNIQUE(Uid,Frid)
)*/
CREATE TABLE Chat
(
Chat_id int PRIMARY KEY IDENTITY(1,1),
Sender int not null CONSTRAINT SEND_FK FOREIGN KEY REFERENCES Users(uid),
Receiver int not null CONSTRAINT RECEIVE_FK FOREIGN KEY REFERENCES Users(uid),
Msg ntext not null,
Msg_Time datetime DEFAULT GETDATE()
)

Create Table Comment(
Comment_Id INT CONSTRAINT PK_Comment_Comment_Id PRIMARY KEY IDENTITY(1,1),
Comment_Text NVARCHAR(100),
Comment_Uid INT not null Constraint Ufk FOREIGN key REFERENCES USERS(Uid),
Comment_Pid INT not null Constraint Pfk FOREIGN key REFERENCES Post(Pid)
)
-- add Likebyuser Table 
CREATE TABLE Likebyuser
(
Likeid int  not null CONSTRAINT Likeid_Likebyuser PRIMARY KEY  IDENTITY(1,1),
LikebyUser_Pid int not null CONSTRAINT Pid_Likebyuser FOREIGN KEY  REFERENCES  Post(Pid) ON DELETE CASCADE ON UPDATE CASCADE,
LikebyUser_Uid int not null CONSTRAINT Uid_Likebyusers FOREIGN KEY  REFERENCES  Users(Uid) 
)

-- group table
CREATE TABLE Groups
(
GroupId int CONSTRAINT PK_Groups_GroupID PRIMARY KEY IDENTITY(1,1),
Grp_Name varchar(30) not null,
Grp_Description varchar(100) not null,
Created_By int not null CONSTRAINT grp_lead FOREIGN KEY REFERENCES Users(Uid),
CreatedAt datetime default GETDATE()
)

-- group members
CREATE TABLE GroupMember
(
GrpMembar_id int CONSTRAINT PK_GroupMember_GrpMembar_id PRIMARY KEY IDENTITY(1,1),
Group_id int not null CONSTRAINT grp_member FOREIGN KEY REFERENCES Groups(GroupId) ON DELETE CASCADE ON UPDATE CASCADE,
GroupMember_Uid int not null CONSTRAINT grpUid FOREIGN KEY REFERENCES Users(Uid) ON DELETE CASCADE ON UPDATE CASCADE,
Date_joined date DEFAULT GETDATE(),
CONSTRAINT unqMember UNIQUE(Group_id,UserId)
)

-- group message
CREATE TABLE GroupMessage
(
GroupMessage_Groupid INT NOT NULL CONSTRAINT PK_GroupMessage_Groupid PRIMARY KEY IDENTITY(1,1),
Grp_id INT NOT NULL CONSTRAINT grpid FOREIGN KEY REFERENCES Groups(GroupId),
GroupMessage_Uid INT NOT NULL CONSTRAINT grpMsgUid FOREIGN KEY REFERENCES Users(Uid),
Message NTEXT NOT NULL,
Sendtime Datetime DEFAULT GETDATE()
)

--Tags Table
CREATE TABLE Tags(
	Tag_ID INT CONSTRAINT PK_Tag_ID PRIMARY KEY IDENTITY(1,1),
	Tags_Pid INT NOT NULL CONSTRAINT FK_Tags_Post_Tags_Pid FOREIGN KEY REFERENCES Post(Pid),
	Tags_Uid INT NOT NULL CONSTRAINT FK_Tags_Users_Tags_Uid FOREIGN KEY REFERENCES Users(Uid)
)

ALTER TABLE Tags
ADD CONSTRAINT UNIQUE_Tags UNIQUE(Tags_Pid,Tags_Uid)

-- Master table
CREATE TABLE Master
(
Master_id INT NOT NULL CONSTRAINT PK_Master_Master_id PRIMARY KEY IDENTITY(1,1),
Master_Value VARCHAR(20) NOT NULL ,
Master_SubValue VARCHAR(20) NOT NULL
)


-- Insert data in master
INSERT INTO Master VALUES
('Visibility','Private'),
('Visibility','Public'),
('Gender','Male'),
('Gender','Female'),
('Gender','Other'),
('Status','Online'),
('Status','Offline')

--Insert data in Tags
INSERT INTO Tags VALUES 
	(1,2),(2,1),(2,5),(2,4),(3,5),(4,3)

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
((SELECT DISTINCT Uid_s FROM FriendRequest WHERE Uid_s = 2) ,(SELECT DISTINCT Frid_r FROM FriendRequest WHERE Frid_r = 4),'hi','2021-08-19 16:21:22.713')

INSERT INTO Chat VALUES
((SELECT DISTINCT Uid_s FROM FriendRequest WHERE Uid_s = 2) ,(SELECT DISTINCT Frid_r FROM FriendRequest WHERE Frid_r = 4),'how are you','2021-08-19 16:22:22.713'),
((SELECT DISTINCT Frid_r FROM FriendRequest WHERE Frid_r = 4) ,(SELECT DISTINCT Uid_s FROM FriendRequest WHERE Uid_s = 2),'I am fine','2021-08-19 17:22:22.713')

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
SELECT P.Pid,P.Description,P.Image,P.Likes,P.Title FROM Post P JOIN FriendAccept FA ON P.Uid = FA.Uid

--DISPLAY POST BUT CATAGORIES VISE
SELECT P.Pid,P.Description,P.Image,P.Likes,P.Title FROM Post P JOIN Categories C ON 
P.Category_ID = C.Category_ID where C.Category_Name = 'Art'

--UPDATE POST LIKE
DECLARE @POSTID INT
SET @POSTID = 1
UPDATE Post SET Likes = Likes + 1 WHERE Pid = @POSTID

--ADD POST BY FRIEND
	INSERT INTO [dbo].[Post]
           ([Title]
           ,[Description]
           ,[Image]
           ,[Likes]
           ,[Category_ID]
           ,[Uid]
           ,[Post_Date])
     VALUES
         
		    ('photos','check this post','img_10.png',20,1,1,GETDATE()),
	('like photo','check this post','img_101.png',10,2,3,GETDATE()),
	('educational','post','img_101.png',20,7,4,GETDATE()),
	('pubg','player','img_20.png',31,8,6,GETDATE()),
	('dr.','operation','img_31.png',2,6,5,GETDATE()),
	('new place','check out this post','img_100.png',30,1,4,GETDATE()),
	('sport','fun news','img_110.png',24,2,5,GETDATE()),
	('bajaj','loan work','img_50.png',2,4,5,GETDATE()),
	('decoration','fastival decor','img_21.png',30,23,8,GETDATE())
GO


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
/*INSERT INTO FriendAccept VALUES (1,3),
	(2,3),
	(2,4),
	(1,5),
	(2,6),
	(5,4),
	(1,2),
	(3,4)*/

--UN FRIEND NEEL AND JAY
DELETE FROM FriendRequest WHERE FriendRequest_Uid = (SELECT Uid FROM Users WHERE Name='Neel') AND
  FriendRequest_Frid = (SELECT uid FROM Users WHERE Name='Jay')

--TODAY'S Tranding post like vias
SELECT P.Pid,P.Title,P.Likes,P.Post_Date FROM Post P WHERE P.Post_Date = CONVERT(DATE,GETDATE())  ORDER BY P.Likes DESC

--Display 18+ user name
SELECT Name AS '18+ NAME',DATEDIFF(YY,dateofbirth,getdate()) as age FROM Users WHERE DATEDIFF(YY,dateofbirth,getdate())>18

--less than 18 to not show album , financial service,home improvement etc. like categories post

SELECT * FROM Post WHERE Post_Category_ID IN 
(SELECT Category_ID FROM Categories WHERE Category_Name NOT IN ('album','financial service','home improvement'))
AND (SELECT DATEDIFF(YY,dateofbirth,GETDATE()) FROM Users WHERE Uid = 9)<18

--search post by name of user
SELECT P.Pid,P.Title,P.Likes FROM Post P JOIN Users U ON U.Uid = P.Uid WHERE U.Name = 'Jay'

--search post by categories name
SELECT P.Pid,P.Title,P.Likes FROM Post P JOIN Categories C ON C.Category_ID = P.Post_Category_ID
WHERE C.Category_Name = 'Album'


-- send friend request 
INSERT INTO FriendRequest VALUES 
	(1,5,0),
	(2,6,0),
	(5,4,0),
	(1,2,0),
	(3,4,0)

GO
SELECT * FROM [FriendRequest]
-- dispaly friend request by id
SELECT a.Name,a.Uid FROM Users a JOIN FriendRequest b ON a.Uid = b.Frid_r WHERE b.Uid_s = 1  
-- delete request 
DELETE FROM FriendRequest WHERE Frid_r = 1  AND Uid_s  = 1
--  acceapte request


/*INSERT INTO FriendAccept VALUES ((SELECT Uid_s FROM FriendRequest WHERE FriendRequestid = 6),
                                  (SELECT Frid_r FROM FriendRequest WHERE FriendRequestid = 6)) 
DELETE FROM FriendRequest WHERE FriendRequestid = 6
SELECT * FROM FriendAccept */
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
SELECT fa.Frid_r FROM FriendRequest fa
WHERE fa.Uid_s = 2
INTERSECT
SELECT fa.Frid_r FROM FriendRequest fa
WHERE fa.Uid_s = 5
)


-- All users with its category name of Post

SELECT u.Name,p.Pid,p.Title,c.Category_ID,c.Category_Name FROM Users u
	LEFT JOIN Post p ON p.Uid = u.Uid
	LEFT JOIN Categories c ON c.Category_ID = p.Category_ID




-- List of friends
SELECT f.Frid_r,(SELECT u.Name FROM Users u WHERE u.Uid = f.Frid_r) as 'friend_name' FROM FriendRequest f
	JOIN Users u ON u.Uid = f.Uid_s 
WHERE u.Name = 'Prit'
ORDER BY f.Frid_r



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
WHERE Uid NOT IN (SELECT Uid_s FROM FriendRequest UNION SELECT Frid_r FROM FriendRequest)



-- Users with total friends
SELECT u.Uid,
		u.Name,
		(SELECT COUNT(f.Frid_r) FROM FriendRequest f WHERE f.Uid_s = u.Uid GROUP BY f.Uid_s) as 'No of friends'
FROM Users u

-- friend suggestions 
SELECT Name,Uid FROM  Users WHERE  Uid <>1  AND Uid  IN (Select DISTINCT FriendRequest_Uid FROM 
FriendRequest WHERE  FriendStatus  =1 AND FriendRequest_Frid  
IN(SELECT FriendRequest_Frid FROM FriendRequest WHERE FriendRequest_Uid  =1 AND FriendStatus  =1)) OR Uid 
IN (Select DISTINCT FriendRequest_Frid FROM  FriendRequest WHERE  FriendStatus  =1 AND FriendRequest_Uid  
IN(SELECT FriendRequest_Frid FROM FriendRequest WHERE FriendRequest_Uid  =1 AND FriendStatus =1)) 



/*1. Write a query to display all details of private account */

select * from Users where Visible = 1;

/*2. Write query to display total account from perticular city */

select count(uid) "Account",City 
from Users 
JOIN Location
ON Users.Locationid = Location.Locationid
group by city order by Account DESC

/*3. Write a query to display name and city of users who are from rajkot or Mumbai*/

select Name,city
from Users
JOIN Location
ON Users.Locationid = Location.Locationid
where Location.City IN ('Rajkot','Mumbai')

/*4. write a query to display category name start with H*/

select category_name from Categories where Category_Name like 'H%'

/*5. Write a query to display title of post and catagary name of user neeel*/

select name,Title,Category_Name 
from Users
join Post
on Users.Uid=post.Uid
join Categories
on Categories.Category_ID = post.Category_ID
where Users.Name = 'Neel'

/*6. write a query to display friend name of user Romish*/

Select name from Users where Uid IN
(Select Frid_r from FriendRequest where FriendStatus = 1 AND Uid_s = 
(Select uid from users where name = 'Romish'))
OR
Uid IN
(Select Uid_s from FriendRequest where FriendStatus = 1 AND Frid_r = 
(Select uid from users where name = 'Romish'))


/*7. write a query to display all the message send by prit*/

select Msg from Chat
join Users
on users.Uid = chat.Sender
where name = 'Prit' 

/*8. write a query to display catagory all categories used by user order by category name*/

select Category_Name from Categories where Category_ID IN (select Category_ID from Post) ORDER by Category_Name

/*9. write a query display category name which is never possted by any user*/

select category_ID, category_name from Categories where Category_ID NOT IN (select Category_ID from post)

/*10. Write a query to display comment made by Prit*/

Select Comment_Text from Comment where Uid = 
(select Uid from users where name = 'Prit')

/*11. Write a query to display comment made on vivek's post*/

select comment_text from comment where pid IN 
(select pid from post where uid = 
(select uid from users where name = 'vivek'))

/*12. Write a query to display comment made on pratik's post with username*/

select comment_text,name from comment 
join users 
on Comment.Uid = Users.Uid 
where pid IN 
(select pid from post where uid = 
(select uid from users where name = 'pratik'))

/*13. Write a query to display a name of user with post title on which maximum comments are made*/

select Users.Uid,Users.name,Post.pid,Post.title 
from Post 
JOIN Users
ON Post.Uid = Users.Uid
where pid = 
(select pid from 
(select TOP 1 count(pid) "comment",pid 
from comment group by pid order by comment DESC )temp)


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


----- Like ------

--TODAY'S Tranding post like vias
SELECT Pid,Title,Likes,Post_Date FROM Post  WHERE Post_Date = CONVERT(DATE,GETDATE())  ORDER BY Likes DESC

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
DELETE Likebyuser WHERE LikebyUser_Pid = 4 AND LikebyUser_Uid = 1

--display post like by user
SELECT * FROM Post WHERE Pid IN(SELECT LikebyUser_Pid FROM Likebyuser WHERE LikebyUser_Uid = 1)

-- who likes the post 
SELECT a.Name,a.Uid FROM Users a JOIN Likebyuser b ON a.Uid = b.LikebyUser_Uid WHERE LikebyUser_Pid = 3


 
-- display post by your friends likes
   SELECT a.Pid,a.Title,a.Description,c.Image,a.Likes,b.Category_Name,a.Post_Date,a.Post_Uid
   FROM Post a JOIN Categories b ON a.Post_Category_ID = b.Category_ID JOIN Image c ON c.Imageid = a.Pid
   WHERE b.Category_ID IN (SELECT a.Post_Category_ID FROM POST a JOIN
   Likebyuser b ON a.Pid = b.LikebyUser_Pid WHERE b.LikebyUser_Uid = 2)

--  display recommended post like by your friend 
SELECT a.Pid,a.Title,a.Description,c.Image,a.Likes,b.Category_Name,a.Post_Date,a.Post_Uid FROM Post a JOIN Categories b
ON a.Post_Category_ID = b.Category_ID JOIN Image c ON c.Imageid = a.Pid
WHERE a.Pid IN(SELECT Pid FROM Likebyuser WHERE LikebyUser_Uid IN (SELECT Uid FROM  Users WHERE
Uid  IN (Select DISTINCT Uid FROM  FriendRequest WHERE FriendRequest_Frid = 5  AND FriendStatus = 1)
OR  Uid  IN (Select DISTINCT FriendRequest_Frid FROM  FriendRequest WHERE FriendRequest_Uid  = 5 AND FriendStatus = 1))) 
--
--  acceapt request
UPDATE FriendRequest SET FriendStatus = 1, Approved_Date = GETDATE() WHERE FriendRequest_Uid = 1 AND FriendRequest_Frid = 5

INSERT INTO Groups VALUES
('grp1','this is our college group',2,'2021-01-01'),
('grp2','this is our School group',3,'2021-02-01'),
('grp3','this is our office group',4,'2021-03-01'),
('grp4','this is our Apartment group',5,'2021-04-04'),
('grp5','this is our Friends group',2,'2021-08-05')


INSERT INTO GroupMember VALUES
(1,(SELECT uid FROM Users WHERE Uid = 1),'2021-01-02'),
(1,(SELECT uid FROM Users WHERE Uid = 2),'2021-01-01'),
(1,(SELECT uid FROM Users WHERE Uid = 3),'2021-01-02'),
(1,(SELECT uid FROM Users WHERE Uid = 4),'2021-01-02'),
(2,(SELECT uid FROM Users WHERE Uid = 3),'2021-02-01'),
(2,(SELECT uid FROM Users WHERE Uid = 5),'2021-02-02'),
(2,(SELECT uid FROM Users WHERE Uid = 6),'2021-02-02'),
(5,(SELECT uid FROM Users WHERE Uid = 4),'2021-08-06'),
(5,(SELECT uid FROM Users WHERE Uid = 5),'2021-08-06'),
(5,(SELECT uid FROM Users WHERE Uid = 2),'2021-08-05')

INSERT INTO GroupMessage([GroupMessage_Groupid],GroupMessage_Uid,Message) VALUES
(1,(SELECT [GroupMember_Uid] FROM GroupMember WHERE Group_id = 1 AND [GroupMember_Uid] = 2 ),'hello every one'),
(1,(SELECT [GroupMember_Uid] FROM GroupMember WHERE Group_id = 1 AND [GroupMember_Uid] = 3 ),'hi how are you'),
(2,(SELECT [GroupMember_Uid] FROM GroupMember WHERE Group_id = 2 AND [GroupMember_Uid] = 3 ),'hello'),
(2,(SELECT [GroupMember_Uid] FROM GroupMember WHERE Group_id = 2 AND [GroupMember_Uid] = 5 ),'good morning'),
(2,(SELECT [GroupMember_Uid] FROM GroupMember WHERE Group_id = 2 AND [GroupMember_Uid] = 6 ),'good evening'),
(5,(SELECT [GroupMember_Uid] FROM GroupMember WHERE Group_id = 5 AND [GroupMember_Uid] = 4 ),'happy journey'),
(5,(SELECT [GroupMember_Uid] FROM GroupMember WHERE Group_id = 5 AND [GroupMember_Uid] = 5 ),'take care'),
(5,(SELECT [GroupMember_Uid] FROM GroupMember WHERE Group_id = 5 AND [GroupMember_Uid] = 5 ),'Good night')



-- Queries for group chat

-- Query to see names of all groups
SELECT grp_name,GroupId FROM Groups 

-- chat of group 1
SELECT m.Message,u.Name FROM GroupMessage m
	JOIN Users u ON u.Uid = m.UserID
WHERE m.grp_id = 1

-- Members of groupid 5
SELECT gm.UserId,u.Name FROM GroupMember gm
	JOIN Users u ON u.Uid = gm.UserId
WHERE gm.Group_id = 5


-- name of all members with group name 
SELECT * FROM GroupMember gm
	JOIN Users u ON u.Uid = gm.UserId


-- display user name who is in more than 1 group
SELECT u.Name FROM Users u
	JOIN GroupMember m ON m.UserId = u.Uid
GROUP BY u.Name
HAVING COUNT(m.Group_id) > 1


-- Name of group with no members
SELECT g.grp_name,g.GroupId FROM Groups g
WHERE g.GroupId NOT IN (SELECT gm.Group_id FROM GroupMember gm)


-- Group with max members
SELECT * FROM 
(SELECT DENSE_RANK() OVER(ORDER BY COUNT(g.GroupId) DESC) as 'rank',g.grp_name,COUNT(g.GroupId) as 'totalMember' FROM Groups g
	JOIN GroupMember gm ON gm.Group_id = g.GroupId
GROUP BY g.grp_name) temp
WHERE rank = 1


-- location
SELECT * FROM dbo.Location



-- added data for user status column
ALTER TABLE Users
ADD Status int CONSTRAINT chk_status FOREIGN KEY REFERENCES Master(Master_id)

ALTER TABLE Users
ADD CONSTRAINT status_check CHECK(Status IN (6,7))

UPDATE Users
SET Status = 6 WHERE Uid = 1

UPDATE Users
SET Status = 6 WHERE Uid IN (2,3,5,8)

UPDATE Users
SET Status = 7 WHERE Uid IN (4,6,7,9)

/*Added Image Table in database*/
Create table Image
( Imageid int,
  Image nvarchar(MAX) not null CONSTRAINT img CHECK(Image LIKE('%.png')) );

  INSERT INTO Image
  Values
  (1,'img_01.png'),
  (1,'img_02.png'),
  (2,'img_03.png'),
  (2,'img_04.png'),
  (2,'img_05.png'),
  (2,'img_06.png'),
  (3,'img_07.png'),
  (4,'img_08.png'),
  (4,'img_09.png'),
  (5,'img_11.png'),
  (6,'img_12.png'),
  (7,'img_13.png'),
  (8,'img_14.png'),
  (8,'img_15.png'),
  (8,'img_16.png'),
  (9,'img_17.png'),
  (9,'img_18.png')

  /*Deleted image column from post and updated image table*/

Alter table post
DROP constraint post_Image

Alter table post
DROP column Image

ALTER TABLE Image
ADD CONSTRAINT Ipid FOREIGN KEY (Imageid) REFERENCES POST(Pid)




ALTER TABLE Users
DROP CONSTRAINT employees_Gender

UPDATE Users
SET Gender = 3 WHERE Gender = 'M'


UPDATE Users
SET Gender = 4 WHERE Gender = 'F'


UPDATE Users
SET Gender = 5 WHERE Gender = 'O'

ALTER TABLE Users
ADD CONSTRAINT gender_ckh check(Gender IN(3,4,5)) 


ALTER TABLE Users
DROP CONSTRAINT employees_date


UPDATE Users
SET Visible = 2 WHERE Visible = 1

UPDATE Users
SET Visible = 1 WHERE Visible = 0


ALTER TABLE Users
ADD CONSTRAINT visibility_chk check(Visible IN(1,2))
/*Updated Image table*/

ALTER TABLE Image
ALTER COLUMN Imageid INT NOT NULL

Alter table Image
DROP constraint Ipid

ALTER TABLE Image
ADD CONSTRAINT Ipid FOREIGN KEY (Imageid) REFERENCES POST(Pid) ON DELETE CASCADE ON UPDATE CASCADE


