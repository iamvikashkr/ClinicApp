create database ClinicAdminAppMVC;

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

create table tblroles(
ID int identity(1,1),
Title varchar(50),
Remarks varchar(50),
IsActive bit,
IsDelete bit,
constraint roles_pk primary key(ID) 
)
select * from tblroles;
drop table tblroles;

create table tblUsers(
ID int Identity(1,1),
RoleID int ,
Email varchar(50),
Password varchar(50),
IsActive bit,
IsDelete bit,
constraint users_pk primary key(ID),
constraint users_fk foreign key(RoleID) references tblroles(ID)
)


create table tblLog
(
ID int identity(1,1),
UserID int ,
Token varchar(50),
IPAddress varchar(50),
MACAdderss varchar(50),
LoggedIn datetime ,
LoggedOut datetime,
Remarks varchar(50),
RoleID int ,
constraint log_pk primary key(ID),
constraint log_fk foreign key(UserID) references tblUsers(ID)
)

create table tblAppointment (
ID int identity(1,1),
PatientID int,
DoctorID int,
AppointmentDate datetime,
Diagonasis varchar(300),
Remarks varchar(300),
IsActive bit,
IsDelete bit,
constraint app_pk primary key(ID),
--constraint appPatient_fk foreign key(PatientID) references tblRegister(UserID),
--constraint appDoctor_fk foreign key(DoctorID) references tblRegister(UserID)
)


alter table tblRegister add Password int;
alter table tblRegister drop column password;


create proc spRegister
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
@IsActive bit
)
AS
BEGIN

if not exists(select * from tblRegister where Email=@email)

begin
declare @userid int
insert into tblUsers(RoleID,Email,Password) values(@roleid,@email,@password) 
select @userid=ID from tblUsers
insert into tblRegister(RoleID,UserID,FirstName, LastName, Email, Gender, MobileNumber, BirthDate, Availability, Specialization,IsActive, Age) values(@roleid,@userid,@fname,@lname, @email,  @gender, @mobile,@birthdate,@availability,@specialization,@IsActive,@age)
end

else

begin
raiserror('User already exists',11,1)
end

END
GO

delete from tblRegister where RoleID='1';
select * from tblRegister;
select * from tblUsers;
