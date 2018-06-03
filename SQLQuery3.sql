select * from tblAppointment;
select * from tblRegister;

select (FirstName+' '+LastName) as DoctorName ,PatientID, DoctorID, AppointmentDate,Specialization from tblRegister inner join tblAppointment on tblRegister.UserID=tblAppointment.DoctorID;

create view viewAppointmentDoc 
as
select
a.ID, 
(d.FirstName+' '+d.LastName) as Doctorname,
a.DoctorID,
a.PatientID, 
d.specialization,
d.availability,
a.AppointmentDate,
(p.FirstName+' '+p.LastName) as PatientName, 
a.Diagonasis,
a.Remarks
from tblRegister d inner join tblAppointment a on 
d.UserID=a.DoctorID 
inner join tblRegister p on
p.UserID=a.PatientID

select * from viewAppointmentDoc

create proc spDocInfo
(
@DoctorID int
)
AS
BEGIN
select * from viewAppointmentDoc where DoctorID=@DoctorID
end
GO

exec spDocInfo'2'



create view viewAppointmentPat 
as
select
a.ID, 
(d.FirstName+' '+d.LastName) as PatientName, 
a.PatientID, 
a.DoctorID,
a.Diagonasis,
a.Remarks,
(p.FirstName+' '+p.LastName) as Doctorname,
p.Specialization,
p.Availability
from tblRegister d inner join tblAppointment a on 
d.UserID=a.PatientID 
inner join tblRegister p on
p.UserID=a.DoctorID


select * from viewAppointmentPat
drop view viewAppointmentPat 
 
alter proc spPatInfo
(
@PatientID int
)
AS
BEGIN
select * from viewAppointmentPat where PatientID=@PatientID
end
GO

exec spPatInfo '7'