select * from tblUsers
select * from tblRegister
select * from tblLog
select * from tblAppointment
select * from tblroles

alter proc spForgotPass
(
@Email varchar(50),
@newPassword varchar(50)
)
AS
BEGIN
if exists(select Email from tblUsers where Email=@Email)
begin
update tblUsers set Password=@newPassword where Email=@Email
select Email from tblUsers where Email=@Email
end
else
begin
raiserror('user does not Exists',11,1);
end
end
GO

exec spForgotPass 'ivikash.8x@gmail.com','qq'

update tblRegister set Email='jayeshnpatil13@gmail.com' where Email='jay@gmail.com'

update tblUsers set Password='qq' where ID='1'

delete from tblUsers where ID='22' 
select * from viewAppointmentPat

select * from viewAppointmentDoc


alter proc spAppointment
(
@PatientID int,
@DoctorID int,
@AppointmentDate date,
@Diagonasis varchar(500),
@Remarks varchar(500),
@IsActive bit,
@IsDelete bit
)
AS
BEGIN
if((select count(*) from tblAppointment where DoctorID=@DoctorID and AppointmentDate=@AppointmentDate)<5)
begin
insert into  tblAppointment(PatientID,DoctorID,AppointmentDate,Diagonasis,Remarks,IsActive,IsDelete) values(@PatientID,@DoctorID,@AppointmentDate,@Diagonasis,@Remarks,1,@IsDelete)
end
else
begin
raiserror('Appointment is full for this Doctor',11,1)
end
END
go

create proc spEditProfile
(
@UserID int,
@firstname varchar(50),
@lastname varchar(50),
@password varchar(50)
)
as
begin
update tblRegister set FirstName=@firstname , LastName=@lastname where UserID=@UserID
update tblUsers set Password=@password where ID=@UserID
end
go


update tblUsers set Password='qq'where ID=1
