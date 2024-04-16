USE [BoraLa]

----------------------------
-- Index para os horarios --
----------------------------
CREATE INDEX INDEX_SpacesSchedules ON SpacesSchedules(ID_Space, WeekDay); ---- tabela com chave composta
GO


----------------------------------
-- Func calc media ratings Espaços
----------------------------------
CREATE OR ALTER FUNCTION CalcAverageRatingsSpaces() 
RETURNS DECIMAL(2,1)
AS
BEGIN 
	DECLARE @avgRatingSpaces DECIMAL (2,1)
	SELECT @avgRatingSpaces = AVG(Rating) 
		FROM SpacesRatings
	RETURN @avgRatingSpaces
END
GO

----------------------------------
-- Func calc media ratings Eventos
----------------------------------
CREATE OR ALTER FUNCTION CalcAverageRatingsEvents() 
RETURNS DECIMAL(2,1)
AS
BEGIN 
	DECLARE @avgRatingEvents DECIMAL (2,1)
	SELECT @avgRatingEvents = AVG(Rating) 
		FROM EventsRatings
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
	UPDATE Spaces SET AverageRating = (SELECT [dbo].[CalcAverageRatingsSpaces]())
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
	UPDATE Events SET AverageRating = (SELECT [dbo].[CalcAverageRatingsEvents]())
END

GO

-------------------------------------------------------------------------
-- TRG para mandar horario como HTML para o atributo horario nos Espaços
-------------------------------------------------------------------------

CREATE TRIGGER TriggerInsertSpaceSchedule
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
