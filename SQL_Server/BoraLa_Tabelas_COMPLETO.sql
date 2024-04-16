USE [master]
GO
IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = 'BoraLa')
BEGIN
	CREATE DATABASE [BoraLa]
END
USE [BoraLa]

DROP TABLE IF EXISTS [SpacesReports];
DROP TABLE IF EXISTS [EventsReports];
DROP TABLE IF EXISTS [ReportsTypes];
DROP TABLE IF EXISTS [Notifications];
DROP TABLE IF EXISTS [SpacesSchedules];
DROP TABLE IF EXISTS [SpacesRatings];
DROP TABLE IF EXISTS [EventsRatings];
DROP TABLE IF EXISTS [FavoritesSpaces];
DROP TABLE IF EXISTS [FavoritesEventTypes];
DROP TABLE IF EXISTS [Pictures];
DROP TABLE IF EXISTS [Events];
DROP TABLE IF EXISTS [EventSubTypes];
DROP TABLE IF EXISTS [EventTypes];
DROP TABLE IF EXISTS [Promoters];
DROP TABLE IF EXISTS [PromoterCategories];
DROP TABLE IF EXISTS [Spaces];
DROP TABLE IF EXISTS [Users];
DROP TABLE IF EXISTS [Credentials];
DROP TABLE IF EXISTS [ChangeLog];
DROP TABLE IF EXISTS [ERRORS];
-- _________________________________________________________________________________________________________________________
-- Table ERRORS
-- _________________________________________________________________________________________________________________________
GO
CREATE TABLE [dbo].[ERRORS](
	ErrorID INT IDENTITY (1, 1),
	UserName VARCHAR(100),
	ErrorNumber INT,
	ErrorState INT,
	ErrorSeverity INT,
	ErrorLine INT,
	ErrorProcedure VARCHAR(MAX),
	ErrorMessage VARCHAR(MAX),
	ErrorDateTime DATETIME
);

-- _________________________________________________________________________________________________________________________
-- Table ChangeLog
-- _________________________________________________________________________________________________________________________
GO
CREATE TABLE [dbo].[ChangeLog] (
	ID_ChangeLog INT IDENTITY (1,1) PRIMARY KEY,
	LogText NVARCHAR(500) NOT NULL,
	Date DATETIME DEFAULT GETDATE(),
	Username NVARCHAR(50)
);

-- _________________________________________________________________________________________________________________________
-- Table Credentials
-- _________________________________________________________________________________________________________________________
GO
CREATE TABLE [dbo].[Credentials] (
	ID_Credential INT IDENTITY (1,1) PRIMARY KEY,
	Email NVARCHAR(50) UNIQUE NOT NULL,
	[Password] NVARCHAR(20) NOT NULL,
	[Role] NVARCHAR(20) NOT NULL,

	CONSTRAINT CHK_Password CHECK (len([Password]) BETWEEN 8 AND 20)
);

-- _________________________________________________________________________________________________________________________
-- Table Users
-- _________________________________________________________________________________________________________________________
GO
CREATE TABLE [dbo].[Users](
	ID_User INT IDENTITY(1,1) NOT NULL,
	Name NVARCHAR(100) NOT NULL,
	Location GEOGRAPHY NOT NULL,
	BirthDate DATE NOT NULL,
	ProfilePicture NVARCHAR(50) NULL,
	ID_Credential INT NOT NULL,

	CONSTRAINT PK_Users_ID_User PRIMARY KEY(ID_User),
	CONSTRAINT FK_Users_Credentials FOREIGN KEY (ID_Credential) REFERENCES [dbo].[Credentials](ID_Credential)
);

-- _________________________________________________________________________________________________________________________
-- Table Spaces
-- _________________________________________________________________________________________________________________________
GO
CREATE TABLE [dbo].[Spaces](
	ID_Space INT IDENTITY (1,1) PRIMARY KEY, 
	[Name] NVARCHAR(150) NOT NULL,
	[Address] NVARCHAR(500) NOT NULL,
	Coordinates GEOGRAPHY NOT NULL,
	Capacity INT CHECK (Capacity > 10) NOT NULL,
	AverageRating DECIMAL(2,1) NULL DEFAULT 0, -- Virá de uma funcao dentro de um trigger que é ativada após inserções de ratings
	Schedule XML NULL
);

-- _________________________________________________________________________________________________________________________
-- Table PromoterCategories
-- _________________________________________________________________________________________________________________________
GO
CREATE TABLE [dbo].[PromoterCategories] (
	ID_PromoterCategory INT IDENTITY (1,1) PRIMARY KEY,
	Name NVARCHAR (50) NOT NULL,
	ServiceDescription NVARCHAR(1000) NOT NULL,
	Fee MONEY NULL,

	CONSTRAINT CHK_Fee CHECK (Fee BETWEEN 0 AND 100)
);

-- _________________________________________________________________________________________________________________________
-- Table Promoters
-- _________________________________________________________________________________________________________________________
GO
CREATE TABLE [dbo].[Promoters] (
	ID_Promoter INT IDENTITY (1,1) PRIMARY KEY,
	Name NVARCHAR(25) NOT NULL,
	Description NVARCHAR(1000) NOT NULL,
	ID_Credential INT UNIQUE,
	ID_PromoterCategory INT,

	FOREIGN KEY (ID_Credential) REFERENCES Credentials(ID_Credential) ON DELETE NO ACTION,
	FOREIGN KEY (ID_PromoterCategory) REFERENCES PromoterCategories (ID_PromoterCategory) ON DELETE NO ACTION
);

-- _________________________________________________________________________________________________________________________
-- Table EventTypes
-- _________________________________________________________________________________________________________________________
GO
CREATE TABLE [dbo].[EventTypes] (
	ID_EventType INT IDENTITY(1,1) PRIMARY KEY,
	Name NVARCHAR(20) NOT NULL,
);

-- _________________________________________________________________________________________________________________________
-- Table EventSubTypes
-- _________________________________________________________________________________________________________________________
GO
CREATE TABLE [dbo].[EventSubTypes] (
	ID_EventSubType INT IDENTITY(1,1) PRIMARY KEY,
	ID_EventType INT,
	Name NVARCHAR(50) NOT NULL,
	TargetAge INT NULL,

	FOREIGN KEY (ID_EventType) REFERENCES EventTypes(ID_EventType) ON DELETE NO ACTION,
	CONSTRAINT CHK_TargetAge CHECK (TargetAge BETWEEN 1 AND 100)
);

-- _________________________________________________________________________________________________________________________
-- Table Events
-- _________________________________________________________________________________________________________________________
GO
CREATE TABLE [dbo].[Events] (
	ID_Event INT IDENTITY(1,1) PRIMARY KEY,
	[Name] NVARCHAR(150) NOT NULL,
	AverageRating DECIMAL(2,1) NULL DEFAULT 0, -- Virá de uma funcao dentro de um trigger que é ativada após inserções de ratings
	[Date] DATE NOT NULL,
	[Time] TIME NULL,
	Duration TIME CHECK(Duration >= '00:15:00') NULL,
	MinPrice DECIMAL(7,2) CHECK(MinPrice >= 0) NOT NULL,
	MaxPrice DECIMAL (7,2) CHECK(MaxPrice > 0) NOT NULL,
	MinAge INT CHECK(MinAge >= 0) NOT NULL,
	Acessibility BIT NULL, -- 1:true 0:false NULL:desconhecido
	[Description] NVARCHAR(2000) NOT NULL,
	Observations NVARCHAR(1000) NULL,
	PromoterIsOwner BIT NOT NULL, --1:true 0:false

	ID_EventSubtype INT CONSTRAINT FK_EventSubtype_Events FOREIGN KEY (ID_EventSubType) REFERENCES EventSubTypes(ID_EventSubType) NOT NULL,
	ID_Promoter INT CONSTRAINT FK_Promoter_Events FOREIGN KEY (ID_Promoter) REFERENCES Promoters(ID_Promoter) NOT NULL,
	ID_Space INT CONSTRAINT FK_Space_Events FOREIGN KEY (ID_Space) REFERENCES Spaces(ID_Space) NOT NULL
);

-- _________________________________________________________________________________________________________________________
-- Table Pictures
-- _________________________________________________________________________________________________________________________
GO
CREATE TABLE [dbo].[Pictures] (
	ID_Picture INT IDENTITY(1,1) PRIMARY KEY,
	[Name] NVARCHAR(50) NOT NULL,
	Link VARCHAR(150) NOT NULL,
	UploadDate DATETIME DEFAULT GETDATE() NOT NULL,
	ID_User INT NULL,
	ID_Promoter INT NULL,
	ID_Space INT NULL,
	ID_Event INT NULL,

	CHECK ((ID_User IS NOT NULL AND ID_Promoter IS NULL) OR (ID_Promoter IS NOT NULL AND ID_User IS NULL)),
	CHECK ((ID_Space IS NOT NULL AND ID_Event IS NULL ) OR (ID_Event IS NOT NULL AND ID_Space IS NULL)),

	CONSTRAINT FK_User_Pictures FOREIGN KEY (ID_User) REFERENCES Users(ID_User),
	CONSTRAINT FK_Promoter_Pictures FOREIGN KEY (ID_Promoter) REFERENCES Promoters(ID_Promoter),
	CONSTRAINT FK_Space_Pictures FOREIGN KEY (ID_Promoter) REFERENCES Promoters(ID_Promoter),
	CONSTRAINT FK_Event_Pictures FOREIGN KEY (ID_Promoter) REFERENCES Promoters(ID_Promoter)
);

-- _________________________________________________________________________________________________________________________
-- Table FavoritesEventTypes
-- _________________________________________________________________________________________________________________________
GO
CREATE TABLE [dbo].[FavoritesEventTypes](
	ID_FavoritesEvents INT IDENTITY(1,1) NOT NULL,
	ID_User INT,
	ID_EventType INT NULL,
	ID_EventSubType INT NULL,

	CHECK ((ID_EventType IS NOT NULL AND ID_EventSubType IS NULL) OR (ID_EventSubType IS NOT NULL AND ID_EventType IS NULL)),

	CONSTRAINT PK_FavoritesEventTypes_ID_FavoriteEvents PRIMARY KEY(ID_FavoritesEvents),
	CONSTRAINT FK_FavoritesEventTypes_ID_User FOREIGN KEY(ID_User) REFERENCES Users(ID_User),
	CONSTRAINT FK_FavoritesEventTypes_ID_EventType FOREIGN KEY(ID_EventType) REFERENCES EventTypes(ID_EventType),
	CONSTRAINT FK_FavoritesEventTypes_ID_EventSubType FOREIGN KEY(ID_EventSubType) REFERENCES EventSubTypes(ID_EventSubType)
);

-- _________________________________________________________________________________________________________________________
-- Table FavoritesSpaces
-- _________________________________________________________________________________________________________________________
GO
CREATE TABLE [dbo].[FavoritesSpaces](
	ID_FavoritesSpaces INT IDENTITY(1,1) NOT NULL,
	ID_User INT,
	ID_Space INT,

	CONSTRAINT PK_FavoritesSpace_ID_FavoriteSpaces PRIMARY KEY(ID_FavoritesSpaces),
	CONSTRAINT FK_FavoritesSpace_ID_User FOREIGN KEY(ID_User) REFERENCES Users(ID_User),
	CONSTRAINT FK_FavoritesSpace_ID_Space FOREIGN KEY(ID_Space) REFERENCES Spaces(ID_Space)
);

-- _________________________________________________________________________________________________________________________
-- Table EventsRatings
-- _________________________________________________________________________________________________________________________
GO
CREATE TABLE [dbo].[EventsRatings] (
	ID_EventRating INT IDENTITY(1,1) PRIMARY KEY,
	Title NVARCHAR(50) NOT NULL,
	Rating INT CHECK (Rating BETWEEN 1 AND 5) NOT NULL,
	Comment NVARCHAR(1000) NULL,
	[Date] DATETIME DEFAULT GETDATE() NOT NULL,

	ID_User INT CONSTRAINT FK_User_EventsRatings FOREIGN KEY (ID_User) REFERENCES Users(ID_User) NOT NULL,
	ID_Event INT CONSTRAINT FK_Event_EventsRatings FOREIGN KEY (ID_Event) REFERENCES Events(ID_Event) NOT NULL
);

-- _________________________________________________________________________________________________________________________
-- Table SpacesRatings
-- _________________________________________________________________________________________________________________________
GO
CREATE TABLE [dbo].[SpacesRatings] (
	ID_SpaceRating INT IDENTITY(1,1) PRIMARY KEY,
	Title NVARCHAR(50) NOT NULL,
	Rating INT CHECK (Rating BETWEEN 1 AND 5) NOT NULL,
	Comment NVARCHAR(1000) NULL,
	[Date] DATETIME DEFAULT GETDATE() NOT NULL,

	ID_User INT CONSTRAINT FK_User_SpacesRatings FOREIGN KEY (ID_User) REFERENCES Users(ID_User) NOT NULL,
	ID_Space INT CONSTRAINT FK_Space_SpacesRatings FOREIGN KEY (ID_Space) REFERENCES Spaces(ID_Space) NOT NULL
);

-- _________________________________________________________________________________________________________________________
-- Table SpacesSchedules
-- _________________________________________________________________________________________________________________________
GO
CREATE TABLE [dbo].[SpacesSchedules] (
	ID_Space INT CONSTRAINT FK_Space_SpacesSchedules FOREIGN KEY (ID_Space) REFERENCES Spaces(ID_Space) NOT NULL,
	[WeekDay] INT CHECK (WeekDay BETWEEN 1 AND 7) NOT NULL, -- 1 para domingo, 7 para sábado 
	OpenHour TIME NOT NULL,
	CloseHour TIME NOT NULL,

	PRIMARY KEY (ID_Space, WeekDay)
);

-- _________________________________________________________________________________________________________________________
-- Table Notifications
-- _________________________________________________________________________________________________________________________
GO
CREATE TABLE [dbo].[Notifications](
	ID_Notification INT IDENTITY(1,1) NOT NULL,
	ID_User INT,
	ID_Event INT,
	Description NVARCHAR(100) NULL,

	CONSTRAINT PK_Notifications_ID_Notification PRIMARY KEY(ID_Notification),
	CONSTRAINT FK_Notifications_ID_User FOREIGN KEY(ID_User) REFERENCES Users(ID_User),
	CONSTRAINT FK_Notifications_ID_Event FOREIGN KEY(ID_Event) REFERENCES Events(ID_Event)
);

-- _________________________________________________________________________________________________________________________
-- Table ReportsTypes
-- _________________________________________________________________________________________________________________________
GO
CREATE TABLE [dbo].[ReportsTypes](
	ID_ReportType INT IDENTITY(1,1) NOT NULL,
	Type NVARCHAR(50) NOT NULL,
	Description NVARCHAR(100) NOT NULL,

	CONSTRAINT PK_ReportsTypes_ID_ReportType PRIMARY KEY(ID_ReportType)
);

-- _________________________________________________________________________________________________________________________
-- Table EventsReports
-- _________________________________________________________________________________________________________________________
GO
CREATE TABLE [dbo].[EventsReports](
	ID_EventReport INT IDENTITY(1,1) NOT NULL,
	ID_User INT NOT NULL,
	ID_Event INT NOT NULL,
	ID_ReportType INT NOT NULL,
	Date DATE NOT NULL,
	Comment NVARCHAR(100) NULL,

	CONSTRAINT PK_EventsReports_ID_EventReport PRIMARY KEY(ID_EventReport),
	CONSTRAINT FK_EventsReports_ID_User FOREIGN KEY(ID_User) REFERENCES Users(ID_User),
	CONSTRAINT FK_EventsReports_ID_Event FOREIGN KEY(ID_Event) REFERENCES Events(ID_Event),
	CONSTRAINT FK_EventsReports_ID_ReportType FOREIGN KEY(ID_ReportType) REFERENCES ReportsTypes(ID_ReportType)
);

-- _________________________________________________________________________________________________________________________
-- Table SpacesReports
-- _________________________________________________________________________________________________________________________
GO
CREATE TABLE [dbo].[SpacesReports](
	ID_SpaceReport INT IDENTITY(1,1) NOT NULL,
	ID_User INT NOT NULL,
	ID_Space INT NOT NULL,
	ID_ReportType INT NOT NULL,
	Date DATE NOT NULL,
	Comment NVARCHAR(100) NULL,

	CONSTRAINT PK_SpacesReports_ID_SpaceReport PRIMARY KEY(ID_SpaceReport),
	CONSTRAINT FK_SpacesReports_ID_User FOREIGN KEY(ID_User) REFERENCES Users(ID_User),
	CONSTRAINT FK_SpacesReports_ID_Space FOREIGN KEY(ID_Space) REFERENCES Spaces(ID_Space),
	CONSTRAINT FK_SpacesReports_ID_ReportType FOREIGN KEY(ID_ReportType) REFERENCES ReportsTypes(ID_ReportType)
);

--_____________________________
--
--      CORRECÇÕES
--_____________________________

--_____________________________
--      Tabela Users
--_____________________________
USE BoraLa;

-- Adicionar atributo ID_Credential
ALTER TABLE Users
ADD ID_Credential INT; 
-- Adicionar como FK
ALTER TABLE Users
ADD CONSTRAINT FK_Crential_Users
FOREIGN KEY (ID_Credential) REFERENCES [dbo].[Credentials](ID_Credential);

UPDATE Users
SET ID_Credential = 1
WHERE ID_User=1;

UPDATE Users
SET ID_Credential = 2
WHERE ID_User=2;

UPDATE Users
SET ID_Credential = 3
WHERE ID_User=3;

UPDATE Users
SET ID_Credential = 4
WHERE ID_User=4;

UPDATE Users
SET ID_Credential = 5
WHERE ID_User=5;

UPDATE Users
SET ID_Credential = 6 
WHERE ID_User=6; -- este user foi criado para testar o procedure create e o trigger para log, por isso dá erro (n tem credenciais)

INSERT INTO ReportsTypes ([Type], [Description])
VALUES 
    ('Conteúdo Ofensivo', 'Contúdo ofensivo, quer através de palavras ou ações.'),
    ('Discurso de ódio', 'Conteúdo que apela ao ódio, violência ou até racismo/xenofobia.'),
    ('Bullying', 'Conteúdo que atenta contra o bem estar de alguém.'),
	('Conteúdo de nudez ou sexual', 'Conteúdo de cariz sexual ou com nudez explicita.'),
	('Violência Gráfica', 'Exibição ou conteúdo com violência gráfica como mutilações.'),
	('Informações Falsas', 'Divulgações de informações/conteúdo falso ou difamatório.'),
	('SPAM', 'Conteúdo sem interesse, ou não relacionado com o evento indicado.'),
	('Exploração infantil', 'Conteúdo que atenta aos direitos da criança.'),
	('Exploração animal', 'Conteúdo que atenta aos direitos dos animais.')