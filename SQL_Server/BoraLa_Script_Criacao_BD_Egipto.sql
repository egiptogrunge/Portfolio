USE [master]
GO

IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = 'BoraLa')
BEGIN
	CREATE DATABASE [BoraLa]
END

GO

USE [BoraLa]
--
DROP TABLE IF EXISTS [Spaces];
DROP TABLE IF EXISTS [SpacesSchedules];

GO


CREATE TABLE [dbo].[Spaces](
ID_Space INT IDENTITY (1,1) PRIMARY KEY, 
[Name] NVARCHAR(150) NOT NULL,
[Address] NVARCHAR(500) NOT NULL,
Coordinates GEOGRAPHY NOT NULL,
Capacity INT CHECK (Capacity > 10) NOT NULL,
AverageRating DECIMAL(2,1) NULL DEFAULT 0, -- Virá de uma funcao dentro de um trigger que é ativada após inserções de ratings
Schedule NVARCHAR(150) NULL ---- virá de um trigger na insercao da tabela shcedules
);

CREATE TABLE [dbo].[SpacesSchedules] (
ID_Space INT CONSTRAINT FK_Space_SpacesSchedules FOREIGN KEY (ID_Space) REFERENCES Spaces(ID_Space) NOT NULL,
[WeekDay] INT CHECK (WeekDay BETWEEN 1 AND 7) NOT NULL, -- 1 para domingo, 7 para sábado 
OpenHour TIME NOT NULL,
CloseHour TIME NOT NULL,

PRIMARY KEY (ID_Space, WeekDay)
);

CREATE TABLE [dbo].[SpacesRatings] (
ID_SpaceRating INT IDENTITY(1,1) PRIMARY KEY,
Title NVARCHAR(50) NOT NULL,
Rating INT CHECK (Rating BETWEEN 1 AND 5) NOT NULL,
Comment NVARCHAR(1000) NULL,
[Date] DATETIME DEFAULT GETDATE() NOT NULL,

ID_User INT CONSTRAINT FK_User_SpacesRatings FOREIGN KEY (ID_User) REFERENCES Users(ID_User) NOT NULL,
ID_Space INT CONSTRAINT FK_Space_SpacesRatings FOREIGN KEY (ID_Space) REFERENCES Spaces(ID_Space) NOT NULL
);

CREATE TABLE [dbo].[EventsRatings] (
ID_EventRating INT IDENTITY(1,1) PRIMARY KEY,
Title NVARCHAR(50) NOT NULL,
Rating INT CHECK (Rating BETWEEN 1 AND 5) NOT NULL,
Comment NVARCHAR(1000) NULL,
[Date] DATETIME DEFAULT GETDATE() NOT NULL,

ID_User INT CONSTRAINT FK_User_EventsRatings FOREIGN KEY (ID_User) REFERENCES Users(ID_User) NOT NULL,
ID_Event INT CONSTRAINT FK_Event_EventsRatings FOREIGN KEY (ID_Event) REFERENCES [Events](ID_Event) NOT NULL
);

CREATE TABLE [dbo].[Pictures] (
ID_Picture INT IDENTITY(1,1) PRIMARY KEY,
[Name] NVARCHAR(50) NOT NULL,
Link VARCHAR(150) NOT NULL, --ESTAVA EM FALTA
UploadDate DATETIME DEFAULT GETDATE() NOT NULL,--ESTAVA EM FALTA
ID_User INT NULL,
ID_Promoter INT NULL,
ID_Space INT NULL,
ID_Event INT NULL,

CHECK ((ID_User IS NOT NULL AND ID_Promoter IS NULL) OR (ID_Promoter IS NOT NULL AND ID_User IS NULL)),
CHECK ((ID_Space IS NOT NULL AND ID_Event IS NULL ) OR (ID_Event IS NOT NULL AND ID_Space IS NULL)),

CONSTRAINT FK_User_Pictures FOREIGN KEY (ID_User) REFERENCES Users(ID_User),
CONSTRAINT FK_Promoter_Pictures FOREIGN KEY (ID_Promoter) REFERENCES Promoters(ID_Promoter),
CONSTRAINT FK_Space_Pictures FOREIGN KEY (ID_Promoter) REFERENCES Promoters(ID_Promoter),
CONSTRAINT FK_Event_Pictures FOREIGN KEY (ID_Promoter) REFERENCES Promoters(ID_Promoter),

);

CREATE TABLE [dbo].[Events] (
ID_Event INT IDENTITY(1,1),
[Name] NVARCHAR(150) NOT NULL,
AverageRating DECIMAL(2,1) NULL DEFAULT 0, -- Virá de uma funcao dentro de um trigger que é ativada após inserções de ratings
[Date] DATE NOT NULL,
[Time] TIME NULL,
Duration TIME CHECK(Duration >= '00:15:00') NULL,
MinPrice DECIMAL(7,2) CHECK(MinPrice >= 0) NOT NULL,
MaxPrice DECIMAL (7,2) CHECK(MaxPrice > 0) NOT NULL,
MinAge INT CHECK(MinAge BETWEEN 1 AND 17) NULL,
Acessibility BIT NULL, -- 1:true 0:false NULL:desconhecido
[Description] NVARCHAR(2000) NOT NULL,
Observations NVARCHAR(1000) NULL,
PromoterIsOwner BIT NOT NULL, --1:true 0:false

ID_EventSubtype INT CONSTRAINT FK_EventSubtype_Events FOREIGN KEY (ID_EventSubtype) REFERENCES EventsSubtypes(ID_EventSubtype) NOT NULL,
ID_Promoter INT CONSTRAINT FK_Promoter_Events FOREIGN KEY (ID_Promoter) REFERENCES Promoters(ID_Promoter) NOT NULL,
ID_Space INT CONSTRAINT FK_Space_Events FOREIGN KEY (ID_Space) REFERENCES Spaces(ID_Space) NOT NULL
);