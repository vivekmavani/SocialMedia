-- create database
CREATE DATABASE socialmedia1

USE socialmedia1

-- Location table
Create Table Location(
Locationid INT PRIMARY KEY IDENTITY(1,1),
City VARCHAR(20) not null,
State VARCHAR(20) not null,
Country VARCHAR(20) not null,
)



-- User table
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



-- Category Table
CREATE TABLE Categories
(
Category_ID smallint constraint PK_Categories_Category_ID PRIMARY KEY IDENTITY(1,1),
Category_Name varchar(20) not null
)



-- Post Table
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




-- FriendRequest Table
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



-- Chat table
CREATE TABLE Chat
(
Chat_id int PRIMARY KEY IDENTITY(1,1),
Sender int not null CONSTRAINT SEND_FK FOREIGN KEY REFERENCES Users(uid),
Receiver int not null CONSTRAINT RECEIVE_FK FOREIGN KEY REFERENCES Users(uid),
Msg ntext not null,
Msg_Time datetime DEFAULT GETDATE()
)




-- Comment Table
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




-- GroupMessageSeen Table
CREATE TABLE GroupMessageSeen(
	GroupMessageSeen_Groupid INT NOT NULL CONSTRAINT FKS_GroupMessageSeen_Groupid FOREIGN KEY REFERENCES dbo.GroupMessage(GrpMsg_id),
	User_Uid INT NOT NULL CONSTRAINT FK_GroupMessageSeen_Uid FOREIGN KEY REFERENCES Users(Uid),
	Read_Status INT  DEFAULT 8 CONSTRAINT fk_status_read FOREIGN KEY REFERENCES Master(Master_id),
	CONSTRAINT Read_Status_check CHECK(Read_Status IN (8,9,10)),
)




--Tags Table
CREATE TABLE Tags(
	Tag_ID INT CONSTRAINT PK_Tag_ID PRIMARY KEY IDENTITY(1,1),
	Tags_Pid INT NOT NULL CONSTRAINT FK_Tags_Post_Tags_Pid FOREIGN KEY REFERENCES Post(Pid),
	Tags_Uid INT NOT NULL CONSTRAINT FK_Tags_Users_Tags_Uid FOREIGN KEY REFERENCES Users(Uid),
      CONSTRAINT UNIQUE_Tags UNIQUE(Tags_Pid,Tags_Uid)
)




-- Master table
CREATE TABLE Master
(
Master_id INT NOT NULL CONSTRAINT PK_Master_Master_id PRIMARY KEY IDENTITY(1,1),
Master_Value VARCHAR(20) NOT NULL ,
Master_SubValue VARCHAR(20) NOT NULL
)




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




-- Insert data in master
INSERT INTO Master VALUES
('Visibility','Private'),
('Visibility','Public'),
('Gender','Male'),
('Gender','Female'),
('Gender','Other'),
('Status','Online'),
('Status','Offline'),
 ('Message','Unread'),
('Message','Read'),
('Message','Send')

-- insert into GroupMessageSeen
INSERT INTO [dbo].[GroupMessageSeen]
           ([GroupMessageSeen_Groupid]
           ,[User_Uid]
           ,[Read_Status])
     VALUES
           (1,1,8),
		   (1,3,8),
		   (1,4,8)
GO

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
           ,[Users_Locationid]
           ,[Address]
           ,[Email]
           ,[PhoneNumber]
           ,[Created_date]
           ,[Dateofbirth]
           ,[Visible]
           ,[Password]
           ,[Gender],
           [Status])
     VALUES
          ('Romish',1,'Address 1','romish@gmail.com',2545874962,GETDATE(),'1999-02-01',0,EncryptByPassPhrase('key', 'romish123' ),3,6),
('Prit',1,'Address 2','prit@gmail.com',7458963215,GETDATE(),'1998-02-01',1,EncryptByPassPhrase('key', 'prit123' ),4,7),
('Vivek',2,'Address 3','Vivek@gmail.com',1205874965,GETDATE(),'1997-02-01',1,EncryptByPassPhrase('key', 'vivek123' ),3,6),
('Neel',2,'Address 4','nell@gmail.com',9657432018,GETDATE(),'1996-02-01',0,EncryptByPassPhrase('key', 'neel135' ),3,6),
('Jay',2,'Address 5','jay@gmail.com',7452013601,GETDATE(),'1995-02-01',0,EncryptByPassPhrase('key', 'jay456' ),3,6),
('Pratik',3,'Address 6','pratik@gmail.com',9658002341,GETDATE(),'1994-02-01',0,EncryptByPassPhrase('key', 'pratik123' ),3,6),
('Karan',4,'Address 7','karan@gmail.com',1234567890,GETDATE(),'1993-02-01',0,EncryptByPassPhrase('key', 'karan147' ),3,6),
('Veera',5,'Address 8','veer@gmail.com',1518960214,GETDATE(),'1992-02-01',0,EncryptByPassPhrase('key', 'veer123' ),3,6),
('Meena',6,'Address 9','meet@gmail.com',7850123604,GETDATE(),'1991-02-01',0,EncryptByPassPhrase('key', 'meet745' ),3,6);
GO



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
((SELECT DISTINCT FriendRequest_Uid FROM FriendRequest WHERE FriendRequest_Frid = 2) 
,(SELECT DISTINCT FriendRequest_Frid FROM FriendRequest WHERE FriendRequest_Frid = 4),'how are you','2021-08-19 16:22:22.713'),
((SELECT DISTINCT FriendRequest_Frid FROM FriendRequest WHERE FriendRequest_Frid = 4)
 ,(SELECT DISTINCT FriendRequest_Uid FROM FriendRequest WHERE FriendRequest_Uid = 2),'I am fine','2021-08-19 17:22:22.713')


--ADD POST BY FRIEND
	INSERT INTO [dbo].[Post] VALUES
    ('photos','check this post',20,1,1,GETDATE()),
	('like photo','check this post',10,2,3,GETDATE()),
	('educational','post',20,7,4,GETDATE()),
	('pubg','player',31,8,6,GETDATE()),
	('dr.','operation',2,6,5,GETDATE()),
	('new place','check out this post',30,1,4,GETDATE()),
	('sport','fun news',24,2,5,GETDATE()),
	('bajaj','loan work',2,4,5,GETDATE()),
	('decoration','fastival decor',30,23,8,GETDATE())
GO

-- send friend request 
INSERT INTO FriendRequest VALUES 
	(1,5,0,'2021-08-24'),
	(2,6,0,'2021-08-24'),
	(5,4,0,'2021-08-24'),
	(1,2,0,'2020-08-10'),
	(3,4,0,'2020-10-03')

GO




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




/* Comment table */


INSERT INTO Comment
Values
('Nice Pic',1,2),
('Beautifull',2,3),
('Great Picture',2,4),
('Good',5,3),
('Nice Place',3,6)

-- update
update Users
set Visible = 1 
where Uid IN (6,7)
UPDATE Chat
SET Msg = 'I am creating database of Social media'
WHERE msg_time = '2021-08-19 13:29:22.713'

--UPDATE POST LIKE
DECLARE @POSTID INT
SET @POSTID = 1
UPDATE Post SET Likes = Likes + 1 WHERE Pid = @POSTID

--select

SELECT Category_Name 'Categories' FROM Categories ORDER BY Category_Name
select * from Users
--Decrypt
Select Name,City,Email,PhoneNumber,convert(varchar(100),DecryptByPassPhrase('key',Password )) as Password from Users
-- Queries for Chat database


DECLARE @Sender int
SET @Sender = 1

DECLARE @Receiver int
SET @Receiver = 2

SELECT
	(SELECT u.Name FROM Users u WHERE u.Uid = c.Sender) as 'Sender', 
	(SELECT u.Name FROM Users u WHERE u.Uid = c.Receiver) as 'Receiver', 
	c.Msg
FROM Chat c
WHERE (Sender = @Sender AND Receiver = @Receiver) OR (Sender = @Receiver AND Receiver = @Sender)
ORDER BY msg_time


--change 
DELETE FROM Chat WHERE msg_time = '2021-08-19 13:29:22.713'
DELETE FROM Chat WHERE Sender = 1 AND Receiver = 2


--DISPLAY ALL POST 
SELECT P.Pid,P.Description,P.Likes,P.Title FROM Post P JOIN Users U ON P.Post_Uid = U.Uid 
WHERE U.Visible = 1


--DISPLAY ALL POST FOR ONLY FRIEND
SELECT P.Pid,P.Description,P.Likes,P.Title FROM Post P JOIN FriendRequest FR ON P.Post_Uid = FR.FriendRequest_Uid
WHERE Post_Uid IN 
(SELECT Uid FROM  Users WHERE  Uid  IN 
(Select DISTINCT FriendRequest_Uid FROM  FriendRequest WHERE FriendRequest_Frid = 1 AND FriendStatus = 1)
OR  Uid  IN (Select DISTINCT FriendRequest_Frid FROM
FriendRequest WHERE FriendRequest_Uid  = 1 AND FriendStatus = 1))


--DISPLAY POST BUT CATAGORIES VISE 
SELECT P.Pid,P.Description,P.Likes,P.Title FROM Post P JOIN Categories C ON 
P.Post_Category_ID = C.Category_ID where C.Category_Name = 'Album'


--1.UN FRIEND NEEL AND JAY 
UPDATE FriendRequest 
SET FriendStatus=0  WHERE FriendRequest_Uid = (SELECT Uid FROM Users WHERE Name='Neel') AND
  FriendRequest_Frid = (SELECT uid FROM Users WHERE Name='Jay')


--2.TODAY'S Tranding post like vias
SELECT P.Pid,P.Title,P.Likes,P.Post_Date FROM Post P WHERE P.Post_Date = CONVERT(DATE,GETDATE())  ORDER BY P.Likes DESC


--3.Display 18+ user name
SELECT Name AS '18+ NAME',DATEDIFF(YY,dateofbirth,getdate()) as age FROM Users WHERE DATEDIFF(YY,dateofbirth,getdate())>18


--4.Less than 18 to not show album , financial service,home improvement etc. like categories post

SELECT * FROM Post WHERE Post_Category_ID IN 
(SELECT Category_ID FROM Categories WHERE Category_Name NOT IN ('album','financial service','home improvement'))
AND (SELECT DATEDIFF(YY,dateofbirth,GETDATE()) FROM Users WHERE Uid = 9)<18


--5.Search post by name of user
SELECT P.Pid,P.Title,P.Likes FROM Post P JOIN Users U ON U.Uid = P.Post_Uid WHERE U.Name = 'Jay'


--6.search post by categories name
SELECT P.Pid,P.Title,P.Likes FROM Post P JOIN Categories C ON C.Category_ID = P.Post_Category_ID
WHERE C.Category_Name = 'Album'


--7.Count of Tags par post
SELECT Tags_Pid,COUNT(Tags_Pid) AS 'count tag per post' FROM Tags GROUP BY Tags_Pid


--8.which user how many tags added

SELECT U.Name, SUM([COUNT_C]) FROM (SELECT Tags_Pid,COUNT(Tags_Pid) AS [COUNT_C] FROM Tags GROUP BY Tags_Pid)TAMP JOIN Post P 
ON TAMP.TAGS_PID=P.Pid JOIN Users U ON P.Post_Uid = U.Uid GROUP BY U.Name


-- Dispaly friend request by id
SELECT a.Name,a.Uid FROM Users a JOIN FriendRequest b ON a.Uid = b.FriendRequest_Frid WHERE b.FriendRequest_Uid = 1  


-- change 0 or 1
--  Acceapte Request
update [FriendRequest]
  set FriendStatus =1,Approved_Date=('2020-12-10')
  where FriendRequestid in (5,8)


-- Display category name of user post

SELECT c.Category_Name FROM Categories c
	INNER JOIN Post p ON p.Post_Category_ID = c.Category_ID
	INNER JOIN Users u ON u.Uid = p.Post_Uid
WHERE u.Name = 'Vivek'


-- Display mutual friends

SELECT u.Name FROM Users u WHERE u.Uid IN 
(
(SELECT fa.FriendRequest_Frid FROM FriendRequest fa
WHERE fa.FriendRequest_Uid = 2
UNION
SELECT fa.FriendRequest_Uid FROM FriendRequest fa
WHERE fa.FriendRequest_Frid = 2)

INTERSECT

(SELECT fa.FriendRequest_Frid FROM FriendRequest fa
WHERE fa.FriendRequest_Uid = 5
UNION
SELECT fa.FriendRequest_Uid FROM FriendRequest fa
WHERE fa.FriendRequest_Frid = 5)
)


-- All users with its category name of Post
SELECT u.Name,p.Pid,p.Title,c.Category_ID,c.Category_Name FROM Users u
	LEFT JOIN Post p ON p.Post_Uid = u.Uid
	LEFT JOIN Categories c ON c.Category_ID = p.Post_Category_ID


-- List of friends count display
SELECT COUNT(*) FROM 
(SELECT f.FriendRequest_Uid,f.FriendRequest_Frid,f.FriendStatus FROM FriendRequest f
	LEFT JOIN Users u ON f.FriendRequest_Uid = u.Uid
WHERE u.Name = 'Prit'
UNION
SELECT f.FriendRequest_Uid,f.FriendRequest_Frid,f.FriendStatus FROM FriendRequest f
	LEFT JOIN Users u ON f.FriendRequest_Frid = u.Uid
WHERE u.Name = 'Prit') temp
WHERE FriendStatus = 1


-- List of users who have not posted anything
SELECT Name,Uid FROM Users
WHERE uid NOT IN (SELECT Post_uid FROM Post)


-- Number of Post of all users
SELECT COUNT(Pid) as 'no. of post',
		Post_Uid,
		(SELECT Name FROM Users WHERE Uid = Post.Post_Uid) as 'Name' 
FROM Post 
GROUP BY Post_Uid


-- List of users with 0 friends
SELECT Uid FROM Users 
WHERE Uid NOT IN (SELECT FriendRequest_Uid FROM FriendRequest UNION SELECT FriendRequest_Frid FROM FriendRequest)


-- Users with total friends 
SELECT FriendRequest_Uid as 'userID',COUNT(FriendRequest_Frid) FROM 
(SELECT f.FriendRequest_Uid,f.FriendRequest_Frid,f.FriendStatus as 'fs' FROM FriendRequest f) temp
WHERE fs = 1
GROUP BY FriendRequest_Uid
UNION
SELECT FriendRequest_Frid as 'UserID',COUNT(FriendRequest_Uid) FROM 
(SELECT f.FriendRequest_Uid,f.FriendRequest_Frid,f.FriendStatus as 'fs' FROM FriendRequest f) temp
WHERE fs = 1
GROUP BY FriendRequest_Frid


-- OR  
SELECT FriendRequest_Uid as 'userID',COUNT(FriendRequest_Frid) FROM  FriendRequest
WHERE friendstatus = 1
GROUP BY FriendRequest_Uid
UNION
SELECT FriendRequest_Frid as 'userID',COUNT(FriendRequest_Uid) FROM  FriendRequest
WHERE friendstatus = 1
GROUP BY FriendRequest_Frid


-- friend suggestions 
SELECT Name,Uid FROM  Users WHERE  Uid <>1  AND Uid  IN (Select DISTINCT FriendRequest_Uid FROM 
FriendRequest WHERE  FriendStatus  =1 AND FriendRequest_Frid  
IN(SELECT FriendRequest_Frid FROM FriendRequest WHERE FriendRequest_Uid  =1 AND FriendStatus  =1)) OR Uid 
IN (Select DISTINCT FriendRequest_Frid FROM  FriendRequest WHERE  FriendStatus  =1 AND FriendRequest_Uid  
IN(SELECT FriendRequest_Frid FROM FriendRequest WHERE FriendRequest_Uid  =1 AND FriendStatus =1)) 



/*1. Write a query to display all details of private account */

SELECT * FROM Users WHERE Visible = 1;

/*2. Write query to display total account from perticular city */

SELECT COUNT(uid) "Account",City 
FROM Users 
JOIN Location
ON Users.Users_Locationid = Location.Locationid
GROUP BY city ORDER BY Account DESC

/*3. Write a query to display name and city of users who are from rajkot or Mumbai*/

SELECT Name,city
FROM Users
JOIN Location
ON Users.Users_Locationid = Location.Locationid
WHERE Location.City IN ('Rajkot','Mumbai')

/*4. write a query to display category name start with H*/

SELECT category_name FROM Categories WHERE Category_Name LIKE 'H%'

/*5. Write a query to display title of post and catagary name of user neeel*/

SELECT name,Title,Category_Name 
FROM Users
JOIN Post
ON Users.Uid=post.Post_Uid
JOIN Categories
ON Categories.Category_ID = post.Post_Category_ID
WHERE Users.Name = 'Neel'

/*6. write a query to display friend name of user Romish*/

SELECT name FROM Users WHERE Uid IN
(SELECT FriendRequest_Frid FROM FriendRequest WHERE FriendStatus = 1 AND FriendRequest_Uid = 
(SELECT uid FROM users WHERE name = 'Romish'))
OR
Uid IN
(SELECT FriendRequest_Uid FROM FriendRequest WHERE FriendStatus = 1 AND FriendRequest_Frid = 
(SELECT uid FROM users WHERE name = 'Romish'))


/*7. write a query to display all the message send by prit*/

SELECT Msg FROM Chat
JOIN Users
ON users.Uid = chat.Sender
WHERE name = 'Prit' 

/*8. write a query to display catagory all categories used by user order by category name*/

SELECT Category_Name FROM Categories WHERE Category_ID IN (SELECT Post_Category_ID FROM Post) ORDER BY Category_Name

/*9. write a query display category name which is never possted by any user*/

SELECT category_ID, category_name FROM Categories WHERE Category_ID NOT IN (SELECT Post_Category_ID FROM post)

/*10. Write a query to display comment made by Prit*/

SELECT Comment_Text FROM Comment WHERE Comment_Uid = 
(SELECT Uid FROM users WHERE name = 'Prit')

/*11. Write a query to display comment made on vivek's post*/

SELECT comment_text FROM comment WHERE Comment_Pid IN 
(SELECT pid FROM post WHERE Post_Uid = 
(SELECT uid FROM users WHERE name = 'vivek'))

/*12. Write a query to display comment made on pratik's post with username*/

SELECT comment_text,name FROM comment 
JOIN users 
ON Comment.Comment_Uid = Users.Uid 
WHERE Comment_Pid IN 
(SELECT pid FROM post WHERE Post_Uid = 
(SELECT uid FROM users WHERE name = 'pratik'))

/*13. Write a query to display a name of user with post title on which maximum comments are made*/

SELECT Users.Uid,Users.name,Post.pid,Post.title 
FROM Post 
JOIN Users
ON Post.Post_Uid = Users.Uid
WHERE Post.Pid = 
(SELECT Comment_Pid FROM 
(SELECT TOP 1 COUNT(Comment_Pid) "comment",Comment_Pid 
FROM comment GROUP BY Comment_Pid ORDER BY comment DESC )temp)

/*14. Write a query to display Groupid,Group name and group members name which is created by prit */

SELECT group_id, grp_name,users.Name "GroupMembers" FROM users 
JOIN GroupMember
ON GroupMember.GroupMember_Uid = Users.Uid
JOIN Groups
ON Groups.GroupId = GroupMember.Group_id
WHERE groups.Created_By = (SELECT Uid FROM users WHERE name = 'prit')

/*15. Write a query to display all image of romish's post*/

SELECT * FROM Image WHERE Imageid IN 
(SELECT pid FROM post WHERE Post_Uid = 
(SELECT uid FROM Users WHERE name = 'Romish'))

/*16. write a query to display a name of users who are taged in viveks post*/
 SELECT name FROM Users WHERE Uid in 
(SELECT Tags_Uid FROM Tags WHERE Tags_Pid = 
(SELECT pid FROM post WHERE Post_Uid = (SELECT uid FROM users WHERE name = 'Vivek')))



--highest post in categories
SELECT DENSE_RANK() OVER(ORDER BY COUNT(P.PID) DESC) as 'rank',C.Category_Name,COUNT(P.Pid) FROM Categories C  JOIN Post P ON C.Category_ID = P.Post_Category_ID
GROUP BY Category_Name


-- add dob in users
ALTER TABLE Users ADD dateofbirth DATE


-- Display username with max like on photo and users photo belongs to category name starts with A
SELECT TOP 1 u.name as 'name',MAX(p.Likes) as 'max_like' FROM Users u
	JOIN Post p ON p.Post_Uid = u.Uid
	JOIN Categories c ON c.Category_ID = p.Post_Category_ID
WHERE c.Category_Name LIKE 'A%'
GROUP BY u.Name
ORDER BY max_like DESC


-- List of users commented on Neel's post
SELECT c.Comment_Uid,u.Name FROM Comment c
	JOIN Users u ON u.Uid = c.Comment_Uid
WHERE c.Comment_Pid IN (SELECT p.Pid FROM Post p WHERE p.Post_Uid = (SELECT Uid FROM Users WHERE Name = 'Neel'))


-- Name of user on which Romish commented
SELECT u.Name FROM Users u
WHERE u.Uid IN 
( SELECT p.Post_Uid FROM Post p WHERE p.Pid IN 
(SELECT c.Comment_Pid FROM Comment c WHERE c.Comment_Uid = (SELECT Uid FROM Users WHERE Name = 'Romish')))


----- Like ------


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


-- display your post like by  your friends .
   SELECT a.Pid,a.Title,a.Description,c.Image,a.Likes,b.Category_Name,a.Post_Date,a.Post_Uid
   FROM Post a JOIN Categories b ON a.Post_Category_ID = b.Category_ID JOIN Image c ON c.Imageid = a.Pid
   WHERE b.Category_ID IN (SELECT a.Post_Category_ID FROM POST a JOIN
   Likebyuser b ON a.Pid = b.LikebyUser_Pid WHERE b.LikebyUser_Uid = 2) 


-- friends of friends like . display recommended post like by your friend 
 with  friendss(Uid)
  AS
  (SELECT Uid FROM  Users WHERE  Uid  IN 
(Select DISTINCT FriendRequest_Uid FROM  FriendRequest WHERE FriendRequest_Frid = 1 AND FriendStatus = 1)
OR  Uid  IN (Select DISTINCT FriendRequest_Frid FROM 
FriendRequest WHERE FriendRequest_Uid  = 1 AND FriendStatus = 1))
,
friendoffriend(Uid) AS 
(SELECT Uid FROM  Users WHERE  Uid  IN 
(Select DISTINCT FriendRequest_Uid FROM  FriendRequest WHERE FriendRequest_Frid IN (SELECT Uid FROM friendss)
AND FriendStatus = 1 AND FriendRequest_Uid <> 1)
OR  Uid  IN (Select DISTINCT FriendRequest_Frid FROM 
FriendRequest WHERE FriendRequest_Uid  IN (SELECT Uid FROM friendss)
AND FriendStatus = 1 AND FriendRequest_Frid <> 1))

SELECT a.Pid,a.Title,a.Description,c.Image,a.Likes,b.Category_Name,a.Post_Date,a.Post_Uid
FROM Post a JOIN Categories b
ON a.Post_Category_ID = b.Category_ID JOIN Image c ON c.Imageid = a.Pid
WHERE
a.Pid IN(SELECT LikebyUser_Pid FROM Likebyuser WHERE LikebyUser_Uid IN (SELECT Uid FROM friendoffriend))

--
--  acceapt request .
UPDATE FriendRequest SET FriendStatus = 1, Approved_Date = GETDATE() WHERE FriendRequest_Uid = 1 AND FriendRequest_Frid = 5
--  reject request .
UPDATE FriendRequest SET FriendStatus = 0, Approved_Date = GETDATE() WHERE FriendRequest_Uid = 1 AND FriendRequest_Frid = 5

-- request apporoved .
SELECT FriendRequest_Frid  FROM FriendRequest WHERE FriendStatus = 1 AND FriendRequest_Uid = 1
-- requested friend .
SELECT FriendRequest_Frid  FROM FriendRequest WHERE FriendStatus = 0 AND FriendRequest_Uid = 0
-- my all friends .
SELECT Name,Uid FROM  Users WHERE  Uid  IN 
(Select DISTINCT FriendRequest_Uid FROM  FriendRequest WHERE FriendRequest_Frid = 1 AND FriendStatus = 1)
OR  Uid  IN (Select DISTINCT FriendRequest_Frid FROM
FriendRequest WHERE FriendRequest_Uid  = 1 AND FriendStatus = 1)


-- friends of friends .
  with  friends(Uid)
  AS
  (SELECT Uid FROM  Users WHERE  Uid  IN 
(Select DISTINCT FriendRequest_Uid FROM  FriendRequest WHERE FriendRequest_Frid = 1 AND FriendStatus = 1)
OR  Uid  IN (Select DISTINCT FriendRequest_Frid FROM 
FriendRequest WHERE FriendRequest_Uid  = 1 AND FriendStatus = 1))

SELECT Uid FROM  Users WHERE  Uid  IN 
(Select DISTINCT FriendRequest_Uid FROM  FriendRequest WHERE FriendRequest_Frid IN (SELECT Uid FROM friends)
AND FriendStatus = 1 AND FriendRequest_Uid <> 1)
OR  Uid  IN (Select DISTINCT FriendRequest_Frid FROM 
FriendRequest WHERE FriendRequest_Uid  IN (SELECT Uid FROM friends)
AND FriendStatus = 1 AND FriendRequest_Frid <> 1)


-- friend anniversary 
SELECT DATEDIFF(YEAR,Approved_Date,GETDATE()) 'years of friend anniversary' FROM FriendRequest WHERE DATEDIFF(YEAR,Approved_Date,GETDATE()) >=1


-- diffent of friend req. is approved
SELECT DATEDIFF(DAY,Requested_Date,Approved_Date) FROM FriendRequest


-- time of friend req. is approved
SELECT DATEDIFF(DAY,Approved_Date,GETDATE()) FROM FriendRequest


--Today's birthday 
SELECT DATEDIFF(dd,Dateofbirth,GETDATE())/365 as age,  'Happy Birthday ' +
Name as HappyBirth	day  FROM Users WHERE 
DATEPART(mm,GETDATE())-DATEPART(mm,Dateofbirth)=0 
AND DATEPART(dd,GETDATE())-DATEPART(dd,Dateofbirth)=0


-- Your Friend's Birthday (Today)
SELECT DATEDIFF(dd,Dateofbirth,GETDATE())/365 as age, 
Name as HappyBirthday  FROM Users WHERE 
DATEPART(mm,GETDATE())-DATEPART(mm,Dateofbirth)=0 
AND DATEPART(dd,GETDATE())-DATEPART(dd,Dateofbirth)=0 AND Uid
IN(SELECT Uid FROM  Users WHERE  Uid  IN 
(Select DISTINCT FriendRequest_Uid FROM  
FriendRequest WHERE FriendRequest_Frid = 3 AND FriendStatus = 1)
OR  Uid  IN (Select DISTINCT FriendRequest_Frid FROM
FriendRequest WHERE FriendRequest_Uid  = 3 AND FriendStatus = 1))



-- Queries for group chat


-- Query to see names of all groups
SELECT grp_name,GroupId FROM Groups 


-- chat of group 1
SELECT m.Message,u.Name FROM GroupMessage m
	JOIN Users u ON u.Uid = m.GroupMessage_Uid
WHERE m.grp_id = 1


-- Members of groupid 5
SELECT gm.GroupMember_Uid,u.Name FROM GroupMember gm
	JOIN Users u ON u.Uid = gm.GroupMember_Uid
WHERE gm.Group_id = 5


-- name of all members with group name 
SELECT * FROM GroupMember gm
	JOIN Users u ON u.Uid = gm.GroupMember_Uid


-- display user name who is in more than 1 group
SELECT u.Name FROM Users u
	JOIN GroupMember m ON m.GroupMember_Uid = u.Uid
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


--add columns in FriendRequest
 ALTER TABLE FriendRequest ALTER COLUMN FriendStatus bit  not null 
 ALTER TABLE FriendRequest ADD  Requested_Date DATE  not null DEFAULT GETDATE()
 ALTER TABLE FriendRequest ADD  Approved_Date DATE  null

ALTER TABLE Tags
ADD CONSTRAINT UNIQUE_Tags UNIQUE(Tags_Pid,Tags_Uid)