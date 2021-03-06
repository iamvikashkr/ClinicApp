USE [master]
GO
/****** Object:  Database [ClinicAdminAppMVC]    Script Date: 20-03-2018 16:54:37 ******/
CREATE DATABASE [ClinicAdminAppMVC]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'ClinicAdminAppMVC', FILENAME = N'C:\Users\Admin\ClinicAdminAppMVC.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'ClinicAdminAppMVC_log', FILENAME = N'C:\Users\Admin\ClinicAdminAppMVC_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [ClinicAdminAppMVC] SET COMPATIBILITY_LEVEL = 130
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [ClinicAdminAppMVC].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [ClinicAdminAppMVC] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [ClinicAdminAppMVC] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [ClinicAdminAppMVC] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [ClinicAdminAppMVC] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [ClinicAdminAppMVC] SET ARITHABORT OFF 
GO
ALTER DATABASE [ClinicAdminAppMVC] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [ClinicAdminAppMVC] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [ClinicAdminAppMVC] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [ClinicAdminAppMVC] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [ClinicAdminAppMVC] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [ClinicAdminAppMVC] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [ClinicAdminAppMVC] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [ClinicAdminAppMVC] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [ClinicAdminAppMVC] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [ClinicAdminAppMVC] SET  ENABLE_BROKER 
GO
ALTER DATABASE [ClinicAdminAppMVC] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [ClinicAdminAppMVC] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [ClinicAdminAppMVC] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [ClinicAdminAppMVC] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [ClinicAdminAppMVC] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [ClinicAdminAppMVC] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [ClinicAdminAppMVC] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [ClinicAdminAppMVC] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [ClinicAdminAppMVC] SET  MULTI_USER 
GO
ALTER DATABASE [ClinicAdminAppMVC] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [ClinicAdminAppMVC] SET DB_CHAINING OFF 
GO
ALTER DATABASE [ClinicAdminAppMVC] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [ClinicAdminAppMVC] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [ClinicAdminAppMVC] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [ClinicAdminAppMVC] SET QUERY_STORE = OFF
GO
USE [ClinicAdminAppMVC]
GO
ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET LEGACY_CARDINALITY_ESTIMATION = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET MAXDOP = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET PARAMETER_SNIFFING = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET QUERY_OPTIMIZER_HOTFIXES = PRIMARY;
GO

--==============================================================================
USE [ClinicAdminAppMVC]
GO
/****** Object:  Table [dbo].[tblAppointment]    Script Date: 20-03-2018 16:54:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblAppointment](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[PatientID] [int] NULL,
	[DoctorID] [int] NULL,
	[AppointmentDate] [datetime] NULL,
	[Diagonasis] [varchar](300) NULL,
	[Remarks] [varchar](300) NULL,
	[IsActive] [bit] NULL,
	[IsDelete] [bit] NULL,
 CONSTRAINT [app_pk] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblRegister]    Script Date: 20-03-2018 16:54:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblRegister](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[RoleID] [int] NULL,
	[UserID] [int] NULL,
	[FirstName] [varchar](20) NULL,
	[LastName] [varchar](20) NULL,
	[Email] [varchar](50) NULL,
	[Gender] [varchar](20) NULL,
	[MobileNumber] [bigint] NULL,
	[BirthDate] [date] NULL,
	[Availability] [varchar](50) NULL,
	[Specialization] [varchar](50) NULL,
	[IsActive] [bit] NULL,
	[IsDelete] [bit] NULL,
	[Age] [int] NULL,
 CONSTRAINT [register_pk] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[viewAppointmentPat]    Script Date: 20-03-2018 16:54:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[viewAppointmentPat] 
as
select
a.ID, 
(d.FirstName+' '+d.LastName) as PatientName, 
a.PatientID, 
a.DoctorID,
a.AppointmentDate,
a.Diagonasis,
a.Remarks,
(p.FirstName+' '+p.LastName) as Doctorname,
p.Specialization,
p.Availability
from tblRegister d inner join tblAppointment a on 
d.UserID=a.PatientID 
inner join tblRegister p on
p.UserID=a.DoctorID
GO
/****** Object:  View [dbo].[viewAppointmentDoc]    Script Date: 20-03-2018 16:54:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[viewAppointmentDoc] 
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
GO
/****** Object:  Table [dbo].[tblLog]    Script Date: 20-03-2018 16:54:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblLog](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [int] NULL,
	[Token] [varchar](50) NULL,
	[IPAddress] [varchar](50) NULL,
	[MACAdderss] [varchar](50) NULL,
	[LoggedIn] [datetime] NULL,
	[LoggedOut] [datetime] NULL,
	[Remarks] [varchar](50) NULL,
	[RoleID] [int] NULL,
 CONSTRAINT [log_pk] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblroles]    Script Date: 20-03-2018 16:54:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblroles](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Title] [varchar](50) NULL,
	[Remarks] [varchar](50) NULL,
	[IsActive] [bit] NULL,
	[IsDelete] [bit] NULL,
 CONSTRAINT [roles_pk] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblUsers]    Script Date: 20-03-2018 16:54:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblUsers](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[RoleID] [int] NULL,
	[Email] [varchar](50) NULL,
	[Password] [varchar](50) NULL,
	[IsActive] [bit] NULL,
	[IsDelete] [bit] NULL,
 CONSTRAINT [users_pk] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[tblAppointment] ON 

INSERT [dbo].[tblAppointment] ([ID], [PatientID], [DoctorID], [AppointmentDate], [Diagonasis], [Remarks], [IsActive], [IsDelete]) VALUES (1, 3, 2, CAST(N'2018-02-08T00:00:00.000' AS DateTime), N'abcmm', N'xyzmm', 1, 0)
INSERT [dbo].[tblAppointment] ([ID], [PatientID], [DoctorID], [AppointmentDate], [Diagonasis], [Remarks], [IsActive], [IsDelete]) VALUES (2, 7, 4, CAST(N'2018-02-15T00:00:00.000' AS DateTime), N'cough', N'good', 1, 0)
INSERT [dbo].[tblAppointment] ([ID], [PatientID], [DoctorID], [AppointmentDate], [Diagonasis], [Remarks], [IsActive], [IsDelete]) VALUES (3, 5, 6, CAST(N'2018-02-07T00:00:00.000' AS DateTime), N'fever', N'good', 1, 0)
INSERT [dbo].[tblAppointment] ([ID], [PatientID], [DoctorID], [AppointmentDate], [Diagonasis], [Remarks], [IsActive], [IsDelete]) VALUES (4, 3, 2, CAST(N'2018-02-08T00:00:00.000' AS DateTime), N'tyrytr`', N'uui', 1, 0)
INSERT [dbo].[tblAppointment] ([ID], [PatientID], [DoctorID], [AppointmentDate], [Diagonasis], [Remarks], [IsActive], [IsDelete]) VALUES (1002, 5, 6, CAST(N'2018-02-08T00:00:00.000' AS DateTime), N'cough', N'not good', 1, 0)
INSERT [dbo].[tblAppointment] ([ID], [PatientID], [DoctorID], [AppointmentDate], [Diagonasis], [Remarks], [IsActive], [IsDelete]) VALUES (1003, 5, 8, CAST(N'2018-02-01T00:00:00.000' AS DateTime), NULL, NULL, 1, 0)
INSERT [dbo].[tblAppointment] ([ID], [PatientID], [DoctorID], [AppointmentDate], [Diagonasis], [Remarks], [IsActive], [IsDelete]) VALUES (1004, 3, 8, CAST(N'2018-02-14T00:00:00.000' AS DateTime), N'done ', N'good', 1, 0)
INSERT [dbo].[tblAppointment] ([ID], [PatientID], [DoctorID], [AppointmentDate], [Diagonasis], [Remarks], [IsActive], [IsDelete]) VALUES (1005, 7, 8, CAST(N'2018-02-21T00:00:00.000' AS DateTime), NULL, NULL, 1, 0)
INSERT [dbo].[tblAppointment] ([ID], [PatientID], [DoctorID], [AppointmentDate], [Diagonasis], [Remarks], [IsActive], [IsDelete]) VALUES (1006, 5, 4, CAST(N'2018-02-01T00:00:00.000' AS DateTime), NULL, NULL, 1, 0)
INSERT [dbo].[tblAppointment] ([ID], [PatientID], [DoctorID], [AppointmentDate], [Diagonasis], [Remarks], [IsActive], [IsDelete]) VALUES (1007, 9, 8, CAST(N'2018-02-07T00:00:00.000' AS DateTime), NULL, NULL, 1, 0)
INSERT [dbo].[tblAppointment] ([ID], [PatientID], [DoctorID], [AppointmentDate], [Diagonasis], [Remarks], [IsActive], [IsDelete]) VALUES (1008, 3, 6, CAST(N'2018-02-01T00:00:00.000' AS DateTime), NULL, NULL, 1, 0)
INSERT [dbo].[tblAppointment] ([ID], [PatientID], [DoctorID], [AppointmentDate], [Diagonasis], [Remarks], [IsActive], [IsDelete]) VALUES (1009, 5, 6, CAST(N'2018-02-01T00:00:00.000' AS DateTime), NULL, NULL, 1, 0)
INSERT [dbo].[tblAppointment] ([ID], [PatientID], [DoctorID], [AppointmentDate], [Diagonasis], [Remarks], [IsActive], [IsDelete]) VALUES (1010, 7, 6, CAST(N'2018-02-01T00:00:00.000' AS DateTime), NULL, NULL, 1, 0)
INSERT [dbo].[tblAppointment] ([ID], [PatientID], [DoctorID], [AppointmentDate], [Diagonasis], [Remarks], [IsActive], [IsDelete]) VALUES (1011, 9, 6, CAST(N'2018-02-01T00:00:00.000' AS DateTime), NULL, NULL, 1, 0)
INSERT [dbo].[tblAppointment] ([ID], [PatientID], [DoctorID], [AppointmentDate], [Diagonasis], [Remarks], [IsActive], [IsDelete]) VALUES (1012, 21, 6, CAST(N'2018-02-01T00:00:00.000' AS DateTime), NULL, NULL, 1, 0)
INSERT [dbo].[tblAppointment] ([ID], [PatientID], [DoctorID], [AppointmentDate], [Diagonasis], [Remarks], [IsActive], [IsDelete]) VALUES (1013, 26, 2, CAST(N'2018-02-08T00:00:00.000' AS DateTime), NULL, NULL, 1, 0)
INSERT [dbo].[tblAppointment] ([ID], [PatientID], [DoctorID], [AppointmentDate], [Diagonasis], [Remarks], [IsActive], [IsDelete]) VALUES (1014, 26, 28, CAST(N'2018-02-09T00:00:00.000' AS DateTime), NULL, NULL, 1, 0)
INSERT [dbo].[tblAppointment] ([ID], [PatientID], [DoctorID], [AppointmentDate], [Diagonasis], [Remarks], [IsActive], [IsDelete]) VALUES (1015, 30, 28, CAST(N'2018-02-15T00:00:00.000' AS DateTime), NULL, NULL, 1, 0)
INSERT [dbo].[tblAppointment] ([ID], [PatientID], [DoctorID], [AppointmentDate], [Diagonasis], [Remarks], [IsActive], [IsDelete]) VALUES (1016, 3, 8, CAST(N'2018-02-01T00:00:00.000' AS DateTime), N'tuttu', N'tut', 1, 0)
INSERT [dbo].[tblAppointment] ([ID], [PatientID], [DoctorID], [AppointmentDate], [Diagonasis], [Remarks], [IsActive], [IsDelete]) VALUES (1017, 30, 27, CAST(N'2018-02-07T00:00:00.000' AS DateTime), NULL, NULL, 1, 0)
INSERT [dbo].[tblAppointment] ([ID], [PatientID], [DoctorID], [AppointmentDate], [Diagonasis], [Remarks], [IsActive], [IsDelete]) VALUES (1018, 26, 28, CAST(N'2018-02-21T00:00:00.000' AS DateTime), N'cancer', N'recovered', 1, 0)
INSERT [dbo].[tblAppointment] ([ID], [PatientID], [DoctorID], [AppointmentDate], [Diagonasis], [Remarks], [IsActive], [IsDelete]) VALUES (1019, 25, 28, CAST(N'2018-02-13T00:00:00.000' AS DateTime), N'motu', N'patlu', 1, 0)
INSERT [dbo].[tblAppointment] ([ID], [PatientID], [DoctorID], [AppointmentDate], [Diagonasis], [Remarks], [IsActive], [IsDelete]) VALUES (1020, 9, 28, CAST(N'2018-02-01T00:00:00.000' AS DateTime), NULL, NULL, 1, 0)
INSERT [dbo].[tblAppointment] ([ID], [PatientID], [DoctorID], [AppointmentDate], [Diagonasis], [Remarks], [IsActive], [IsDelete]) VALUES (1021, 26, 2, CAST(N'2018-02-01T00:00:00.000' AS DateTime), NULL, NULL, 1, 0)
INSERT [dbo].[tblAppointment] ([ID], [PatientID], [DoctorID], [AppointmentDate], [Diagonasis], [Remarks], [IsActive], [IsDelete]) VALUES (1022, 9, 27, CAST(N'2018-02-02T00:00:00.000' AS DateTime), NULL, NULL, 1, 0)
INSERT [dbo].[tblAppointment] ([ID], [PatientID], [DoctorID], [AppointmentDate], [Diagonasis], [Remarks], [IsActive], [IsDelete]) VALUES (1023, 9, 2, CAST(N'2018-03-17T00:00:00.000' AS DateTime), N'gdh', N'dhdh', 1, 0)
SET IDENTITY_INSERT [dbo].[tblAppointment] OFF
SET IDENTITY_INSERT [dbo].[tblLog] ON 

INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (1, 2, N'32033', N'192.168.0.118', N'D8CB8A17178B', CAST(N'2018-02-19T12:19:23.737' AS DateTime), NULL, NULL, 2)
INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (2, 5, N'6262', N'192.168.0.118', N'D8CB8A17178B', CAST(N'2018-02-19T12:19:53.087' AS DateTime), NULL, NULL, 3)
INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (3, 2, N'12870', N'192.168.0.118', N'D8CB8A17178B', CAST(N'2018-02-19T12:26:05.810' AS DateTime), NULL, NULL, 2)
INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (4, 2, N'27767', N'192.168.0.118', N'D8CB8A17178B', CAST(N'2018-02-19T12:27:19.880' AS DateTime), NULL, NULL, 2)
INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (5, 1, N'8816', N'192.168.0.118', N'D8CB8A17178B', CAST(N'2018-02-19T12:30:29.870' AS DateTime), NULL, NULL, 1)
INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (6, 1, N'14345', N'192.168.0.118', N'D8CB8A17178B', CAST(N'2018-02-19T12:32:25.647' AS DateTime), NULL, NULL, 1)
INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (7, 1, N'10152', N'192.168.0.118', N'D8CB8A17178B', CAST(N'2018-02-19T12:36:51.283' AS DateTime), NULL, NULL, 1)
INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (8, 2, N'19275', N'192.168.0.118', N'D8CB8A17178B', CAST(N'2018-02-19T12:42:32.857' AS DateTime), NULL, NULL, 2)
INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (9, 1, N'34666', N'192.168.0.118', N'D8CB8A17178B', CAST(N'2018-02-19T12:43:18.850' AS DateTime), NULL, NULL, 1)
INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (10, 5, N'12514', N'192.168.0.118', N'D8CB8A17178B', CAST(N'2018-02-19T12:53:55.633' AS DateTime), NULL, NULL, 3)
INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (11, 1, N'27645', N'192.168.0.118', N'D8CB8A17178B', CAST(N'2018-02-19T13:05:55.817' AS DateTime), NULL, NULL, 1)
INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (12, 7, N'19342', N'192.168.0.118', N'D8CB8A17178B', CAST(N'2018-02-19T13:07:07.263' AS DateTime), NULL, NULL, 3)
INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (13, 1, N'34918', N'192.168.0.118', N'D8CB8A17178B', CAST(N'2018-02-19T13:11:32.033' AS DateTime), NULL, NULL, 1)
INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (14, 1, N'9657', N'192.168.0.118', N'D8CB8A17178B', CAST(N'2018-02-19T13:18:05.380' AS DateTime), NULL, NULL, 1)
INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (15, 1, N'46462', N'192.168.0.118', N'D8CB8A17178B', CAST(N'2018-02-19T13:19:29.620' AS DateTime), NULL, NULL, 1)
INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (16, 1, N'37472', N'192.168.0.118', N'D8CB8A17178B', CAST(N'2018-02-19T13:22:28.113' AS DateTime), NULL, NULL, 1)
INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (17, NULL, N'11760', N'192.168.0.118', N'D8CB8A17178B', CAST(N'2018-02-19T17:30:43.600' AS DateTime), NULL, NULL, NULL)
INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (18, NULL, N'43680', N'192.168.0.118', N'D8CB8A17178B', CAST(N'2018-02-19T17:30:50.550' AS DateTime), NULL, NULL, NULL)
INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (19, NULL, N'15682', N'192.168.0.118', N'D8CB8A17178B', CAST(N'2018-02-19T17:31:15.743' AS DateTime), NULL, NULL, NULL)
INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (20, NULL, N'18232', N'192.168.0.118', N'D8CB8A17178B', CAST(N'2018-02-19T17:31:44.277' AS DateTime), NULL, NULL, NULL)
INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (21, NULL, N'42554', N'192.168.0.118', N'D8CB8A17178B', CAST(N'2018-02-19T17:32:51.090' AS DateTime), NULL, NULL, NULL)
INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (22, 6, N'10279', N'192.168.0.118', N'D8CB8A17178B', CAST(N'2018-02-19T17:34:27.660' AS DateTime), NULL, NULL, 2)
INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (23, 5, N'26541', N'192.168.0.118', N'D8CB8A17178B', CAST(N'2018-02-19T17:34:47.057' AS DateTime), NULL, NULL, 3)
INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (24, NULL, N'29772', N'192.168.0.118', N'D8CB8A17178B', CAST(N'2018-02-19T17:35:17.837' AS DateTime), NULL, NULL, NULL)
INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (25, NULL, N'3327', N'192.168.0.118', N'D8CB8A17178B', CAST(N'2018-02-19T17:36:15.820' AS DateTime), NULL, NULL, NULL)
INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (26, NULL, N'35488', N'192.168.0.118', N'D8CB8A17178B', CAST(N'2018-02-19T17:36:25.240' AS DateTime), NULL, NULL, NULL)
INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (27, 5, N'41754', N'192.168.0.118', N'D8CB8A17178B', CAST(N'2018-02-19T17:36:48.193' AS DateTime), NULL, NULL, 3)
INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (28, 1, N'33790', N'192.168.0.118', N'D8CB8A17178B', CAST(N'2018-02-19T17:41:05.843' AS DateTime), NULL, NULL, 1)
INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (29, 2, N'13943', N'192.168.0.118', N'D8CB8A17178B', CAST(N'2018-02-19T17:41:20.230' AS DateTime), NULL, NULL, 2)
INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (30, 1, N'37230', N'192.168.0.118', N'D8CB8A17178B', CAST(N'2018-02-19T17:43:33.063' AS DateTime), NULL, NULL, 1)
INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (31, 1, N'30838', N'192.168.0.118', N'D8CB8A17178B', CAST(N'2018-02-19T17:45:28.010' AS DateTime), NULL, NULL, 1)
INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (32, 1, N'3900', N'192.168.0.118', N'D8CB8A17178B', CAST(N'2018-02-19T17:55:13.037' AS DateTime), NULL, NULL, 1)
INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (33, 2, N'46150', N'192.168.0.118', N'D8CB8A17178B', CAST(N'2018-02-19T17:57:14.723' AS DateTime), NULL, NULL, 2)
INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (34, 5, N'34806', N'192.168.0.118', N'D8CB8A17178B', CAST(N'2018-02-19T18:31:26.203' AS DateTime), NULL, NULL, 3)
INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (35, 1, N'386', N'192.168.0.118', N'D8CB8A17178B', CAST(N'2018-02-19T18:33:21.160' AS DateTime), NULL, NULL, 1)
INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (36, 6, N'32749', N'192.168.0.118', N'D8CB8A17178B', CAST(N'2018-02-19T19:00:58.760' AS DateTime), NULL, NULL, 2)
INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (37, 5, N'6999', N'192.168.0.118', N'D8CB8A17178B', CAST(N'2018-02-19T19:01:19.813' AS DateTime), NULL, NULL, 3)
INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (38, 5, N'42101', N'192.168.0.118', N'D8CB8A17178B', CAST(N'2018-02-19T19:01:38.373' AS DateTime), NULL, NULL, 3)
INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (39, 5, N'20374', N'192.168.0.118', N'D8CB8A17178B', CAST(N'2018-02-19T19:02:28.440' AS DateTime), NULL, NULL, 3)
INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (40, 5, N'23833', N'192.168.0.118', N'D8CB8A17178B', CAST(N'2018-02-19T19:04:54.780' AS DateTime), NULL, NULL, 3)
INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (41, 5, N'9464', N'192.168.0.118', N'D8CB8A17178B', CAST(N'2018-02-19T19:04:54.780' AS DateTime), NULL, NULL, 3)
INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (42, 2, N'2075', N'192.168.0.118', N'D8CB8A17178B', CAST(N'2018-02-19T19:05:05.723' AS DateTime), NULL, NULL, 2)
INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (43, 1, N'8232', N'192.168.0.118', N'D8CB8A17178B', CAST(N'2018-02-19T19:05:39.397' AS DateTime), NULL, NULL, 1)
INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (44, 5, N'31484', N'192.168.0.118', N'D8CB8A17178B', CAST(N'2018-02-19T19:25:52.827' AS DateTime), NULL, NULL, 3)
INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (45, 6, N'31004', N'192.168.0.118', N'D8CB8A17178B', CAST(N'2018-02-19T19:26:06.517' AS DateTime), NULL, NULL, 2)
INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (46, 1, N'40071', N'192.168.0.118', N'D8CB8A17178B', CAST(N'2018-02-20T11:10:54.483' AS DateTime), NULL, NULL, 1)
INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (47, 1, N'17177', N'192.168.0.118', N'D8CB8A17178B', CAST(N'2018-02-20T11:14:50.260' AS DateTime), NULL, NULL, 1)
INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (48, 2, N'10011', N'192.168.0.118', N'D8CB8A17178B', CAST(N'2018-02-20T11:32:35.967' AS DateTime), NULL, NULL, 2)
INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (49, 5, N'4128', N'192.168.0.118', N'D8CB8A17178B', CAST(N'2018-02-20T11:41:20.313' AS DateTime), NULL, NULL, 3)
INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (50, 5, N'42563', N'192.168.0.118', N'D8CB8A17178B', CAST(N'2018-02-20T12:19:08.993' AS DateTime), NULL, NULL, 3)
INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (51, 2, N'5897', N'192.168.0.118', N'D8CB8A17178B', CAST(N'2018-02-20T12:20:06.250' AS DateTime), NULL, NULL, 2)
INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (52, 6, N'19368', N'192.168.0.118', N'D8CB8A17178B', CAST(N'2018-02-20T12:24:06.993' AS DateTime), NULL, NULL, 2)
INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (53, 1, N'28867', N'192.168.0.118', N'D8CB8A17178B', CAST(N'2018-02-20T14:47:33.323' AS DateTime), NULL, NULL, 1)
INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (54, 5, N'31097', N'192.168.0.118', N'D8CB8A17178B', CAST(N'2018-02-20T16:06:49.953' AS DateTime), NULL, NULL, 3)
INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (55, 5, N'9899', N'192.168.0.118', N'D8CB8A17178B', CAST(N'2018-02-20T16:06:49.953' AS DateTime), NULL, NULL, 3)
INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (56, 1, N'27983', N'192.168.0.118', N'D8CB8A17178B', CAST(N'2018-02-20T17:09:28.377' AS DateTime), NULL, NULL, 1)
INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (57, 5, N'13395', N'192.168.0.118', N'D8CB8A17178B', CAST(N'2018-02-20T17:11:19.050' AS DateTime), NULL, NULL, 3)
INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (58, 6, N'36616', N'192.168.0.118', N'D8CB8A17178B', CAST(N'2018-02-20T17:11:49.790' AS DateTime), NULL, NULL, 2)
INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (59, 5, N'27115', N'192.168.0.118', N'D8CB8A17178B', CAST(N'2018-02-20T17:16:01.940' AS DateTime), NULL, NULL, 3)
INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (60, 6, N'15000', N'192.168.0.118', N'D8CB8A17178B', CAST(N'2018-02-20T17:16:10.460' AS DateTime), NULL, NULL, 2)
INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (61, 1, N'40442', N'192.168.0.118', N'D8CB8A17178B', CAST(N'2018-02-20T17:17:34.203' AS DateTime), NULL, NULL, 1)
INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (62, 5, N'274', N'192.168.0.118', N'D8CB8A17178B', CAST(N'2018-02-20T17:17:41.930' AS DateTime), NULL, NULL, 3)
INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (63, 6, N'17053', N'192.168.0.118', N'D8CB8A17178B', CAST(N'2018-02-20T17:17:51.217' AS DateTime), NULL, NULL, 2)
INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (64, 1, N'24131', N'192.168.0.118', N'D8CB8A17178B', CAST(N'2018-02-20T17:17:59.690' AS DateTime), NULL, NULL, 1)
INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (65, 5, N'25050', N'192.168.0.118', N'D8CB8A17178B', CAST(N'2018-02-20T17:19:12.137' AS DateTime), NULL, NULL, 3)
INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (66, 5, N'47028', N'192.168.0.118', N'D8CB8A17178B', CAST(N'2018-02-20T17:25:49.980' AS DateTime), NULL, NULL, 3)
INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (67, 5, N'7505', N'192.168.0.118', N'D8CB8A17178B', CAST(N'2018-02-20T17:26:01.690' AS DateTime), NULL, NULL, 3)
INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (68, 5, N'9171', N'192.168.0.118', N'D8CB8A17178B', CAST(N'2018-02-20T17:26:15.360' AS DateTime), NULL, NULL, 3)
INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (69, 6, N'10979', N'192.168.0.118', N'D8CB8A17178B', CAST(N'2018-02-20T17:26:22.090' AS DateTime), NULL, NULL, 2)
INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (70, 1, N'22284', N'192.168.0.118', N'D8CB8A17178B', CAST(N'2018-02-20T17:36:10.200' AS DateTime), NULL, NULL, 1)
INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (71, 5, N'31773', N'192.168.0.118', N'D8CB8A17178B', CAST(N'2018-02-20T17:44:49.000' AS DateTime), NULL, NULL, 3)
INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (72, 5, N'37781', N'192.168.0.118', N'D8CB8A17178B', CAST(N'2018-02-20T17:51:35.550' AS DateTime), NULL, NULL, 3)
INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (73, 6, N'18159', N'192.168.0.118', N'D8CB8A17178B', CAST(N'2018-02-20T17:51:54.770' AS DateTime), NULL, NULL, 2)
INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (74, 1, N'12314', N'192.168.0.118', N'D8CB8A17178B', CAST(N'2018-02-20T17:52:11.790' AS DateTime), NULL, NULL, 1)
INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (75, 5, N'3420', N'192.168.0.118', N'D8CB8A17178B', CAST(N'2018-02-20T17:52:24.487' AS DateTime), NULL, NULL, 3)
INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (76, 1, N'1376', N'192.168.0.118', N'D8CB8A17178B', CAST(N'2018-02-20T17:55:16.340' AS DateTime), NULL, NULL, 1)
INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (77, 1, N'10375', N'192.168.0.118', N'D8CB8A17178B', CAST(N'2018-02-20T17:55:37.653' AS DateTime), NULL, NULL, 1)
INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (78, 1, N'8643', N'192.168.0.118', N'D8CB8A17178B', CAST(N'2018-02-20T17:56:27.170' AS DateTime), NULL, NULL, 1)
INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (79, 1, N'30649', N'192.168.0.118', N'D8CB8A17178B', CAST(N'2018-02-20T17:58:20.890' AS DateTime), NULL, NULL, 1)
INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (80, 5, N'40416', N'192.168.0.118', N'D8CB8A17178B', CAST(N'2018-02-20T18:01:09.840' AS DateTime), NULL, NULL, 3)
INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (81, 6, N'30763', N'192.168.0.118', N'D8CB8A17178B', CAST(N'2018-02-20T18:01:25.350' AS DateTime), NULL, NULL, 2)
INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (82, 5, N'16825', N'192.168.0.118', N'D8CB8A17178B', CAST(N'2018-02-20T18:01:43.010' AS DateTime), NULL, NULL, 3)
INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (83, 6, N'9896', N'192.168.0.118', N'D8CB8A17178B', CAST(N'2018-02-20T18:01:54.727' AS DateTime), NULL, NULL, 2)
INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (84, 6, N'16318', N'192.168.0.118', N'D8CB8A17178B', CAST(N'2018-02-20T18:02:10.330' AS DateTime), NULL, NULL, 2)
INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (85, 1, N'40519', N'192.168.0.118', N'D8CB8A17178B', CAST(N'2018-02-20T18:11:38.960' AS DateTime), NULL, NULL, 1)
INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (86, 6, N'12167', N'192.168.0.118', N'D8CB8A17178B', CAST(N'2018-02-20T18:22:49.267' AS DateTime), NULL, NULL, 2)
INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (87, 1, N'35007', N'192.168.0.118', N'D8CB8A17178B', CAST(N'2018-02-20T18:23:07.340' AS DateTime), NULL, NULL, 1)
INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (88, 6, N'22945', N'192.168.0.118', N'D8CB8A17178B', CAST(N'2018-02-20T18:25:42.960' AS DateTime), NULL, NULL, 2)
INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (89, 1, N'44583', N'192.168.0.118', N'D8CB8A17178B', CAST(N'2018-02-20T18:37:53.657' AS DateTime), NULL, NULL, 1)
INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (90, 1, N'47718', N'192.168.0.118', N'D8CB8A17178B', CAST(N'2018-02-20T19:09:06.713' AS DateTime), NULL, NULL, 1)
INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (91, 27, N'41623', N'192.168.0.118', N'D8CB8A17178B', CAST(N'2018-02-20T19:10:00.020' AS DateTime), NULL, NULL, 2)
INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (92, 5, N'17413', N'192.168.0.118', N'D8CB8A17178B', CAST(N'2018-02-20T19:27:18.093' AS DateTime), NULL, NULL, 3)
INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (93, 5, N'4492', N'192.168.0.118', N'D8CB8A17178B', CAST(N'2018-02-20T19:31:49.240' AS DateTime), NULL, NULL, 3)
INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (94, 5, N'28583', N'192.168.0.118', N'D8CB8A17178B', CAST(N'2018-02-20T19:34:14.527' AS DateTime), NULL, NULL, 3)
INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (95, 5, N'17275', N'192.168.0.118', N'D8CB8A17178B', CAST(N'2018-02-20T19:34:33.310' AS DateTime), NULL, NULL, 3)
INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (96, 5, N'21174', N'192.168.0.118', N'D8CB8A17178B', CAST(N'2018-02-20T19:36:13.860' AS DateTime), NULL, NULL, 3)
INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (97, 5, N'37568', N'192.168.0.118', N'D8CB8A17178B', CAST(N'2018-02-20T19:36:33.807' AS DateTime), NULL, NULL, 3)
INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (98, 5, N'43712', N'192.168.0.118', N'D8CB8A17178B', CAST(N'2018-02-20T19:37:52.437' AS DateTime), NULL, NULL, 3)
INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (99, 5, N'29922', N'192.168.0.118', N'D8CB8A17178B', CAST(N'2018-02-21T09:29:42.100' AS DateTime), NULL, NULL, 3)
GO
INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (100, 1, N'17855', N'192.168.0.118', N'D8CB8A17178B', CAST(N'2018-02-21T09:31:38.793' AS DateTime), NULL, NULL, 1)
INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (101, 1, N'17675', N'192.168.0.118', N'D8CB8A17178B', CAST(N'2018-02-21T09:32:48.630' AS DateTime), NULL, NULL, 1)
INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (102, 1, N'44221', N'192.168.0.118', N'D8CB8A17178B', CAST(N'2018-02-21T09:42:29.133' AS DateTime), NULL, NULL, 1)
INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (103, 6, N'12567', N'192.168.0.118', N'D8CB8A17178B', CAST(N'2018-02-21T09:46:02.203' AS DateTime), NULL, NULL, 2)
INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (104, 5, N'35849', N'192.168.0.118', N'D8CB8A17178B', CAST(N'2018-02-21T09:48:03.243' AS DateTime), NULL, NULL, 3)
INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (105, 1, N'7489', N'192.168.0.118', N'D8CB8A17178B', CAST(N'2018-02-21T09:48:23.757' AS DateTime), NULL, NULL, 1)
INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (106, 1, N'9247', N'192.168.0.118', N'D8CB8A17178B', CAST(N'2018-02-21T09:57:35.040' AS DateTime), NULL, NULL, 1)
INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (107, 1, N'22903', N'192.168.0.118', N'D8CB8A17178B', CAST(N'2018-02-21T09:57:44.240' AS DateTime), NULL, NULL, 1)
INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (108, 1, N'12432', N'192.168.0.118', N'D8CB8A17178B', CAST(N'2018-02-21T10:00:07.217' AS DateTime), NULL, NULL, 1)
INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (109, 5, N'41533', N'192.168.0.118', N'D8CB8A17178B', CAST(N'2018-02-21T10:02:57.917' AS DateTime), NULL, NULL, 3)
INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (110, 6, N'15679', N'192.168.0.118', N'D8CB8A17178B', CAST(N'2018-02-21T10:03:05.807' AS DateTime), NULL, NULL, 2)
INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (111, 5, N'19005', N'192.168.0.118', N'D8CB8A17178B', CAST(N'2018-02-21T10:03:23.920' AS DateTime), NULL, NULL, 3)
INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (112, 5, N'23949', N'192.168.0.118', N'D8CB8A17178B', CAST(N'2018-02-21T10:03:37.337' AS DateTime), NULL, NULL, 3)
INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (113, 5, N'10983', N'192.168.0.118', N'D8CB8A17178B', CAST(N'2018-02-21T10:04:05.540' AS DateTime), NULL, NULL, 3)
INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (114, 5, N'35511', N'192.168.0.118', N'D8CB8A17178B', CAST(N'2018-02-21T10:04:27.853' AS DateTime), NULL, NULL, 3)
INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (115, 5, N'46544', N'192.168.0.118', N'D8CB8A17178B', CAST(N'2018-02-21T10:10:52.457' AS DateTime), NULL, NULL, 3)
INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (116, 5, N'23287', N'192.168.0.118', N'D8CB8A17178B', CAST(N'2018-02-21T10:24:05.550' AS DateTime), NULL, NULL, 3)
INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (117, 5, N'38711', N'192.168.0.118', N'D8CB8A17178B', CAST(N'2018-02-21T10:31:53.793' AS DateTime), NULL, NULL, 3)
INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (118, 5, N'38403', N'192.168.0.118', N'D8CB8A17178B', CAST(N'2018-02-21T10:33:37.190' AS DateTime), NULL, NULL, 3)
INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (119, 5, N'31812', N'192.168.0.118', N'D8CB8A17178B', CAST(N'2018-02-21T10:33:56.753' AS DateTime), NULL, NULL, 3)
INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (120, 5, N'14578', N'192.168.0.118', N'D8CB8A17178B', CAST(N'2018-02-21T10:34:58.393' AS DateTime), NULL, NULL, 3)
INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (121, 5, N'44417', N'192.168.0.118', N'D8CB8A17178B', CAST(N'2018-02-21T10:35:30.493' AS DateTime), NULL, NULL, 3)
INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (122, 5, N'41598', N'192.168.0.118', N'D8CB8A17178B', CAST(N'2018-02-21T10:35:41.713' AS DateTime), NULL, NULL, 3)
INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (123, 5, N'42334', N'192.168.0.118', N'D8CB8A17178B', CAST(N'2018-02-21T10:43:13.407' AS DateTime), NULL, NULL, 3)
INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (124, 5, N'41566', N'192.168.0.118', N'D8CB8A17178B', CAST(N'2018-02-21T10:43:45.353' AS DateTime), NULL, NULL, 3)
INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (125, 5, N'7241', N'192.168.0.118', N'D8CB8A17178B', CAST(N'2018-02-21T10:43:56.710' AS DateTime), NULL, NULL, 3)
INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (126, 6, N'34734', N'192.168.0.118', N'D8CB8A17178B', CAST(N'2018-02-21T10:44:12.700' AS DateTime), NULL, NULL, 2)
INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (127, 6, N'40586', N'192.168.0.118', N'D8CB8A17178B', CAST(N'2018-02-21T10:44:27.667' AS DateTime), NULL, NULL, 2)
INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (128, 1, N'1072', N'192.168.0.118', N'D8CB8A17178B', CAST(N'2018-02-21T10:44:42.350' AS DateTime), NULL, NULL, 1)
INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (129, 27, N'23457', N'192.168.0.118', N'D8CB8A17178B', CAST(N'2018-02-21T14:41:19.147' AS DateTime), NULL, NULL, 2)
INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (130, 1, N'19096', N'192.168.0.118', N'D8CB8A17178B', CAST(N'2018-02-21T14:41:49.067' AS DateTime), NULL, NULL, 1)
INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (131, 6, N'2765', N'192.168.0.118', N'D8CB8A17178B', CAST(N'2018-02-21T14:43:26.470' AS DateTime), NULL, NULL, 2)
INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (132, 1, N'8077', N'192.168.0.118', N'D8CB8A17178B', CAST(N'2018-02-21T14:51:12.277' AS DateTime), NULL, NULL, 1)
INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (133, 30, N'1382', N'192.168.0.118', N'D8CB8A17178B', CAST(N'2018-02-21T15:07:55.580' AS DateTime), NULL, NULL, 3)
INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (134, 1, N'16930', N'192.168.0.118', N'D8CB8A17178B', CAST(N'2018-02-21T15:08:38.597' AS DateTime), NULL, NULL, 1)
INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (135, 40, N'13183', N'192.168.0.118', N'D8CB8A17178B', CAST(N'2018-02-22T09:55:46.243' AS DateTime), NULL, NULL, 1)
INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (136, 40, N'7753', N'192.168.0.118', N'D8CB8A17178B', CAST(N'2018-02-22T09:58:49.090' AS DateTime), NULL, NULL, 1)
INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (137, 40, N'5181', N'192.168.0.118', N'D8CB8A17178B', CAST(N'2018-02-22T10:03:33.310' AS DateTime), NULL, NULL, 1)
INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (138, 5, N'25334', N'192.168.0.118', N'D8CB8A17178B', CAST(N'2018-02-22T10:03:41.373' AS DateTime), NULL, NULL, 3)
INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (139, 5, N'20568', N'192.168.0.118', N'D8CB8A17178B', CAST(N'2018-02-22T10:05:17.950' AS DateTime), NULL, NULL, 3)
INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (140, 5, N'14146', N'192.168.0.118', N'D8CB8A17178B', CAST(N'2018-02-22T10:05:40.037' AS DateTime), NULL, NULL, 3)
INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (141, 5, N'28236', N'192.168.0.118', N'D8CB8A17178B', CAST(N'2018-02-22T10:06:17.863' AS DateTime), NULL, NULL, 3)
INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (142, 5, N'17805', N'192.168.0.118', N'D8CB8A17178B', CAST(N'2018-02-22T10:06:46.613' AS DateTime), NULL, NULL, 3)
INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (143, 5, N'31088', N'192.168.0.118', N'D8CB8A17178B', CAST(N'2018-02-22T10:06:54.380' AS DateTime), NULL, NULL, 3)
INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (144, 5, N'662', N'192.168.0.118', N'D8CB8A17178B', CAST(N'2018-02-22T10:07:35.170' AS DateTime), NULL, NULL, 3)
INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (145, 5, N'14253', N'192.168.0.118', N'D8CB8A17178B', CAST(N'2018-02-22T10:08:12.347' AS DateTime), NULL, NULL, 3)
INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (146, 5, N'23556', N'192.168.0.118', N'D8CB8A17178B', CAST(N'2018-02-22T10:08:19.310' AS DateTime), NULL, NULL, 3)
INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (147, 5, N'46177', N'192.168.0.118', N'D8CB8A17178B', CAST(N'2018-02-22T10:09:05.020' AS DateTime), NULL, NULL, 3)
INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (148, 6, N'35811', N'192.168.0.118', N'D8CB8A17178B', CAST(N'2018-02-22T10:09:24.130' AS DateTime), NULL, NULL, 2)
INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (149, 5, N'22585', N'192.168.0.118', N'D8CB8A17178B', CAST(N'2018-02-22T10:09:43.267' AS DateTime), NULL, NULL, 3)
INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (150, 1, N'13648', N'192.168.0.118', N'D8CB8A17178B', CAST(N'2018-02-22T10:10:23.080' AS DateTime), NULL, NULL, 1)
INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (151, 1, N'9724', N'192.168.0.118', N'D8CB8A17178B', CAST(N'2018-02-22T10:11:33.633' AS DateTime), NULL, NULL, 1)
INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (152, 1, N'43857', N'192.168.0.118', N'D8CB8A17178B', CAST(N'2018-02-22T10:11:55.810' AS DateTime), NULL, NULL, 1)
INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (153, 1, N'28332', N'192.168.0.118', N'D8CB8A17178B', CAST(N'2018-02-22T10:12:42.320' AS DateTime), NULL, NULL, 1)
INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (154, 1, N'35250', N'192.168.0.118', N'D8CB8A17178B', CAST(N'2018-02-22T10:12:57.543' AS DateTime), NULL, NULL, 1)
INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (155, 1, N'29471', N'192.168.0.118', N'D8CB8A17178B', CAST(N'2018-02-22T10:13:10.797' AS DateTime), NULL, NULL, 1)
INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (156, 5, N'17010', N'192.168.0.118', N'D8CB8A17178B', CAST(N'2018-02-22T16:02:39.993' AS DateTime), NULL, NULL, 3)
INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (157, 30, N'40751', N'192.168.0.118', N'D8CB8A17178B', CAST(N'2018-02-22T17:05:32.677' AS DateTime), NULL, NULL, 3)
INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (158, 6, N'15328', N'192.168.0.118', N'D8CB8A17178B', CAST(N'2018-02-22T17:05:47.717' AS DateTime), NULL, NULL, 2)
INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (159, 27, N'21668', N'192.168.0.118', N'D8CB8A17178B', CAST(N'2018-02-22T17:06:04.190' AS DateTime), NULL, NULL, 2)
INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (160, 1, N'7519', N'192.168.0.118', N'D8CB8A17178B', CAST(N'2018-02-22T17:06:20.023' AS DateTime), NULL, NULL, 1)
INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (161, 30, N'5387', N'192.168.0.118', N'D8CB8A17178B', CAST(N'2018-02-22T17:07:19.720' AS DateTime), NULL, NULL, 3)
INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (162, 28, N'40', N'192.168.0.118', N'D8CB8A17178B', CAST(N'2018-02-22T17:07:47.630' AS DateTime), NULL, NULL, 2)
INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (163, 40, N'1772', N'192.168.0.118', N'D8CB8A17178B', CAST(N'2018-02-22T17:11:08.473' AS DateTime), NULL, NULL, 1)
INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (164, 5, N'26256', N'192.168.0.118', N'D8CB8A17178B', CAST(N'2018-02-22T17:13:07.643' AS DateTime), NULL, NULL, 3)
INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (165, 5, N'41251', N'192.168.0.118', N'D8CB8A17178B', CAST(N'2018-02-22T17:14:09.740' AS DateTime), NULL, NULL, 3)
INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (166, 6, N'20442', N'192.168.0.118', N'D8CB8A17178B', CAST(N'2018-02-22T17:38:00.943' AS DateTime), NULL, NULL, 2)
INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (167, 40, N'47080', N'192.168.0.118', N'D8CB8A17178B', CAST(N'2018-02-22T17:38:30.720' AS DateTime), NULL, NULL, 1)
INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (168, 6, N'6661', N'192.168.0.118', N'D8CB8A17178B', CAST(N'2018-02-22T19:10:53.593' AS DateTime), NULL, NULL, 2)
INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (169, 1, N'20936', N'192.168.0.118', N'D8CB8A17178B', CAST(N'2018-02-22T19:24:11.393' AS DateTime), NULL, NULL, 1)
INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (170, 21, N'5535', N'192.168.0.118', N'D8CB8A17178B', CAST(N'2018-02-23T09:38:59.520' AS DateTime), NULL, NULL, 3)
INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (171, 1, N'26988', N'192.168.0.118', N'D8CB8A17178B', CAST(N'2018-02-23T09:44:15.467' AS DateTime), NULL, NULL, 1)
INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (172, 1, N'37403', N'192.168.0.118', N'D8CB8A17178B', CAST(N'2018-02-23T09:44:41.683' AS DateTime), NULL, NULL, 1)
INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (173, 1, N'10156', N'192.168.0.118', N'D8CB8A17178B', CAST(N'2018-02-23T09:48:09.457' AS DateTime), NULL, NULL, 1)
INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (174, 1, N'46063', N'192.168.0.118', N'D8CB8A17178B', CAST(N'2018-02-23T09:54:55.940' AS DateTime), NULL, NULL, 1)
INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (175, 5, N'9502', N'192.168.0.118', N'D8CB8A17178B', CAST(N'2018-02-23T15:27:40.883' AS DateTime), NULL, NULL, 3)
INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (176, 50, N'12426', N'192.168.0.118', N'D8CB8A17178B', CAST(N'2018-02-23T17:36:54.520' AS DateTime), NULL, NULL, 1)
INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (177, 5, N'44355', N'192.168.0.118', N'D8CB8A17178B', CAST(N'2018-02-23T18:25:01.170' AS DateTime), NULL, NULL, 3)
INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (178, 1, N'32870', N'192.168.0.118', N'D8CB8A17178B', CAST(N'2018-02-23T19:07:40.207' AS DateTime), NULL, NULL, 1)
INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (179, 6, N'5516', N'192.168.0.118', N'D8CB8A17178B', CAST(N'2018-02-23T19:07:59.610' AS DateTime), NULL, NULL, 2)
INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (180, 1, N'43131', N'192.168.0.113', N'D8CB8A17178B', CAST(N'2018-02-24T11:16:21.423' AS DateTime), NULL, NULL, 1)
INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (181, 1, N'19653', N'192.168.0.113', N'D8CB8A17178B', CAST(N'2018-02-24T11:58:46.007' AS DateTime), NULL, NULL, 1)
INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (182, 1, N'20996', N'192.168.0.117', N'D8CB8A17178B', CAST(N'2018-02-24T14:25:37.133' AS DateTime), NULL, NULL, 1)
INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (183, 1, N'26037', N'192.168.0.117', N'D8CB8A17178B', CAST(N'2018-02-24T17:08:30.463' AS DateTime), NULL, NULL, 1)
INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (184, 1, N'694', N'192.168.0.117', N'D8CB8A17178B', CAST(N'2018-02-24T17:13:57.747' AS DateTime), NULL, NULL, 1)
INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (185, 1, N'8696', N'192.168.0.117', N'D8CB8A17178B', CAST(N'2018-02-24T17:16:00.873' AS DateTime), NULL, NULL, 1)
INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (186, 1, N'25959', N'192.168.0.117', N'D8CB8A17178B', CAST(N'2018-02-24T17:18:05.767' AS DateTime), NULL, NULL, 1)
INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (187, 1, N'40246', N'192.168.0.117', N'D8CB8A17178B', CAST(N'2018-02-24T17:18:55.327' AS DateTime), NULL, NULL, 1)
INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (188, 1, N'1863', N'192.168.0.117', N'D8CB8A17178B', CAST(N'2018-02-24T17:19:16.007' AS DateTime), NULL, NULL, 1)
INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (189, 1, N'12868', N'192.168.0.117', N'D8CB8A17178B', CAST(N'2018-02-24T17:19:30.857' AS DateTime), NULL, NULL, 1)
INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (190, 1, N'39296', N'192.168.0.117', N'D8CB8A17178B', CAST(N'2018-02-24T17:19:49.367' AS DateTime), NULL, NULL, 1)
INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (191, 1, N'10384', N'192.168.0.117', N'D8CB8A17178B', CAST(N'2018-02-24T17:20:01.810' AS DateTime), NULL, NULL, 1)
INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (192, 1, N'36427', N'192.168.0.117', N'D8CB8A17178B', CAST(N'2018-02-24T17:20:10.400' AS DateTime), NULL, NULL, 1)
INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (193, 1, N'46246', N'192.168.0.117', N'D8CB8A17178B', CAST(N'2018-02-24T17:28:08.713' AS DateTime), NULL, NULL, 1)
INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (194, 1, N'35464', N'192.168.0.117', N'D8CB8A17178B', CAST(N'2018-02-24T17:28:20.900' AS DateTime), NULL, NULL, 1)
INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (195, 1, N'41884', N'192.168.0.117', N'D8CB8A17178B', CAST(N'2018-02-24T17:30:52.507' AS DateTime), NULL, NULL, 1)
INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (196, 5, N'28824', N'192.168.0.117', N'D8CB8A17178B', CAST(N'2018-02-24T17:39:48.710' AS DateTime), NULL, NULL, 3)
INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (197, 1, N'4997', N'192.168.0.117', N'D8CB8A17178B', CAST(N'2018-02-24T17:42:58.740' AS DateTime), NULL, NULL, 1)
INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (198, 5, N'26578', N'192.168.0.117', N'D8CB8A17178B', CAST(N'2018-02-24T17:44:23.600' AS DateTime), NULL, NULL, 3)
INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (199, 6, N'13460', N'192.168.0.117', N'D8CB8A17178B', CAST(N'2018-02-24T17:44:30.777' AS DateTime), NULL, NULL, 2)
GO
INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (200, 5, N'3678', N'192.168.0.117', N'D8CB8A17178B', CAST(N'2018-02-24T17:45:01.147' AS DateTime), NULL, NULL, 3)
INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (201, 1, N'172', N'192.168.0.117', N'D8CB8A17178B', CAST(N'2018-02-24T18:07:33.667' AS DateTime), NULL, NULL, 1)
INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (202, 1, N'47483', N'192.168.0.117', N'D8CB8A17178B', CAST(N'2018-02-24T18:10:10.900' AS DateTime), NULL, NULL, 1)
INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (203, 5, N'34720', N'192.168.0.117', N'D8CB8A17178B', CAST(N'2018-02-24T18:10:56.120' AS DateTime), NULL, NULL, 3)
INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (204, 5, N'25379', N'192.168.0.117', N'D8CB8A17178B', CAST(N'2018-02-24T18:11:10.623' AS DateTime), NULL, NULL, 3)
INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (205, 6, N'16532', N'192.168.0.117', N'D8CB8A17178B', CAST(N'2018-02-24T18:11:29.943' AS DateTime), NULL, NULL, 2)
INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (206, 6, N'6529', N'192.168.0.117', N'D8CB8A17178B', CAST(N'2018-02-24T18:11:43.093' AS DateTime), NULL, NULL, 2)
INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (207, 5, N'7773', N'192.168.0.117', N'D8CB8A17178B', CAST(N'2018-02-24T18:11:49.680' AS DateTime), NULL, NULL, 3)
INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (208, 1, N'34389', N'192.168.0.117', N'D8CB8A17178B', CAST(N'2018-02-24T18:14:30.507' AS DateTime), NULL, NULL, 1)
INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (209, 1, N'14047', N'192.168.0.117', N'D8CB8A17178B', CAST(N'2018-02-24T18:14:38.320' AS DateTime), NULL, NULL, 1)
INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (210, 1, N'16363', N'192.168.0.117', N'D8CB8A17178B', CAST(N'2018-02-24T18:15:05.377' AS DateTime), NULL, NULL, 1)
INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (211, 1, N'47402', N'192.168.0.117', N'D8CB8A17178B', CAST(N'2018-02-24T18:15:26.463' AS DateTime), NULL, NULL, 1)
INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (212, 1, N'34704', N'192.168.0.117', N'D8CB8A17178B', CAST(N'2018-02-24T18:15:45.010' AS DateTime), NULL, NULL, 1)
INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (213, 1, N'47917', N'192.168.0.117', N'D8CB8A17178B', CAST(N'2018-02-24T18:16:07.570' AS DateTime), NULL, NULL, 1)
INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (214, 1, N'40938', N'192.168.0.117', N'D8CB8A17178B', CAST(N'2018-02-24T18:16:27.313' AS DateTime), NULL, NULL, 1)
INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (215, 1, N'7484', N'192.168.0.117', N'D8CB8A17178B', CAST(N'2018-02-24T18:16:52.240' AS DateTime), NULL, NULL, 1)
INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (216, 1, N'20448', N'192.168.0.117', N'D8CB8A17178B', CAST(N'2018-02-24T18:17:06.160' AS DateTime), NULL, NULL, 1)
INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (217, 1, N'3459', N'192.168.0.117', N'D8CB8A17178B', CAST(N'2018-02-24T18:17:17.820' AS DateTime), NULL, NULL, 1)
INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (218, 1, N'38147', N'192.168.0.117', N'D8CB8A17178B', CAST(N'2018-02-24T18:17:34.157' AS DateTime), NULL, NULL, 1)
INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (219, 1, N'33412', N'192.168.0.117', N'D8CB8A17178B', CAST(N'2018-02-24T18:17:44.747' AS DateTime), NULL, NULL, 1)
INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (220, 1, N'40442', N'192.168.0.117', N'D8CB8A17178B', CAST(N'2018-02-24T18:17:53.203' AS DateTime), NULL, NULL, 1)
INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (221, 1, N'11789', N'192.168.0.117', N'D8CB8A17178B', CAST(N'2018-02-24T18:18:43.830' AS DateTime), NULL, NULL, 1)
INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (222, 1, N'16947', N'192.168.0.117', N'D8CB8A17178B', CAST(N'2018-02-24T18:19:07.450' AS DateTime), NULL, NULL, 1)
INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (223, 1, N'5404', N'192.168.0.117', N'D8CB8A17178B', CAST(N'2018-02-24T18:19:22.200' AS DateTime), NULL, NULL, 1)
INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (224, 1, N'43833', N'192.168.0.117', N'D8CB8A17178B', CAST(N'2018-02-24T18:19:51.457' AS DateTime), NULL, NULL, 1)
INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (225, 1, N'6379', N'192.168.0.117', N'D8CB8A17178B', CAST(N'2018-02-24T18:20:16.367' AS DateTime), NULL, NULL, 1)
INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (226, 1, N'4918', N'192.168.0.117', N'D8CB8A17178B', CAST(N'2018-02-24T18:20:58.270' AS DateTime), NULL, NULL, 1)
INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (227, 1, N'18655', N'192.168.0.117', N'D8CB8A17178B', CAST(N'2018-02-24T18:21:21.410' AS DateTime), NULL, NULL, 1)
INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (228, 1, N'37244', N'192.168.0.117', N'D8CB8A17178B', CAST(N'2018-02-24T18:21:49.377' AS DateTime), NULL, NULL, 1)
INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (229, 1, N'13997', N'192.168.0.117', N'D8CB8A17178B', CAST(N'2018-02-24T18:22:06.200' AS DateTime), NULL, NULL, 1)
INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (230, 1, N'42053', N'192.168.0.117', N'D8CB8A17178B', CAST(N'2018-02-24T18:22:27.047' AS DateTime), NULL, NULL, 1)
INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (231, 1, N'9539', N'192.168.0.117', N'D8CB8A17178B', CAST(N'2018-02-24T18:22:44.380' AS DateTime), NULL, NULL, 1)
INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (232, 1, N'44447', N'192.168.0.117', N'D8CB8A17178B', CAST(N'2018-02-24T18:23:04.003' AS DateTime), NULL, NULL, 1)
INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (233, 1, N'35607', N'192.168.0.117', N'D8CB8A17178B', CAST(N'2018-02-24T18:23:27.903' AS DateTime), NULL, NULL, 1)
INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (234, 1, N'35687', N'192.168.0.117', N'D8CB8A17178B', CAST(N'2018-02-24T18:27:02.470' AS DateTime), NULL, NULL, 1)
INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (235, 1, N'10075', N'192.168.0.117', N'D8CB8A17178B', CAST(N'2018-02-24T18:35:42.070' AS DateTime), NULL, NULL, 1)
INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (236, 6, N'7863', N'192.168.0.107', N'D8CB8A17178B', CAST(N'2018-02-26T09:25:32.537' AS DateTime), NULL, NULL, 2)
INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (237, 6, N'23693', N'192.168.0.107', N'D8CB8A17178B', CAST(N'2018-02-26T09:27:23.303' AS DateTime), NULL, NULL, 2)
INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (238, 1, N'8846', N'192.168.0.107', N'D8CB8A17178B', CAST(N'2018-02-26T09:28:11.650' AS DateTime), NULL, NULL, 1)
INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (239, 1, N'25802', N'192.168.0.115', N'D8CB8A17178B', CAST(N'2018-03-12T11:50:13.397' AS DateTime), NULL, NULL, 1)
INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (240, 8, N'35724', N'192.168.0.115', N'D8CB8A17178B', CAST(N'2018-03-12T11:52:52.327' AS DateTime), NULL, NULL, 2)
INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (241, 1, N'26353', N'192.168.0.115', N'D8CB8A17178B', CAST(N'2018-03-12T11:54:28.900' AS DateTime), NULL, NULL, 1)
INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (242, 1, N'16342', N'192.168.0.115', N'D8CB8A17178B', CAST(N'2018-03-16T14:59:19.833' AS DateTime), NULL, NULL, 1)
INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (243, 2, N'27044', N'192.168.0.115', N'D8CB8A17178B', CAST(N'2018-03-16T15:02:48.653' AS DateTime), NULL, NULL, 2)
INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (244, 5, N'3723', N'192.168.0.115', N'D8CB8A17178B', CAST(N'2018-03-16T15:03:38.280' AS DateTime), NULL, NULL, 3)
INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (245, 2, N'3509', N'192.168.0.115', N'D8CB8A17178B', CAST(N'2018-03-16T15:04:44.097' AS DateTime), NULL, NULL, 2)
INSERT [dbo].[tblLog] ([ID], [UserID], [Token], [IPAddress], [MACAdderss], [LoggedIn], [LoggedOut], [Remarks], [RoleID]) VALUES (246, 2, N'46008', N'192.168.0.121', N'D8CB8A17178B', CAST(N'2018-03-17T10:17:14.867' AS DateTime), NULL, NULL, 2)
SET IDENTITY_INSERT [dbo].[tblLog] OFF
SET IDENTITY_INSERT [dbo].[tblRegister] ON 

INSERT [dbo].[tblRegister] ([ID], [RoleID], [UserID], [FirstName], [LastName], [Email], [Gender], [MobileNumber], [BirthDate], [Availability], [Specialization], [IsActive], [IsDelete], [Age]) VALUES (1, 1, 1, N'vikash', N'kumar', N'ivikash.8x@gmail.com', N'Male', 3453, CAST(N'2018-02-09' AS Date), N'null', N'Null', 1, 0, 0)
INSERT [dbo].[tblRegister] ([ID], [RoleID], [UserID], [FirstName], [LastName], [Email], [Gender], [MobileNumber], [BirthDate], [Availability], [Specialization], [IsActive], [IsDelete], [Age]) VALUES (2, 2, 2, N'jayesh', N'patil', N'jayeshnpatil13@gmail.com', N'Male', 3453, CAST(N'2018-02-14' AS Date), N'05:00 P.M-07:00 P.M', N'Cardiologist', 1, 0, 0)
INSERT [dbo].[tblRegister] ([ID], [RoleID], [UserID], [FirstName], [LastName], [Email], [Gender], [MobileNumber], [BirthDate], [Availability], [Specialization], [IsActive], [IsDelete], [Age]) VALUES (3, 3, 3, N'qais', N'buber', N'qaisbubere1995@gmail.com', N'Male', 111, CAST(N'2018-02-15' AS Date), N'null', N'Null', 1, 0, 22)
INSERT [dbo].[tblRegister] ([ID], [RoleID], [UserID], [FirstName], [LastName], [Email], [Gender], [MobileNumber], [BirthDate], [Availability], [Specialization], [IsActive], [IsDelete], [Age]) VALUES (4, 2, 4, N'nitesh', N'kumar', N'nitesh@gmail.com', N'Male', 22, CAST(N'2018-03-01' AS Date), N'05:00 P.M-07:00 P.M', N'Hepatologist', 1, 0, 0)
INSERT [dbo].[tblRegister] ([ID], [RoleID], [UserID], [FirstName], [LastName], [Email], [Gender], [MobileNumber], [BirthDate], [Availability], [Specialization], [IsActive], [IsDelete], [Age]) VALUES (5, 3, 5, N'akash', N'kumar', N'akash@gmail.com', N'Male', 234, CAST(N'2018-02-22' AS Date), N'null', N'Null', 1, 0, 11)
INSERT [dbo].[tblRegister] ([ID], [RoleID], [UserID], [FirstName], [LastName], [Email], [Gender], [MobileNumber], [BirthDate], [Availability], [Specialization], [IsActive], [IsDelete], [Age]) VALUES (6, 2, 6, N'rohit', N'pawane', N'rohit@gmail.com', N'Male', 3453, CAST(N'2018-02-08' AS Date), N'07:00 P.M-09:00 P.M', N'Hematologist', 1, 0, 0)
INSERT [dbo].[tblRegister] ([ID], [RoleID], [UserID], [FirstName], [LastName], [Email], [Gender], [MobileNumber], [BirthDate], [Availability], [Specialization], [IsActive], [IsDelete], [Age]) VALUES (7, 3, 7, N'shritej', N'maharaj', N'shritej@gmail.com', N'Male', 3453, CAST(N'2018-02-08' AS Date), N'null', N'Null', 1, 0, 23)
INSERT [dbo].[tblRegister] ([ID], [RoleID], [UserID], [FirstName], [LastName], [Email], [Gender], [MobileNumber], [BirthDate], [Availability], [Specialization], [IsActive], [IsDelete], [Age]) VALUES (8, 2, 8, N'Doctor', N'D', N'doctor@gmail.com', N'female', 123, CAST(N'2018-02-09' AS Date), N'07:00 P.M-09:00 P.M', N'Cardiologist', 1, 0, 0)
INSERT [dbo].[tblRegister] ([ID], [RoleID], [UserID], [FirstName], [LastName], [Email], [Gender], [MobileNumber], [BirthDate], [Availability], [Specialization], [IsActive], [IsDelete], [Age]) VALUES (9, 3, 9, N'rajan', N'parasr', N'rajan@gmail.com', N'Male', 11, CAST(N'2018-02-22' AS Date), N'null', N'Null', 1, NULL, 11)
INSERT [dbo].[tblRegister] ([ID], [RoleID], [UserID], [FirstName], [LastName], [Email], [Gender], [MobileNumber], [BirthDate], [Availability], [Specialization], [IsActive], [IsDelete], [Age]) VALUES (19, 1, 19, N'sf', N'xbbxc', N'zc@gmail.com', N'Male', 11, CAST(N'2018-02-15' AS Date), N'null', N'Null', 1, 0, NULL)
INSERT [dbo].[tblRegister] ([ID], [RoleID], [UserID], [FirstName], [LastName], [Email], [Gender], [MobileNumber], [BirthDate], [Availability], [Specialization], [IsActive], [IsDelete], [Age]) VALUES (20, 1, 20, N'tityiyti', N'dgs', N'sdgds', N'Male', 0, CAST(N'2018-02-01' AS Date), N'null', N'Null', 1, 0, NULL)
INSERT [dbo].[tblRegister] ([ID], [RoleID], [UserID], [FirstName], [LastName], [Email], [Gender], [MobileNumber], [BirthDate], [Availability], [Specialization], [IsActive], [IsDelete], [Age]) VALUES (21, 3, 21, N'abc', N'xyz', N'abc@gmail.com', N'female', 22, CAST(N'2018-02-15' AS Date), N'null', N'Null', 1, 0, NULL)
INSERT [dbo].[tblRegister] ([ID], [RoleID], [UserID], [FirstName], [LastName], [Email], [Gender], [MobileNumber], [BirthDate], [Availability], [Specialization], [IsActive], [IsDelete], [Age]) VALUES (22, NULL, 22, N's', NULL, NULL, NULL, 0, NULL, N'null', N'Null', 1, 0, NULL)
INSERT [dbo].[tblRegister] ([ID], [RoleID], [UserID], [FirstName], [LastName], [Email], [Gender], [MobileNumber], [BirthDate], [Availability], [Specialization], [IsActive], [IsDelete], [Age]) VALUES (23, NULL, 23, N'afs', NULL, NULL, NULL, 0, NULL, N'null', N'Null', 1, 0, NULL)
INSERT [dbo].[tblRegister] ([ID], [RoleID], [UserID], [FirstName], [LastName], [Email], [Gender], [MobileNumber], [BirthDate], [Availability], [Specialization], [IsActive], [IsDelete], [Age]) VALUES (24, NULL, 24, N'tyut', N's', NULL, NULL, 0, NULL, N'null', N'Null', 1, 0, NULL)
INSERT [dbo].[tblRegister] ([ID], [RoleID], [UserID], [FirstName], [LastName], [Email], [Gender], [MobileNumber], [BirthDate], [Availability], [Specialization], [IsActive], [IsDelete], [Age]) VALUES (25, 3, 25, N'motu', N'patlu', N'motu@gmail.com', N'female', 11, CAST(N'2018-02-09' AS Date), N'null', N'Null', 1, 0, NULL)
INSERT [dbo].[tblRegister] ([ID], [RoleID], [UserID], [FirstName], [LastName], [Email], [Gender], [MobileNumber], [BirthDate], [Availability], [Specialization], [IsActive], [IsDelete], [Age]) VALUES (26, 3, 26, N'deepika', N'padukone', N'deepika@gmail.com', N'female', 123, CAST(N'2018-02-16' AS Date), N'null', N'Null', 1, 0, 28)
INSERT [dbo].[tblRegister] ([ID], [RoleID], [UserID], [FirstName], [LastName], [Email], [Gender], [MobileNumber], [BirthDate], [Availability], [Specialization], [IsActive], [IsDelete], [Age]) VALUES (27, 2, 27, N'katrina', N'kaif', N'katrina@gmail.com', N'female', 134, CAST(N'2018-02-16' AS Date), N'03:00 P.M-05:00 P.M', N'Hematologist', 1, 0, NULL)
INSERT [dbo].[tblRegister] ([ID], [RoleID], [UserID], [FirstName], [LastName], [Email], [Gender], [MobileNumber], [BirthDate], [Availability], [Specialization], [IsActive], [IsDelete], [Age]) VALUES (28, 2, 28, N'emma', N'watson', N'emma@gmail.com', N'female', 12, CAST(N'2018-02-22' AS Date), N'10:00 A.M-12:00 A.M', N'Hematologist', 1, 0, NULL)
INSERT [dbo].[tblRegister] ([ID], [RoleID], [UserID], [FirstName], [LastName], [Email], [Gender], [MobileNumber], [BirthDate], [Availability], [Specialization], [IsActive], [IsDelete], [Age]) VALUES (29, 3, 29, N'asf', N'safsa', N'fasf', N'Male', 0, CAST(N'2018-02-15' AS Date), N'null', N'Null', 1, 0, 11)
INSERT [dbo].[tblRegister] ([ID], [RoleID], [UserID], [FirstName], [LastName], [Email], [Gender], [MobileNumber], [BirthDate], [Availability], [Specialization], [IsActive], [IsDelete], [Age]) VALUES (30, 3, 30, N'bruce ', N'wayne', N'batman@gmail.com', N'Male', 123, CAST(N'2018-02-16' AS Date), N'null', N'Null', 1, 0, 11)
INSERT [dbo].[tblRegister] ([ID], [RoleID], [UserID], [FirstName], [LastName], [Email], [Gender], [MobileNumber], [BirthDate], [Availability], [Specialization], [IsActive], [IsDelete], [Age]) VALUES (31, 3, 31, N'zvx', N'vxzv', NULL, N'female', 0, CAST(N'2018-02-08' AS Date), N'null', N'Null', 1, 0, NULL)
INSERT [dbo].[tblRegister] ([ID], [RoleID], [UserID], [FirstName], [LastName], [Email], [Gender], [MobileNumber], [BirthDate], [Availability], [Specialization], [IsActive], [IsDelete], [Age]) VALUES (32, 2, 32, N'zgvzv', N'zvz', N'zxvzxv', N'female', 23, CAST(N'2018-02-16' AS Date), N'07:00 P.M-09:00 P.M', N'Allergist', 1, 0, NULL)
INSERT [dbo].[tblRegister] ([ID], [RoleID], [UserID], [FirstName], [LastName], [Email], [Gender], [MobileNumber], [BirthDate], [Availability], [Specialization], [IsActive], [IsDelete], [Age]) VALUES (33, 3, 33, N'sdgs', N'dgsd', N'sdg', N'Male', 123, CAST(N'2018-02-15' AS Date), N'null', N'Null', 1, 0, 22)
INSERT [dbo].[tblRegister] ([ID], [RoleID], [UserID], [FirstName], [LastName], [Email], [Gender], [MobileNumber], [BirthDate], [Availability], [Specialization], [IsActive], [IsDelete], [Age]) VALUES (34, 3, 34, N'vzxv', N'zxv', N'zxvzxvzv', N'female', 123, CAST(N'2018-02-01' AS Date), N'null', N'Null', 1, 0, 11)
INSERT [dbo].[tblRegister] ([ID], [RoleID], [UserID], [FirstName], [LastName], [Email], [Gender], [MobileNumber], [BirthDate], [Availability], [Specialization], [IsActive], [IsDelete], [Age]) VALUES (35, 3, 35, N'sfsa', N'fasf', N'asfas', N'Male', 123, CAST(N'2018-02-01' AS Date), N'null', N'Null', 1, 0, 123)
INSERT [dbo].[tblRegister] ([ID], [RoleID], [UserID], [FirstName], [LastName], [Email], [Gender], [MobileNumber], [BirthDate], [Availability], [Specialization], [IsActive], [IsDelete], [Age]) VALUES (36, 3, 36, N'sdg', N'sdgsd', N'sdgdss', N'Male', 22, CAST(N'2018-02-15' AS Date), N'null', N'Null', 1, 0, 11)
INSERT [dbo].[tblRegister] ([ID], [RoleID], [UserID], [FirstName], [LastName], [Email], [Gender], [MobileNumber], [BirthDate], [Availability], [Specialization], [IsActive], [IsDelete], [Age]) VALUES (37, 3, 37, N'fsf', N'safsa', N'asfasasf', N'Male', 22, CAST(N'2018-02-15' AS Date), N'null', N'Null', 1, 0, 123)
INSERT [dbo].[tblRegister] ([ID], [RoleID], [UserID], [FirstName], [LastName], [Email], [Gender], [MobileNumber], [BirthDate], [Availability], [Specialization], [IsActive], [IsDelete], [Age]) VALUES (38, 3, 38, N'vxvsz', N'fsf', N'asfasasfsaf', N'female', 22, CAST(N'2018-02-15' AS Date), N'null', N'Null', 1, 0, 123)
INSERT [dbo].[tblRegister] ([ID], [RoleID], [UserID], [FirstName], [LastName], [Email], [Gender], [MobileNumber], [BirthDate], [Availability], [Specialization], [IsActive], [IsDelete], [Age]) VALUES (39, 3, 39, N'bxbx', N'cbx', N'xxcb', N'female', 22, CAST(N'2018-02-01' AS Date), N'null', N'Null', 1, 0, 123)
INSERT [dbo].[tblRegister] ([ID], [RoleID], [UserID], [FirstName], [LastName], [Email], [Gender], [MobileNumber], [BirthDate], [Availability], [Specialization], [IsActive], [IsDelete], [Age]) VALUES (40, 1, 40, N'admin', N'a', N'admin@gmail.com', N'female', 123, CAST(N'2018-02-15' AS Date), N'null', N'Null', 1, 0, NULL)
INSERT [dbo].[tblRegister] ([ID], [RoleID], [UserID], [FirstName], [LastName], [Email], [Gender], [MobileNumber], [BirthDate], [Availability], [Specialization], [IsActive], [IsDelete], [Age]) VALUES (41, 3, 41, N'gnc', N'vn', NULL, N'female', 0, CAST(N'2018-02-02' AS Date), N'null', N'Null', 1, 0, NULL)
INSERT [dbo].[tblRegister] ([ID], [RoleID], [UserID], [FirstName], [LastName], [Email], [Gender], [MobileNumber], [BirthDate], [Availability], [Specialization], [IsActive], [IsDelete], [Age]) VALUES (42, NULL, 42, N'sf', NULL, NULL, NULL, 0, NULL, N'null', N'Null', 1, 0, NULL)
INSERT [dbo].[tblRegister] ([ID], [RoleID], [UserID], [FirstName], [LastName], [Email], [Gender], [MobileNumber], [BirthDate], [Availability], [Specialization], [IsActive], [IsDelete], [Age]) VALUES (43, NULL, 43, N'fgdg', N'dsd', NULL, NULL, 0, NULL, N'null', N'Null', 1, 0, NULL)
INSERT [dbo].[tblRegister] ([ID], [RoleID], [UserID], [FirstName], [LastName], [Email], [Gender], [MobileNumber], [BirthDate], [Availability], [Specialization], [IsActive], [IsDelete], [Age]) VALUES (44, NULL, 44, N'hfh', NULL, NULL, NULL, 0, NULL, N'null', N'Null', 1, 0, NULL)
INSERT [dbo].[tblRegister] ([ID], [RoleID], [UserID], [FirstName], [LastName], [Email], [Gender], [MobileNumber], [BirthDate], [Availability], [Specialization], [IsActive], [IsDelete], [Age]) VALUES (45, 1, 45, N'fdh', N'fh', N'fhfdh', N'Male', 0, CAST(N'2018-02-09' AS Date), N'null', N'Null', 1, 0, NULL)
INSERT [dbo].[tblRegister] ([ID], [RoleID], [UserID], [FirstName], [LastName], [Email], [Gender], [MobileNumber], [BirthDate], [Availability], [Specialization], [IsActive], [IsDelete], [Age]) VALUES (46, 1, 46, N'Rohit', N'Pawane', N'rohitpawane@gmail.co', N'Male', 123, CAST(N'1992-08-06' AS Date), N'null', N'Null', 1, 0, NULL)
INSERT [dbo].[tblRegister] ([ID], [RoleID], [UserID], [FirstName], [LastName], [Email], [Gender], [MobileNumber], [BirthDate], [Availability], [Specialization], [IsActive], [IsDelete], [Age]) VALUES (47, 1, 47, N'xbxfb', N'ddgdg', N'fdgfdgdf', N'Male', 11, CAST(N'2018-02-08' AS Date), N'null', N'Null', 1, 0, NULL)
INSERT [dbo].[tblRegister] ([ID], [RoleID], [UserID], [FirstName], [LastName], [Email], [Gender], [MobileNumber], [BirthDate], [Availability], [Specialization], [IsActive], [IsDelete], [Age]) VALUES (48, 1, 48, N'asdas', N'asdas', N'sadsada', N'Male', 123, CAST(N'2018-02-16' AS Date), N'null', N'Null', 1, 0, NULL)
INSERT [dbo].[tblRegister] ([ID], [RoleID], [UserID], [FirstName], [LastName], [Email], [Gender], [MobileNumber], [BirthDate], [Availability], [Specialization], [IsActive], [IsDelete], [Age]) VALUES (49, 1, 49, N'sdgs', N'sdgsdg', N'sdgsdgsd', N'Male', 11, CAST(N'2018-02-08' AS Date), N'null', N'Null', 1, 0, NULL)
INSERT [dbo].[tblRegister] ([ID], [RoleID], [UserID], [FirstName], [LastName], [Email], [Gender], [MobileNumber], [BirthDate], [Availability], [Specialization], [IsActive], [IsDelete], [Age]) VALUES (50, 1, 50, N'manish', N'kumar', N'manish@gmail.com', N'Male', 11, CAST(N'2018-02-10' AS Date), N'null', N'Null', 1, 0, NULL)
INSERT [dbo].[tblRegister] ([ID], [RoleID], [UserID], [FirstName], [LastName], [Email], [Gender], [MobileNumber], [BirthDate], [Availability], [Specialization], [IsActive], [IsDelete], [Age]) VALUES (51, 1, 51, N'dfhdfh', N'dhdf', N'dfhfdhdfh', N'female', 123, CAST(N'2018-02-22' AS Date), N'null', N'Null', 1, 0, NULL)
INSERT [dbo].[tblRegister] ([ID], [RoleID], [UserID], [FirstName], [LastName], [Email], [Gender], [MobileNumber], [BirthDate], [Availability], [Specialization], [IsActive], [IsDelete], [Age]) VALUES (52, 1, 52, N'vikash', N'kumar', N'rohit@gmail.comfdsdf', N'female', 123, NULL, N'null', N'Null', 1, 0, NULL)
SET IDENTITY_INSERT [dbo].[tblRegister] OFF
SET IDENTITY_INSERT [dbo].[tblroles] ON 

INSERT [dbo].[tblroles] ([ID], [Title], [Remarks], [IsActive], [IsDelete]) VALUES (1, N'Admin', N'I am admin', 0, 0)
INSERT [dbo].[tblroles] ([ID], [Title], [Remarks], [IsActive], [IsDelete]) VALUES (2, N'Doctor', N'I am Doctor', 0, 0)
INSERT [dbo].[tblroles] ([ID], [Title], [Remarks], [IsActive], [IsDelete]) VALUES (3, N'Patient', N'I am Patient', 0, 0)
SET IDENTITY_INSERT [dbo].[tblroles] OFF
SET IDENTITY_INSERT [dbo].[tblUsers] ON 

INSERT [dbo].[tblUsers] ([ID], [RoleID], [Email], [Password], [IsActive], [IsDelete]) VALUES (1, 1, N'ivikash.8x@gmail.com', N'954074', 1, 0)
INSERT [dbo].[tblUsers] ([ID], [RoleID], [Email], [Password], [IsActive], [IsDelete]) VALUES (2, 2, N'jayeshnpatil13@gmail.com', N'qq', 1, 0)
INSERT [dbo].[tblUsers] ([ID], [RoleID], [Email], [Password], [IsActive], [IsDelete]) VALUES (3, 3, N'qaisbubere1995@gmail.com', N'qq', 1, 0)
INSERT [dbo].[tblUsers] ([ID], [RoleID], [Email], [Password], [IsActive], [IsDelete]) VALUES (4, 2, N'nitesh@gmail.com', N'qq', 1, 0)
INSERT [dbo].[tblUsers] ([ID], [RoleID], [Email], [Password], [IsActive], [IsDelete]) VALUES (5, 3, N'akash@gmail.com', N'qq', 1, 0)
INSERT [dbo].[tblUsers] ([ID], [RoleID], [Email], [Password], [IsActive], [IsDelete]) VALUES (6, 2, N'rohit@gmail.com', N'rohit123', 1, 0)
INSERT [dbo].[tblUsers] ([ID], [RoleID], [Email], [Password], [IsActive], [IsDelete]) VALUES (7, 3, N'shritej@gmail.com', N'qq', 1, 0)
INSERT [dbo].[tblUsers] ([ID], [RoleID], [Email], [Password], [IsActive], [IsDelete]) VALUES (8, 2, N'doctor@gmail.com', N'qq', 1, 0)
INSERT [dbo].[tblUsers] ([ID], [RoleID], [Email], [Password], [IsActive], [IsDelete]) VALUES (9, 3, N'rajan@gmail.com', N'qq', 1, NULL)
INSERT [dbo].[tblUsers] ([ID], [RoleID], [Email], [Password], [IsActive], [IsDelete]) VALUES (11, 3, N'patient@gmail.com', N'qq', 1, 0)
INSERT [dbo].[tblUsers] ([ID], [RoleID], [Email], [Password], [IsActive], [IsDelete]) VALUES (19, 1, N'zc@gmail.com', N'zxc', 1, 0)
INSERT [dbo].[tblUsers] ([ID], [RoleID], [Email], [Password], [IsActive], [IsDelete]) VALUES (20, 1, N'sdgds', NULL, 1, 0)
INSERT [dbo].[tblUsers] ([ID], [RoleID], [Email], [Password], [IsActive], [IsDelete]) VALUES (21, 3, N'abc@gmail.com', N'qqq', 1, 0)
INSERT [dbo].[tblUsers] ([ID], [RoleID], [Email], [Password], [IsActive], [IsDelete]) VALUES (22, NULL, NULL, NULL, 1, 0)
INSERT [dbo].[tblUsers] ([ID], [RoleID], [Email], [Password], [IsActive], [IsDelete]) VALUES (23, NULL, NULL, NULL, 1, 0)
INSERT [dbo].[tblUsers] ([ID], [RoleID], [Email], [Password], [IsActive], [IsDelete]) VALUES (24, NULL, NULL, NULL, 1, 0)
INSERT [dbo].[tblUsers] ([ID], [RoleID], [Email], [Password], [IsActive], [IsDelete]) VALUES (25, 3, N'motu@gmail.com', N'qq', 1, 0)
INSERT [dbo].[tblUsers] ([ID], [RoleID], [Email], [Password], [IsActive], [IsDelete]) VALUES (26, 3, N'deepika@gmail.com', N'qq', 1, 0)
INSERT [dbo].[tblUsers] ([ID], [RoleID], [Email], [Password], [IsActive], [IsDelete]) VALUES (27, 2, N'katrina@gmail.com', N'qq', 1, 0)
INSERT [dbo].[tblUsers] ([ID], [RoleID], [Email], [Password], [IsActive], [IsDelete]) VALUES (28, 2, N'emma@gmail.com', N'qq', 1, 0)
INSERT [dbo].[tblUsers] ([ID], [RoleID], [Email], [Password], [IsActive], [IsDelete]) VALUES (29, 3, N'fasf', N'asf', 1, 0)
INSERT [dbo].[tblUsers] ([ID], [RoleID], [Email], [Password], [IsActive], [IsDelete]) VALUES (30, 3, N'batman@gmail.com', N'qq', 1, 0)
INSERT [dbo].[tblUsers] ([ID], [RoleID], [Email], [Password], [IsActive], [IsDelete]) VALUES (31, 3, NULL, NULL, 1, 0)
INSERT [dbo].[tblUsers] ([ID], [RoleID], [Email], [Password], [IsActive], [IsDelete]) VALUES (32, 2, N'zxvzxv', N'zxv', 1, 0)
INSERT [dbo].[tblUsers] ([ID], [RoleID], [Email], [Password], [IsActive], [IsDelete]) VALUES (33, 3, N'sdg', N'sdg', 1, 0)
INSERT [dbo].[tblUsers] ([ID], [RoleID], [Email], [Password], [IsActive], [IsDelete]) VALUES (34, 3, N'zxvzxvzv', N'zxvzxv', 1, 0)
INSERT [dbo].[tblUsers] ([ID], [RoleID], [Email], [Password], [IsActive], [IsDelete]) VALUES (35, 3, N'asfas', N'asf', 1, 0)
INSERT [dbo].[tblUsers] ([ID], [RoleID], [Email], [Password], [IsActive], [IsDelete]) VALUES (36, 3, N'sdgdss', N'sdg', 1, 0)
INSERT [dbo].[tblUsers] ([ID], [RoleID], [Email], [Password], [IsActive], [IsDelete]) VALUES (37, 3, N'asfasasf', N'asf', 1, 0)
INSERT [dbo].[tblUsers] ([ID], [RoleID], [Email], [Password], [IsActive], [IsDelete]) VALUES (38, 3, N'asfasasfsaf', N'saf', 1, 0)
INSERT [dbo].[tblUsers] ([ID], [RoleID], [Email], [Password], [IsActive], [IsDelete]) VALUES (39, 3, N'xxcb', N'xcbx', 1, 0)
INSERT [dbo].[tblUsers] ([ID], [RoleID], [Email], [Password], [IsActive], [IsDelete]) VALUES (40, 1, N'admin@gmail.com', N'qq', 1, 0)
INSERT [dbo].[tblUsers] ([ID], [RoleID], [Email], [Password], [IsActive], [IsDelete]) VALUES (41, 3, NULL, N'jl', 1, 0)
INSERT [dbo].[tblUsers] ([ID], [RoleID], [Email], [Password], [IsActive], [IsDelete]) VALUES (42, NULL, NULL, NULL, 1, 0)
INSERT [dbo].[tblUsers] ([ID], [RoleID], [Email], [Password], [IsActive], [IsDelete]) VALUES (43, NULL, NULL, NULL, 1, 0)
INSERT [dbo].[tblUsers] ([ID], [RoleID], [Email], [Password], [IsActive], [IsDelete]) VALUES (44, NULL, NULL, NULL, 1, 0)
INSERT [dbo].[tblUsers] ([ID], [RoleID], [Email], [Password], [IsActive], [IsDelete]) VALUES (45, 1, N'fhfdh', N'fdh', 1, 0)
INSERT [dbo].[tblUsers] ([ID], [RoleID], [Email], [Password], [IsActive], [IsDelete]) VALUES (46, 1, N'rohitpawane@gmail.co', N'Rohit@123', 1, 0)
INSERT [dbo].[tblUsers] ([ID], [RoleID], [Email], [Password], [IsActive], [IsDelete]) VALUES (47, 1, N'fdgfdgdf', N'dfgfdg', 1, 0)
INSERT [dbo].[tblUsers] ([ID], [RoleID], [Email], [Password], [IsActive], [IsDelete]) VALUES (48, 1, N'sadsada', N'asdsaas', 1, 0)
INSERT [dbo].[tblUsers] ([ID], [RoleID], [Email], [Password], [IsActive], [IsDelete]) VALUES (49, 1, N'sdgsdgsd', N'sdg', 1, 0)
INSERT [dbo].[tblUsers] ([ID], [RoleID], [Email], [Password], [IsActive], [IsDelete]) VALUES (50, 1, N'manish@gmail.com', N'qq', 1, 0)
INSERT [dbo].[tblUsers] ([ID], [RoleID], [Email], [Password], [IsActive], [IsDelete]) VALUES (51, 1, N'dfhfdhdfh', N'dfhdf', 1, 0)
INSERT [dbo].[tblUsers] ([ID], [RoleID], [Email], [Password], [IsActive], [IsDelete]) VALUES (52, 1, N'rohit@gmail.comfdsdf', N'Rohit@123', 1, 0)
SET IDENTITY_INSERT [dbo].[tblUsers] OFF
ALTER TABLE [dbo].[tblLog]  WITH CHECK ADD  CONSTRAINT [log_fk] FOREIGN KEY([UserID])
REFERENCES [dbo].[tblUsers] ([ID])
GO
ALTER TABLE [dbo].[tblLog] CHECK CONSTRAINT [log_fk]
GO
ALTER TABLE [dbo].[tblRegister]  WITH CHECK ADD  CONSTRAINT [register_fk] FOREIGN KEY([UserID])
REFERENCES [dbo].[tblUsers] ([ID])
GO
ALTER TABLE [dbo].[tblRegister] CHECK CONSTRAINT [register_fk]
GO
ALTER TABLE [dbo].[tblUsers]  WITH CHECK ADD  CONSTRAINT [users_fk] FOREIGN KEY([RoleID])
REFERENCES [dbo].[tblroles] ([ID])
GO
ALTER TABLE [dbo].[tblUsers] CHECK CONSTRAINT [users_fk]
GO
/****** Object:  StoredProcedure [dbo].[spAppointment]    Script Date: 20-03-2018 16:54:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[spAppointment]
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
GO
/****** Object:  StoredProcedure [dbo].[spDocDetails]    Script Date: 20-03-2018 16:54:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

    CREATE proc [dbo].[spDocDetails]
  (@RoleID int 
  )
  AS 
  BEGIN
   select UserID,FirstName,LastName from tblRegister where RoleID=@RoleID
   END
GO
/****** Object:  StoredProcedure [dbo].[spDocDrop]    Script Date: 20-03-2018 16:54:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  create proc [dbo].[spDocDrop]
  (@ID int 
  )
  AS 
  BEGIN
   select UserID,FirstName,LastName from tblRegister where ID=@ID
   END
GO
/****** Object:  StoredProcedure [dbo].[spDocInfo]    Script Date: 20-03-2018 16:54:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[spDocInfo]
(
@DoctorID int
)
AS
BEGIN
select * from viewAppointmentDoc where DoctorID=@DoctorID
end
GO
/****** Object:  StoredProcedure [dbo].[spEditProfile]    Script Date: 20-03-2018 16:54:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[spEditProfile]
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
GO
/****** Object:  StoredProcedure [dbo].[spEmail]    Script Date: 20-03-2018 16:54:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 create proc [dbo].[spEmail]
  (
  @Email varchar(50)
  )
  AS 
  BEGIN
  select * from tblRegister where Email=@Email

  END
GO
/****** Object:  StoredProcedure [dbo].[spForgotPass]    Script Date: 20-03-2018 16:54:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[spForgotPass]
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
/****** Object:  StoredProcedure [dbo].[spPatDrop]    Script Date: 20-03-2018 16:54:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Batch submitted through debugger: SQLQuery2.sql|167|1|C:\Users\Admin\source\repos\ClinicAdminAppMVC\ClinicAdminAppMVC\SQLQuery2.sql
    create proc [dbo].[spPatDrop]
  (@ID int 
  )
  AS 
  BEGIN
   select UserID,FirstName,LastName from tblRegister where ID=@ID
   END
GO
/****** Object:  StoredProcedure [dbo].[spPatientDetails]    Script Date: 20-03-2018 16:54:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
    create proc [dbo].[spPatientDetails]
  (@RoleID int 
  )
  AS 
  BEGIN
   select UserID,FirstName,LastName from tblRegister where RoleID=@RoleID
   END
GO
/****** Object:  StoredProcedure [dbo].[spPatientDetals]    Script Date: 20-03-2018 16:54:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
    create proc [dbo].[spPatientDetals]
  (@RoleID int 
  )
  AS 
  BEGIN
   select UserID,FirstName,LastName from tblRegister where RoleID=@RoleID
   END
GO
/****** Object:  StoredProcedure [dbo].[spPatInfo]    Script Date: 20-03-2018 16:54:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[spPatInfo]
(
@PatientID int
)
AS
BEGIN
select * from viewAppointmentPat where PatientID=@PatientID
end
GO
/****** Object:  StoredProcedure [dbo].[spRegister]    Script Date: 20-03-2018 16:54:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[spRegister]
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
GO
/****** Object:  StoredProcedure [dbo].[spSignIn]    Script Date: 20-03-2018 16:54:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[spSignIn]
(
@Email varchar(50),
@Password varchar(50),
@IPAddress varchar(50),
@MACAddress varchar(50)
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
insert into tblLog(UserID,RoleID,LoggedIn,Token,IPAddress,MACAdderss ) values(@UserID,@RoleID,GETDATE(), @token,@IPAddress,@MACAddress)
select * from tblRegister where Email=@Email
 
end
else
begin
raiserror('User not present',11,1)
end
end
GO
/****** Object:  StoredProcedure [dbo].[updateApp]    Script Date: 20-03-2018 16:54:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[updateApp]
(
@ID int,
@Diagonasis varchar(500),
@Remarks varchar(500)
)
AS
BEGIN
update  tblAppointment set Diagonasis=@Diagonasis, Remarks=@Remarks where ID=@ID
END
GO
USE [master]
GO
ALTER DATABASE [ClinicAdminAppMVC] SET  READ_WRITE 
GO
