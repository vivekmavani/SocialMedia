CREATE DATABASE socialmedia
USE socialmedia
CREATE TABLE Users
(
Uid int  CONSTRAINT uid_User PRIMARY KEY  IDENTITY(1,1),
Name varchar(20) not null,
City varchar(20) not null,
Email varchar(30) not null,
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
)

CREATE TABLE FriendAccapte
(
FriendAccapteid int   CONSTRAINT FriendAccapteid_FriendAccapte PRIMARY KEY  IDENTITY(1,1),
Uid int  CONSTRAINT Uid_FriendAccapte FOREIGN KEY  REFERENCES  Users(Uid) ,
Frid int  CONSTRAINT Frid_FriendAccapte FOREIGN KEY  REFERENCES  Users(Uid),
)
CREATE TABLE Chat
(
Chat_id int PRIMARY KEY IDENTITY(1,1),
Sender int CONSTRAINT SEND_FK FOREIGN KEY REFERENCES Users(uid),
Receiver int CONSTRAINT RECEIVE_FK FOREIGN KEY REFERENCES Users(uid),
Msg varchar(max) not null,
msg_time datetime DEFAULT GETDATE()
)



--Select convert(varchar(100),DecryptByPassPhrase('key',@Encrypt )) as Decrypt  
--Declare @Encrypt varbinary(200)  
--Select @Encrypt = EncryptByPassPhrase('key', 'Jothish' )  
--Select @Encrypt as Encrypt 