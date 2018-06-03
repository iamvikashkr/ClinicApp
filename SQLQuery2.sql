 select * from tblRegister;
  select * from tblUsers;
    select * from tblroles;


	truncate table tblRegister;
	truncate table tblUsers;

create table tblRegister
(
ID int identity(1,1),
RoleID int ,
UserID int,
FirstName varchar(20),
LastName varchar(20),
Email varchar(50),
Gender varchar(20),
MobileNumber bigint,
BirthDate date,
Availability varchar(50),
Specialization varchar(50),
IsActive bit,
IsDelete bit,
constraint register_pk primary key(ID),
constraint register_fk foreign key(UserID) references tblUsers(ID)
)
Alter proc spRegister
(
@roleid int,
@fname varchar(20),
@lname varchar(20),
@email varchar(20),
@password varchar(20),
@gender varchar(20),
@mobile int,
@birthdate date,
@availability varchar(50),
@specialization varchar(50),
@age int,
@IsActive bit,
@IsDelete bit
)
AS
BEGIN

if not exists(select * from tblRegister where Email=@email)

begin
declare @userid int
insert into tblUsers(RoleID,Email,Password, IsActive, IsDelete) values(@roleid,@email,@password,1,@IsDelete) 
select @userid=ID from tblUsers
insert into tblRegister(RoleID,UserID,FirstName, LastName, Email, Gender, MobileNumber, BirthDate, Availability, Specialization,IsActive,IsDelete, Age) values(@roleid,@userid,@fname,@lname, @email,  @gender, @mobile,@birthdate,@availability,@specialization,1,@IsDelete,@age)
end

else

begin
raiserror('User already exists',11,1)
end

END





truncate table tblroles;

	drop table tblroles;
	drop table tblUsers;
	drop table tblRegister;


	 delete from tblUsers where ID='8';


	 alter table tblRegister add Age int;
	 alter table tblRegister drop column password;


  insert into tblroles values('Patient','I am Patient',0,0);

ALTER TABLE tblUsers Add constraint users_fk foreign key (RoleID) references tblRoles(ID) ;

ALTER TABLE tblRoles DROP CONSTRAINT roles_pk;
ALTER TABLE tblRoles Add constraint roles_pk primary key (ID) ;


ALTER TABLE tblUsers DROP CONSTRAINT users_fk;
ALTER TABLE tblUsers DROP CONSTRAINT users_pk;
ALTER TABLE tblUsers Add constraint users_fk foreign key (RoleID) references tblRoles(ID) ;
ALTER TABLE tblUsers Add constraint users_pk primary key (ID) ;




ALTER TABLE tblRegister DROP CONSTRAINT register_fk;
ALTER TABLE tblRegister DROP CONSTRAINT register_pk;
ALTER TABLE tblRegister Add constraint register_fk foreign key (UserID) references tblUsers(ID) ;
ALTER TABLE tblRegister Add constraint register_pk primary key (ID) ;



ALTER TABLE tblLog DROP CONSTRAINT log_fk;
ALTER TABLE tblLog Add constraint log_fk foreign key (UserID) references tblUsers(ID) ;


Alter proc spSignIn
(
@Email varchar(50),
@Password varchar(50)
)
AS 
BEGIN

if exists(select Email,Password from tblUsers where Email=@Email and Password=@Password)
begin
declare @UserID int
declare @RoleID int
declare @token varchar(100)
select @UserID=UserID , @RoleID=RoleID from tblRegister where Email=@Email
select @token=Round((RAND()*48000),0)
insert into tblLog(UserID,RoleID,LoggedIn,Token ) values(@UserID,@RoleID,GETDATE(), @token)
select * from tblRegister where Email=@Email
 
end
else
begin
raiserror('User not present',11,1)
end
end
go

exec spSignIn 'jay@gmail.com','qq'

truncate table tbllog;

select * from tblLog;
 select * from tblUsers;
select * from tblRegister;
select * from tblroles;
select * from tblAppointment;
  create proc spEmail
  (
  @Email varchar(50)
  )
  AS 
  BEGIN
  select * from tblRegister where Email=@Email

  END
  exec spEmail 'vikash@gmail.com'

	  select * from tblRegister;

	  truncate table  tblUsers;
	  truncate table tblRoles;
	  truncate table tblLog;
	  	truncate table tblRegister;


  create proc spDocDrop
  (@ID int 
  )
  AS 
  BEGIN
   select UserID,FirstName,LastName from tblRegister where ID=@ID
   END
   GO

   exec spDocDrop '3'


     create proc spPatDrop
  (@ID int 
  )
  AS 
  BEGIN
   select UserID,FirstName,LastName from tblRegister where ID=@ID
   END
   GO

   exec spPatDrop '2'

    create proc spPatientDetails
  (@RoleID int 
  )
  AS 
  BEGIN
   select UserID,FirstName,LastName from tblRegister where RoleID=@RoleID
   END
   GO

   exec spPatientDetails '3';

    alter proc spDocDetails
  (@RoleID int 
  )
  AS 
  BEGIN
   select UserID,FirstName,LastName from tblRegister where RoleID=@RoleID
   END
   GO

   exec spDocDetails '2'

   select * from tblLog;
 select * from tblUsers;
select * from tblRegister;
select * from tblroles;
select * from tblAppointment;

create proc spAppointment
(
@PatientID int,
@DoctorID int,
@AppointmentDate datetime,
@Diagonasis varchar(500),
@Remarks varchar(500),
@IsActive bit,
@IsDelete bit
)
AS
BEGIN

insert into  tblAppointment(PatientID,DoctorID,AppointmentDate,Diagonasis,Remarks,IsActive,IsDelete) values(@PatientID,@DoctorID,@AppointmentDate,@Diagonasis,@Remarks,1,@IsDelete)

END
go