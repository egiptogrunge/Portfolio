USE [BoraLa]

-----------------------
-- SPACES Procedures --
-----------------------

-------------------
-- Insert Space  --
-------------------
GO
CREATE OR ALTER PROCEDURE InsertSpace 
@Name NVARCHAR(150),
@Address NVARCHAR(500),
@Coordinates GEOGRAPHY,
@Capacity INT,
@AverageRating DECIMAL(2,1)

AS
BEGIN
	BEGIN TRY
		BEGIN TRAN
		INSERT INTO [dbo].[Spaces] 
		([Name]
		, [Address]
		, [Coordinates]
		, [Capacity]
		, [AverageRating])
			VALUES (@Name, @Address, @Coordinates, @Capacity, @AverageRating)
		COMMIT TRAN

	END TRY
	BEGIN CATCH
		ROLLBACK TRAN

		DECLARE @ErrorMessage NVARCHAR(4000);
		DECLARE @ErrorSeverity INT;
		DECLARE @ErrorState INT;

		SELECT
			@ErrorMessage = ERROR_MESSAGE()
		   ,@ErrorSeverity = ERROR_SEVERITY()
		   ,@ErrorState = ERROR_STATE();

		INSERT INTO [dbo].[Errors]
			VALUES (SUSER_SNAME(), 
			ERROR_NUMBER(), 
			ERROR_STATE(), 
			ERROR_SEVERITY(), 
			ERROR_LINE(), 
			ERROR_PROCEDURE(), 
			ERROR_MESSAGE(), 
			GETDATE());

		RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
	END CATCH
END
GO

-------------------
-- delete Space  --
-------------------
GO
CREATE OR ALTER PROCEDURE DeleteSpace
	@ID_Space INT
AS
BEGIN
	BEGIN TRANSACTION
		BEGIN TRY
			DELETE FROM Spaces
			WHERE ID_Space = @ID_Space
			COMMIT TRANSACTION
		END TRY
	BEGIN CATCH
		ROLLBACK TRAN

		DECLARE @ErrorMessage NVARCHAR(4000);
		DECLARE @ErrorSeverity INT;
		DECLARE @ErrorState INT;

		SELECT
			@ErrorMessage = ERROR_MESSAGE()
		   ,@ErrorSeverity = ERROR_SEVERITY()
		   ,@ErrorState = ERROR_STATE();

		INSERT INTO [dbo].[Errors]
			VALUES (SUSER_SNAME(), 
			ERROR_NUMBER(), 
			ERROR_STATE(), 
			ERROR_SEVERITY(), 
			ERROR_LINE(), 
			ERROR_PROCEDURE(), 
			ERROR_MESSAGE(), 
			GETDATE());

		RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
	END CATCH
END

-------------------
-- update Space  --
-------------------
GO
CREATE OR ALTER PROCEDURE UpdatetSpace 
@ID_Space INT,
@Name NVARCHAR(150),
@Address NVARCHAR(500),
@Coordinates GEOGRAPHY,
@Capacity INT,
@AverageRating DECIMAL(2,1),
@Schedule XML

AS
BEGIN
	BEGIN TRY
		BEGIN TRAN
		UPDATE Spaces
		SET 
			[Name] = @Name,
			[Address] = @Address,
			Coordinates = @Coordinates,
			Capacity = @Capacity,
			AverageRating = @AverageRating,
			Schedule = @Schedule
		WHERE
			ID_Space = @ID_Space
		COMMIT TRAN
	END TRY

	BEGIN CATCH
		ROLLBACK TRAN

		DECLARE @ErrorMessage NVARCHAR(4000);
		DECLARE @ErrorSeverity INT;
		DECLARE @ErrorState INT;

		SELECT
			@ErrorMessage = ERROR_MESSAGE()
		   ,@ErrorSeverity = ERROR_SEVERITY()
		   ,@ErrorState = ERROR_STATE();

		INSERT INTO [dbo].[Errors]
			VALUES (SUSER_SNAME(), 
			ERROR_NUMBER(), 
			ERROR_STATE(), 
			ERROR_SEVERITY(), 
			ERROR_LINE(), 
			ERROR_PROCEDURE(), 
			ERROR_MESSAGE(), 
			GETDATE());

		RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
	END CATCH
END
GO

---------------------
-- Get All Spaces  --
---------------------
GO
CREATE OR ALTER PROCEDURE GetSpaces
AS
	SELECT * FROM Spaces
GO

----------------------
-- Get Space by ID  --
----------------------
GO
CREATE OR ALTER PROCEDURE GetSpaceByID
	@ID_Space INT
AS
	SELECT * FROM Spaces WHERE ID_Space = @ID_Space
GO

--------------------------------
-- SPACEsSCHEDULES Procedures --
--------------------------------

----------------------
-- Insert Schedule  --
---------------------
GO
CREATE OR ALTER PROCEDURE InsertSchedule 
@ID_Space INT,
@WeekDay INT,
@OpenHour TIME,
@CloseHour TIME

AS
BEGIN
	BEGIN TRY
		BEGIN TRAN
		INSERT INTO [dbo].[SpacesSchedules] 
		([ID_Space],
		[WeekDay],
		[OpenHour],
		[CloseHour])
			VALUES (@ID_Space, @WeekDay, @OpenHour, @CloseHour)
		COMMIT TRAN

	END TRY
	BEGIN CATCH
		ROLLBACK TRAN

		DECLARE @ErrorMessage NVARCHAR(4000);
		DECLARE @ErrorSeverity INT;
		DECLARE @ErrorState INT;

		SELECT
			@ErrorMessage = ERROR_MESSAGE()
		   ,@ErrorSeverity = ERROR_SEVERITY()
		   ,@ErrorState = ERROR_STATE();

		INSERT INTO [dbo].[Errors]
			VALUES (SUSER_SNAME(), 
			ERROR_NUMBER(), 
			ERROR_STATE(), 
			ERROR_SEVERITY(), 
			ERROR_LINE(), 
			ERROR_PROCEDURE(), 
			ERROR_MESSAGE(), 
			GETDATE());

		RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
	END CATCH
END
GO

----------------------
-- delete Schedule  --
----------------------
GO
CREATE OR ALTER PROCEDURE DeleteSchedule
	@ID_Space INT,
	@WeekDay INT
AS
BEGIN
	BEGIN TRANSACTION
		BEGIN TRY
			DELETE FROM SpacesSchedules
			WHERE ID_Space = @ID_Space AND [WeekDay]= @WeekDay
			COMMIT TRANSACTION
		END TRY
	BEGIN CATCH
		ROLLBACK TRAN

		DECLARE @ErrorMessage NVARCHAR(4000);
		DECLARE @ErrorSeverity INT;
		DECLARE @ErrorState INT;

		SELECT
			@ErrorMessage = ERROR_MESSAGE()
		   ,@ErrorSeverity = ERROR_SEVERITY()
		   ,@ErrorState = ERROR_STATE();

		INSERT INTO [dbo].[Errors]
			VALUES (SUSER_SNAME(), 
			ERROR_NUMBER(), 
			ERROR_STATE(), 
			ERROR_SEVERITY(), 
			ERROR_LINE(), 
			ERROR_PROCEDURE(), 
			ERROR_MESSAGE(), 
			GETDATE());

		RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
	END CATCH
END

----------------------
-- update Schedule  --
----------------------
GO
CREATE OR ALTER PROCEDURE UpdatetSchedule 
@ID_Space INT,
@WeekDay INT,
@OpenHour TIME,
@CloseHour TIME

AS
BEGIN
	BEGIN TRY
		BEGIN TRAN
		UPDATE SpacesSchedules
		SET 
			OpenHour = @OpenHour,
			CloseHour = @CloseHour
		WHERE
			ID_Space = @ID_Space AND [WeekDay] = @WeekDay
		COMMIT TRAN
	END TRY

	BEGIN CATCH
		ROLLBACK TRAN

		DECLARE @ErrorMessage NVARCHAR(4000);
		DECLARE @ErrorSeverity INT;
		DECLARE @ErrorState INT;

		SELECT
			@ErrorMessage = ERROR_MESSAGE()
		   ,@ErrorSeverity = ERROR_SEVERITY()
		   ,@ErrorState = ERROR_STATE();

		INSERT INTO [dbo].[Errors]
			VALUES (SUSER_SNAME(), 
			ERROR_NUMBER(), 
			ERROR_STATE(), 
			ERROR_SEVERITY(), 
			ERROR_LINE(), 
			ERROR_PROCEDURE(), 
			ERROR_MESSAGE(), 
			GETDATE());

		RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
	END CATCH
END
GO

------------------------
-- Get All Schedules  --
------------------------
GO
CREATE OR ALTER PROCEDURE GetSchedules
AS
	SELECT * FROM SpacesSchedules ORDER BY ID_Space, [WeekDay]
GO

--------------------------
-- Get Schedules by ID  --
--------------------------
GO
CREATE OR ALTER PROCEDURE GetSchedulesByID
	@ID_Space INT
AS
	SELECT * FROM SpacesSchedules WHERE ID_Space = @ID_Space ORDER BY ID_Space, [WeekDay]
GO


-------------------------------
-- SPACES RATINGS Procedures --
-------------------------------

-----------------------
-- Insert Sp Rating  --
----------------------
GO
CREATE OR ALTER PROCEDURE InsertSpaceRating
@Title NVARCHAR(50),
@Rating INT, -- 0 a 5
@Comment NVARCHAR(1000),
--@Date DATETIME, -----por default vai buscar a data
@ID_User INT,
@ID_Space INT

AS
BEGIN
	BEGIN TRY
		BEGIN TRAN
		INSERT INTO [dbo].[SpacesRatings] 
		([Title],
		[Rating],
		[Comment],
		[Date],
		[ID_User],
		[ID_Space])
			VALUES (@Title, @Rating, @Comment, GETDATE(),@ID_User, @ID_Space)
		COMMIT TRAN

	END TRY
	BEGIN CATCH
		ROLLBACK TRAN

		DECLARE @ErrorMessage NVARCHAR(4000);
		DECLARE @ErrorSeverity INT;
		DECLARE @ErrorState INT;

		SELECT
			@ErrorMessage = ERROR_MESSAGE()
		   ,@ErrorSeverity = ERROR_SEVERITY()
		   ,@ErrorState = ERROR_STATE();

		INSERT INTO [dbo].[Errors]
			VALUES (SUSER_SNAME(), 
			ERROR_NUMBER(), 
			ERROR_STATE(), 
			ERROR_SEVERITY(), 
			ERROR_LINE(), 
			ERROR_PROCEDURE(), 
			ERROR_MESSAGE(), 
			GETDATE());

		RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
	END CATCH
END
GO

----------------------
-- delete SpRating  --
----------------------
GO
CREATE OR ALTER PROCEDURE DeleteSpaceRating
	@ID_SpaceRating INT
AS
BEGIN
	BEGIN TRANSACTION
		BEGIN TRY
			DELETE FROM SpacesRatings
			WHERE ID_SpaceRating = @ID_SpaceRating
			COMMIT TRANSACTION
		END TRY
	BEGIN CATCH
		ROLLBACK TRAN

		DECLARE @ErrorMessage NVARCHAR(4000);
		DECLARE @ErrorSeverity INT;
		DECLARE @ErrorState INT;

		SELECT
			@ErrorMessage = ERROR_MESSAGE()
		   ,@ErrorSeverity = ERROR_SEVERITY()
		   ,@ErrorState = ERROR_STATE();

		INSERT INTO [dbo].[Errors]
			VALUES (SUSER_SNAME(), 
			ERROR_NUMBER(), 
			ERROR_STATE(), 
			ERROR_SEVERITY(), 
			ERROR_LINE(), 
			ERROR_PROCEDURE(), 
			ERROR_MESSAGE(), 
			GETDATE());

		RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
	END CATCH
END

-----------------------
-- update Sp Rating  --
-----------------------
GO
CREATE OR ALTER PROCEDURE UpdatetSpaceRating
@ID_SpaceRating INT,
@Title NVARCHAR(50),
@Rating DECIMAL(2,1),
@Comment NVARCHAR(1000),
--@Date DATETIME, --a preencher com GETDATE
@ID_User INT,
@ID_Space INT

AS
BEGIN
	BEGIN TRY
		BEGIN TRAN
		UPDATE SpacesRatings
		SET 
			Title = @Title,
			Rating = @Rating,
			Comment = @Comment,
			[Date] = GETDATE(),
			ID_User = @ID_User,
			ID_Space = @ID_Space
		WHERE
			ID_SpaceRating = @ID_SpaceRating
		COMMIT TRAN
	END TRY

	BEGIN CATCH
		ROLLBACK TRAN

		DECLARE @ErrorMessage NVARCHAR(4000);
		DECLARE @ErrorSeverity INT;
		DECLARE @ErrorState INT;

		SELECT
			@ErrorMessage = ERROR_MESSAGE()
		   ,@ErrorSeverity = ERROR_SEVERITY()
		   ,@ErrorState = ERROR_STATE();

		INSERT INTO [dbo].[Errors]
			VALUES (SUSER_SNAME(), 
			ERROR_NUMBER(), 
			ERROR_STATE(), 
			ERROR_SEVERITY(), 
			ERROR_LINE(), 
			ERROR_PROCEDURE(), 
			ERROR_MESSAGE(), 
			GETDATE());

		RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
	END CATCH
END
GO

-------------------------
-- Get All Sp Ratings  --
-------------------------
GO
CREATE OR ALTER PROCEDURE GetSpacesRatings
AS
	SELECT * FROM SpacesRatings
GO

------------------------------
-- Get Sp Ratings by Space  --
------------------------------
GO
CREATE OR ALTER PROCEDURE GetSpacesRatingsBySpace
AS
	SELECT * FROM SpacesRatings ORDER BY ID_Space
GO

---------------------------
-- Get Sp Ratings by ID  --
---------------------------
GO
CREATE OR ALTER PROCEDURE GetSpacesRatingsByID
	@ID_SpaceRating INT
AS
	SELECT * FROM SpacesRatings WHERE ID_SpaceRating = @ID_SpaceRating
GO

-------------------------------
-- EVENTS RATINGS Procedures --
-------------------------------

-----------------------
-- Insert EV Rating  --
-----------------------
GO
CREATE OR ALTER PROCEDURE InsertEventRating
@Title NVARCHAR(50),
@Rating INT, -- 0 a 5
@Comment NVARCHAR(1000),
--@Date DATETIME, -----por default vai buscar a data
@ID_User INT,
@ID_Event INT

AS
BEGIN
	BEGIN TRY
		BEGIN TRAN
		INSERT INTO [dbo].[EventsRatings] 
		([Title],
		[Rating],
		[Comment],
		[Date],
		[ID_User],
		[ID_Event])
			VALUES (@Title, @Rating, @Comment, GETDATE(),@ID_User, @ID_Event)
		COMMIT TRAN

	END TRY
	BEGIN CATCH
		ROLLBACK TRAN

		DECLARE @ErrorMessage NVARCHAR(4000);
		DECLARE @ErrorSeverity INT;
		DECLARE @ErrorState INT;

		SELECT
			@ErrorMessage = ERROR_MESSAGE()
		   ,@ErrorSeverity = ERROR_SEVERITY()
		   ,@ErrorState = ERROR_STATE();

		INSERT INTO [dbo].[Errors]
			VALUES (SUSER_SNAME(), 
			ERROR_NUMBER(), 
			ERROR_STATE(), 
			ERROR_SEVERITY(), 
			ERROR_LINE(), 
			ERROR_PROCEDURE(), 
			ERROR_MESSAGE(), 
			GETDATE());

		RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
	END CATCH
END
GO

----------------------
-- delete EvRating  --
----------------------
GO
CREATE OR ALTER PROCEDURE DeleteEventRating
	@ID_EventRating INT
AS
BEGIN
	BEGIN TRANSACTION
		BEGIN TRY
			DELETE FROM EventsRatings
			WHERE ID_EventRating = @ID_EventRating
			COMMIT TRANSACTION
		END TRY
	BEGIN CATCH
		ROLLBACK TRAN

		DECLARE @ErrorMessage NVARCHAR(4000);
		DECLARE @ErrorSeverity INT;
		DECLARE @ErrorState INT;

		SELECT
			@ErrorMessage = ERROR_MESSAGE()
		   ,@ErrorSeverity = ERROR_SEVERITY()
		   ,@ErrorState = ERROR_STATE();

		INSERT INTO [dbo].[Errors]
			VALUES (SUSER_SNAME(), 
			ERROR_NUMBER(), 
			ERROR_STATE(), 
			ERROR_SEVERITY(), 
			ERROR_LINE(), 
			ERROR_PROCEDURE(), 
			ERROR_MESSAGE(), 
			GETDATE());

		RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
	END CATCH
END

-----------------------
-- update Ev Rating  --
-----------------------
GO
CREATE OR ALTER PROCEDURE UpdatetEventRating
@ID_EventRating INT,
@Title NVARCHAR(50),
@Rating DECIMAL(2,1),
@Comment NVARCHAR(1000),
--@Date DATETIME, --a preencher com GETDATE
@ID_User INT,
@ID_Event INT

AS
BEGIN
	BEGIN TRY
		BEGIN TRAN
		UPDATE EventsRatings
		SET 
			Title = @Title,
			Rating = @Rating,
			Comment = @Comment,
			[Date] = GETDATE(),
			ID_User = @ID_User,
			ID_Event = @ID_Event
		WHERE
			ID_EventRating = @ID_EventRating
		COMMIT TRAN
	END TRY

	BEGIN CATCH
		ROLLBACK TRAN

		DECLARE @ErrorMessage NVARCHAR(4000);
		DECLARE @ErrorSeverity INT;
		DECLARE @ErrorState INT;

		SELECT
			@ErrorMessage = ERROR_MESSAGE()
		   ,@ErrorSeverity = ERROR_SEVERITY()
		   ,@ErrorState = ERROR_STATE();

		INSERT INTO [dbo].[Errors]
			VALUES (SUSER_SNAME(), 
			ERROR_NUMBER(), 
			ERROR_STATE(), 
			ERROR_SEVERITY(), 
			ERROR_LINE(), 
			ERROR_PROCEDURE(), 
			ERROR_MESSAGE(), 
			GETDATE());

		RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
	END CATCH
END
GO

-------------------------
-- Get All Ev Ratings  --
-------------------------
GO
CREATE OR ALTER PROCEDURE GetEventsRatings
AS
	SELECT * FROM EventsRatings
GO

------------------------------
-- Get Ev Ratings by Event  --
------------------------------
GO
CREATE OR ALTER PROCEDURE GetEventsRatingsByEvent
AS
	SELECT * FROM EventsRatings ORDER BY ID_Event
GO

---------------------------
-- Get Ev Ratings by ID  --
---------------------------
GO
CREATE OR ALTER PROCEDURE GetEventsRatingsByID
	@ID_EventRating INT
AS
	SELECT * FROM EventsRatings WHERE ID_EventRating = @ID_EventRating
GO


-------------------------
-- PICTURES Procedures --
-------------------------

---------------------
-- Insert Picture  --
---------------------
GO
CREATE OR ALTER PROCEDURE InsertPicture
@Name NVARCHAR(50),
@LinK VARCHAR(150),
--@UploadDate DATETIME, --a preencher com GETDATE()
@ID_User INT,
@ID_Promoter INT,
@ID_Space INT,
@ID_Event INT

AS
BEGIN
	BEGIN TRY
		BEGIN TRAN
		INSERT INTO [dbo].[Pictures] 
		([Name],
		[Link],
		[UploadDate],
		[ID_User],
		[ID_Promoter],
		[ID_Space],
		[ID_Event])
			VALUES (@Name, @Link, GETDATE(),@ID_User, @ID_Promoter, @ID_Space, @ID_Event)
		COMMIT TRAN

	END TRY
	BEGIN CATCH
		ROLLBACK TRAN

		DECLARE @ErrorMessage NVARCHAR(4000);
		DECLARE @ErrorSeverity INT;
		DECLARE @ErrorState INT;

		SELECT
			@ErrorMessage = ERROR_MESSAGE()
		   ,@ErrorSeverity = ERROR_SEVERITY()
		   ,@ErrorState = ERROR_STATE();

		INSERT INTO [dbo].[Errors]
			VALUES (SUSER_SNAME(), 
			ERROR_NUMBER(), 
			ERROR_STATE(), 
			ERROR_SEVERITY(), 
			ERROR_LINE(), 
			ERROR_PROCEDURE(), 
			ERROR_MESSAGE(), 
			GETDATE());

		RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
	END CATCH
END
GO

---------------------
-- delete Picture  --
---------------------
GO
CREATE OR ALTER PROCEDURE DeletePicture
	@ID_Picture INT
AS
BEGIN
	BEGIN TRANSACTION
		BEGIN TRY
			DELETE FROM Pictures
			WHERE ID_Picture = @ID_Picture
			COMMIT TRANSACTION
		END TRY
	BEGIN CATCH
		ROLLBACK TRAN

		DECLARE @ErrorMessage NVARCHAR(4000);
		DECLARE @ErrorSeverity INT;
		DECLARE @ErrorState INT;

		SELECT
			@ErrorMessage = ERROR_MESSAGE()
		   ,@ErrorSeverity = ERROR_SEVERITY()
		   ,@ErrorState = ERROR_STATE();

		INSERT INTO [dbo].[Errors]
			VALUES (SUSER_SNAME(), 
			ERROR_NUMBER(), 
			ERROR_STATE(), 
			ERROR_SEVERITY(), 
			ERROR_LINE(), 
			ERROR_PROCEDURE(), 
			ERROR_MESSAGE(), 
			GETDATE());

		RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
	END CATCH
END

---------------------
-- update Picture  --
---------------------
GO
CREATE OR ALTER PROCEDURE UpdatetPicture
@ID_Picture INT,
@Name NVARCHAR(50),
@Link VARCHAR(150),
@UploadDate DATETIME,
@ID_User INT,
@ID_Promoter INT,
@ID_Space INT,
@ID_Event INT

AS
BEGIN
	BEGIN TRY
		BEGIN TRAN
		UPDATE Pictures
		SET 
			[Name] = @Name,
			Link = @Link,
			UploadDate = @UploadDate,
			ID_User = @ID_User,
			ID_Promoter = @ID_Promoter,
			ID_Space = @ID_Space,
			ID_Event = @ID_Event
		WHERE
			ID_Picture = @ID_Picture
		COMMIT TRAN
	END TRY

	BEGIN CATCH
		ROLLBACK TRAN

		DECLARE @ErrorMessage NVARCHAR(4000);
		DECLARE @ErrorSeverity INT;
		DECLARE @ErrorState INT;

		SELECT
			@ErrorMessage = ERROR_MESSAGE()
		   ,@ErrorSeverity = ERROR_SEVERITY()
		   ,@ErrorState = ERROR_STATE();

		INSERT INTO [dbo].[Errors]
			VALUES (SUSER_SNAME(), 
			ERROR_NUMBER(), 
			ERROR_STATE(), 
			ERROR_SEVERITY(), 
			ERROR_LINE(), 
			ERROR_PROCEDURE(), 
			ERROR_MESSAGE(), 
			GETDATE());

		RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
	END CATCH
END
GO

-----------------------
-- Get All Pictures  --
-----------------------
GO
CREATE OR ALTER PROCEDURE GetPictures
AS
	SELECT * FROM Pictures
GO

----------------------------
-- Get Pictures by Event  --
----------------------------
GO
CREATE OR ALTER PROCEDURE GetPicturesByEvent
AS
	SELECT * FROM Pictures ORDER BY ID_Event
GO

----------------------------
-- Get Pictures by Space  --
----------------------------
GO
CREATE OR ALTER PROCEDURE GetPicturesBySpace
AS
	SELECT * FROM Pictures ORDER BY ID_Space
GO

-------------------------
-- Get Pictures by ID  --
-------------------------
GO
CREATE OR ALTER PROCEDURE GetPicturesByID
	@ID_Picture INT
AS
	SELECT * FROM Pictures WHERE ID_Picture = @ID_Picture
GO

-----------------------
-- EVENTS Procedures --
-----------------------

-------------------
-- Insert Event  --
-------------------
GO
CREATE OR ALTER PROCEDURE InsertEvent
@Name NVARCHAR(150),
@AverageRating DECIMAL(2,1),
@Date DATE, 
@Time TIME,
@Duration TIME,
@MinPrice Decimal(7,2),
@MaxPrice Decimal(7,2),
@MinAge INT,
@Acessibility BIT,
@Description NVARCHAR(2000),
@Observations NVARCHAR(1000),
@PromoterIsOwner BIT

AS
BEGIN
	BEGIN TRY
		BEGIN TRAN
		INSERT INTO [dbo].[Events] 
		([Name],
		[AverageRating],
		[Date],
		[Time],
		[Duration],
		[MinPrice],
		[MaxPrice],
		[MinAge],
		[Acessibility],
		[Description],
		[Observations],
		[PromoterIsOwner])
			VALUES (@Name, @AverageRating, @Date, @Time, @Duration, @MinPrice, @MaxPrice, @MinAge, 
			@Acessibility, @Description, @Observations, @PromoterIsOwner)
		COMMIT TRAN

	END TRY
	BEGIN CATCH
		ROLLBACK TRAN

		DECLARE @ErrorMessage NVARCHAR(4000);
		DECLARE @ErrorSeverity INT;
		DECLARE @ErrorState INT;

		SELECT
			@ErrorMessage = ERROR_MESSAGE()
		   ,@ErrorSeverity = ERROR_SEVERITY()
		   ,@ErrorState = ERROR_STATE();

		INSERT INTO [dbo].[Errors]
			VALUES (SUSER_SNAME(), 
			ERROR_NUMBER(), 
			ERROR_STATE(), 
			ERROR_SEVERITY(), 
			ERROR_LINE(), 
			ERROR_PROCEDURE(), 
			ERROR_MESSAGE(), 
			GETDATE());

		RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
	END CATCH
END
GO

-------------------
-- delete Event  --
-------------------
GO
CREATE OR ALTER PROCEDURE DeleteEvent
	@ID_Event INT
AS
BEGIN
	BEGIN TRANSACTION
		BEGIN TRY
			DELETE FROM [dbo].[Events]
			WHERE ID_Event = @ID_Event
			COMMIT TRANSACTION
		END TRY
	BEGIN CATCH
		ROLLBACK TRAN

		DECLARE @ErrorMessage NVARCHAR(4000);
		DECLARE @ErrorSeverity INT;
		DECLARE @ErrorState INT;

		SELECT
			@ErrorMessage = ERROR_MESSAGE()
		   ,@ErrorSeverity = ERROR_SEVERITY()
		   ,@ErrorState = ERROR_STATE();

		INSERT INTO [dbo].[Errors]
			VALUES (SUSER_SNAME(), 
			ERROR_NUMBER(), 
			ERROR_STATE(), 
			ERROR_SEVERITY(), 
			ERROR_LINE(), 
			ERROR_PROCEDURE(), 
			ERROR_MESSAGE(), 
			GETDATE());

		RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
	END CATCH
END

---------------------
-- update Event  --
---------------------
GO
CREATE OR ALTER PROCEDURE UpdatetEvent
@ID_Event INT,
@Name NVARCHAR(150),
@AverageRating DECIMAL(2,1),
@Date DATE, 
@Time TIME,
@Duration TIME,
@MinPrice Decimal(7,2),
@MaxPrice Decimal(7,2),
@MinAge INT,
@Acessibility BIT,
@Description NVARCHAR(2000),
@Observations NVARCHAR(1000),
@PromoterIsOwner BIT

AS
BEGIN
	BEGIN TRY
		BEGIN TRAN
		UPDATE [dbo].[Events]
		SET 
			[Name] = @Name,
			AverageRating = @AverageRating,
			[Date] = @Date,
			[Time] = @Time,
			Duration = @Duration,
			MinPrice = @MinPrice,
			MaxPrice = @MaxPrice,
			MinAge = @MinAge,
			Acessibility = @Acessibility,
			[Description] = @Description,
			Observations = @Observations,
			PromoterIsOwner = @PromoterIsOwner
		WHERE
			ID_Event = @ID_Event
		COMMIT TRAN
	END TRY

	BEGIN CATCH
		ROLLBACK TRAN

		DECLARE @ErrorMessage NVARCHAR(4000);
		DECLARE @ErrorSeverity INT;
		DECLARE @ErrorState INT;

		SELECT
			@ErrorMessage = ERROR_MESSAGE()
		   ,@ErrorSeverity = ERROR_SEVERITY()
		   ,@ErrorState = ERROR_STATE();

		INSERT INTO [dbo].[Errors]
			VALUES (SUSER_SNAME(), 
			ERROR_NUMBER(), 
			ERROR_STATE(), 
			ERROR_SEVERITY(), 
			ERROR_LINE(), 
			ERROR_PROCEDURE(), 
			ERROR_MESSAGE(), 
			GETDATE());

		RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
	END CATCH
END
GO

---------------------
-- Get All Events  --
---------------------
GO
CREATE OR ALTER PROCEDURE GetPictures
AS
	SELECT * FROM [Events]
GO

----------------------
-- Get Event by ID  --
----------------------
GO
CREATE OR ALTER PROCEDURE GetPicturesByEvent
@ID_Event INT
AS
	SELECT * FROM [Events] WHERE ID_Event = @ID_Event
GO