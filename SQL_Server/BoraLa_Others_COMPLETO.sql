USE [BoraLa]
GO

DROP VIEW IF EXISTS [dbo].[ActiveUsers];
DROP VIEW IF EXISTS [dbo].[ActivePromoters];
DROP VIEW IF EXISTS [dbo].[RegisteredSpaces];
DROP VIEW IF EXISTS [dbo].[ActiveEvents];
DROP VIEW IF EXISTS [dbo].[PastEvents];
DROP VIEW IF EXISTS [dbo].[ShowSchedule];
DROP INDEX IF EXISTS INDEX_SpacesSchedules ON [dbo].[SpacesSchedules];
GO

--------------------------
--Número de Utilizadores--
--------------------------

CREATE VIEW [dbo].[ActiveUsers]
AS
SELECT COUNT(ID_User) AS NumberUsers FROM Users;
GO

------------------------
--Número de Promotores--
------------------------

CREATE VIEW [dbo].[ActivePromoters]
AS
SELECT COUNT(ID_Promoter) AS NumberPromoters FROM Promoters;
GO

---------------------
--Número de Espaços--
---------------------

CREATE VIEW [dbo].[RegisteredSpaces]
AS
SELECT COUNT(ID_Space) AS NumberSpaces FROM Spaces;
GO

-----------------------------
--Eventos Futuros/Presentes--
-----------------------------

CREATE VIEW [dbo].[ActiveEvents]
AS
SELECT e.Name, e.Date, e.Time, et.Name AS EventTypeName,  est.Name AS EventSubTypeName
FROM Events e INNER JOIN 
(SELECT * FROM EventSubTypes) est ON e.ID_EventSubtype = est.ID_EventSubType INNER JOIN
(SELECT * FROM EventTypes) et ON et.ID_EventType = est.ID_EventType
WHERE e.Date >= GETDATE();
GO

--------------------
--Eventos Passados--
--------------------

CREATE VIEW [dbo].[PastEvents]
AS
SELECT e.Name, e.Date, e.Time, et.Name AS EventTypeName,  est.Name AS EventSubTypeName
FROM Events e INNER JOIN 
(SELECT * FROM EventSubTypes) est ON e.ID_EventSubtype = est.ID_EventSubType INNER JOIN
(SELECT * FROM EventTypes) et ON et.ID_EventType = est.ID_EventType
WHERE e.Date < GETDATE();
GO

-----------------------
--Horários por Espaço--
-----------------------

CREATE VIEW [dbo].[ShowSchedule]
AS
SELECT sp.ID_Space, se.WeekDay, se.OpenHour, se.CloseHour FROM SpacesSchedules se INNER JOIN
(SELECT * FROM Spaces) sp ON sp.ID_Space = se.ID_Space
GO

----------------------------
-- Index para os horarios --
----------------------------
CREATE INDEX INDEX_SpacesSchedules ON SpacesSchedules(ID_Space, WeekDay); ---- tabela com chave composta
GO


----------------------------------
-- Func calc media ratings Espaços
----------------------------------
CREATE OR ALTER FUNCTION CalcAverageRatingsSpaces(@ID_Space INT) 
RETURNS DECIMAL(2,1)
AS
BEGIN 
	DECLARE @avgRatingSpaces DECIMAL (2,1)
	SELECT @avgRatingSpaces = AVG(Rating) 
		FROM SpacesRatings
		WHERE ID_Space = @ID_Space
	RETURN @avgRatingSpaces
END
GO

----------------------------------
-- Func calc media ratings Eventos
----------------------------------
CREATE OR ALTER FUNCTION CalcAverageRatingsEvents(@ID_Event INT) 
RETURNS DECIMAL(2,1)
AS
BEGIN 
	DECLARE @avgRatingEvents DECIMAL (2,1)
	SELECT @avgRatingEvents = AVG(Rating) 
		FROM EventsRatings
		WHERE ID_Event = @ID_Event
	RETURN @avgRatingEvents
END
GO

----------------------------------------
-- TRG para actualizar rating espaços
----------------------------------------
CREATE OR ALTER TRIGGER UpdateAVGRatingSpaces
	ON SpacesRatings
	AFTER INSERT
AS
BEGIN
	UPDATE Spaces SET AverageRating = (SELECT [dbo].[CalcAverageRatingsSpaces](i.ID_Space))
	FROM Spaces s INNER JOIN INSERTED as i ON s.ID_Space = i.ID_Space 
END

GO
----------------------------------------
-- TRG para actualizar rating eventos
----------------------------------------
CREATE OR ALTER TRIGGER UpdateAVGRatingEvents
	ON EventsRatings
	AFTER INSERT
AS
BEGIN
--DECLARE @ID_Event INT;
--	SELECT @ID_Event = ID_Event FROM INSERTED;
	UPDATE Events SET AverageRating = (SELECT [dbo].[CalcAverageRatingsEvents](i.ID_Event))
	FROM Events as e INNER JOIN INSERTED as i ON e.ID_Event = i.ID_Event 
END

GO

-------------------------------------------------------------------------
-- TRG para mandar horario como HTML para o atributo horario nos Espaços
-------------------------------------------------------------------------

CREATE OR ALTER TRIGGER TriggerInsertSpaceSchedule
ON dbo.SpacesSchedules
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @ID_Space INT;

    -- Obter o ID_Space inserido
    SELECT @ID_Space = ID_Space FROM INSERTED;

    -- Atualizar o atributo Schedule na tabela Spaces
    UPDATE dbo.Spaces
    SET Schedule = (
        SELECT 
            STUFF((
                SELECT ', ' + 
                       DATENAME(WEEKDAY, OpenHour) + ': ' + 
                       CONVERT(VARCHAR, OpenHour, 108) + ' - ' + 
                       CONVERT(VARCHAR, CloseHour, 108)
                FROM dbo.SpacesSchedules
                WHERE ID_Space = @ID_Space
                FOR XML PATH('')), 1, 2, '')
    )
    WHERE ID_Space = @ID_Space;
END;
