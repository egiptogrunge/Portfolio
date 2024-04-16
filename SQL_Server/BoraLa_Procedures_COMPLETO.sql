USE [BoraLa]

-------------------------
--EventTypes Procedures--
-------------------------

--------------------
--Insert EventType--
--------------------

GO
CREATE OR ALTER PROCEDURE InsertEventType
@ID_EventType INT, 
@Name NVARCHAR(20) 

AS
BEGIN
	BEGIN TRY

		BEGIN TRANSACTION
		INSERT INTO [dbo].[EventTypes] 
		([ID_EventType], [Name])
			VALUES (@ID_EventType, @Name)
		COMMIT TRANSACTION
	
	END TRY
	BEGIN CATCH
	ROLLBACK TRANSACTION 

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

--------------------
--Delete EventType--
--------------------

GO
CREATE OR ALTER PROCEDURE DeleteEventType
	@ID_EventType INT

AS
BEGIN
	BEGIN TRANSACTION

		BEGIN TRY
			DELETE FROM [dbo].[EventTypes]
			WHERE ID_EventType = @ID_EventType
			COMMIT TRANSACTION
		END TRY

	BEGIN CATCH
		ROLLBACK TRANSACTION

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

--------------------
--Update EventType--
--------------------

GO
CREATE OR ALTER PROCEDURE UpdateEventType
@ID_EventType INT,
@Name NVARCHAR(20)

AS
BEGIN
	BEGIN TRY
		BEGIN TRANSACTION
		UPDATE [dbo].[EventTypes]
		SET 
			[Name] = @Name WHERE ID_EventType = @ID_EventType
		COMMIT TRANSACTION
	END TRY

	BEGIN CATCH
		ROLLBACK TRANSACTION

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
--Get All Event Types--
-----------------------

GO
CREATE OR ALTER PROCEDURE GetEventTypes

AS
	SELECT * FROM [dbo].[EventTypes]
GO

------------------------
--Get Event Type by ID--
------------------------

GO
CREATE OR ALTER PROCEDURE GetEventTypesByID
	@ID_EventType INT

AS
	BEGIN
		SELECT * FROM [dbo].[EventTypes] WHERE ID_EventType = @ID_EventType
	END
GO

----------------------------
--EventSubTypes Procedures--
----------------------------

-----------------------
--Insert EventSubtype--
-----------------------

GO
CREATE OR ALTER PROCEDURE InsertEventSubType
@ID_EventSubType INT,
@ID_EventType INT, 
@Name NVARCHAR(50), 
@TargetAge INT NULL

AS
BEGIN
	BEGIN TRY

		BEGIN TRANSACTION
		INSERT INTO [dbo].[EventSubTypes] 
		([ID_EventSubType], [ID_EventType], [Name], [TargetAge])
			VALUES (@ID_EventSubType, @ID_EventType, @Name, @TargetAge)
		COMMIT TRANSACTION
	
	END TRY
	BEGIN CATCH
	ROLLBACK TRANSACTION 

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
--Delete EventSubType--
-----------------------

GO
CREATE OR ALTER PROCEDURE DeleteEventSubType
	@ID_EventSubType INT

AS
BEGIN
	BEGIN TRANSACTION

		BEGIN TRY
			DELETE FROM [dbo].[EventSubTypes]
			WHERE ID_EventSubType = @ID_EventSubType
			COMMIT TRANSACTION
		END TRY

	BEGIN CATCH
		ROLLBACK TRANSACTION

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
--Update EventSubType--
-----------------------

GO
CREATE OR ALTER PROCEDURE UpdateEventSubType
@ID_EventSubType INT,
@ID_EventType INT, 
@Name NVARCHAR(50), 
@TargetAge INT NULL

AS
BEGIN
	BEGIN TRY
		BEGIN TRANSACTION
		UPDATE [dbo].[EventSubTypes]
		SET 
			[Name] = @Name,
			[TargetAge] = @TargetAge
		WHERE 
			ID_EventSubType = @ID_EventSubType
		COMMIT TRANSACTION
	END TRY

	BEGIN CATCH
		ROLLBACK TRANSACTION

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

--------------------------
--Get All Event Subtypes--
--------------------------

GO
CREATE OR ALTER PROCEDURE GetEventSubTypes

AS
	SELECT * FROM [dbo].[EventSubTypes]
GO

---------------------------
--Get Event Subtype by ID--
---------------------------

GO
CREATE OR ALTER PROCEDURE GetEventTypesByID
	@ID_EventSubType INT

AS
	BEGIN
		SELECT * FROM [dbo].[EventSubTypes] WHERE ID_EventSubType = @ID_EventSubType
	END
GO

---------------------------------
--PromoterCategories Procedures--
---------------------------------

---------------------------
--Insert PromoterCategory--
---------------------------

GO
CREATE OR ALTER PROCEDURE InsertPromoterCategory
@ID_PromoterCategory INT,
@Name NVARCHAR(50), 
@ServiceDescritpion NVARCHAR(1000),
@Fee MONEY NULL

AS
BEGIN
	BEGIN TRY

		BEGIN TRANSACTION
		INSERT INTO [dbo].[PromoterCategories] 
		([ID_PromoterCategory], [Name], [ServiceDescription], [Fee])
			VALUES (@ID_PromoterCategory, @Name, @ServiceDescritpion, @Fee)
		COMMIT TRANSACTION
	
	END TRY
	BEGIN CATCH
	ROLLBACK TRANSACTION 

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

---------------------------
--Delete PromoterCategory--
---------------------------

GO
CREATE OR ALTER PROCEDURE DeletePromoterCategory
	@ID_PromoterCategory INT

AS
BEGIN
	BEGIN TRANSACTION

		BEGIN TRY
			DELETE FROM [dbo].[PromoterCategories]
			WHERE ID_PromoterCategory = @ID_PromoterCategory
			COMMIT TRANSACTION
		END TRY

	BEGIN CATCH
		ROLLBACK TRANSACTION

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

---------------------------
--Update PromoterCategory--
---------------------------

GO
CREATE OR ALTER PROCEDURE UpdatePromoterCategory
@ID_PromoterCategory INT,
@Name NVARCHAR(50), 
@ServiceDescritpion NVARCHAR(100),
@Fee MONEY NULL

AS
BEGIN
	BEGIN TRY
		BEGIN TRANSACTION
		UPDATE [dbo].[PromoterCategories]
		SET 
			[Name] = @Name,
			[ServiceDescription] = @ServiceDescritpion,
			[Fee] = @Fee
		WHERE 
			ID_PromoterCategory = @ID_PromoterCategory
		COMMIT TRANSACTION
	END TRY

	BEGIN CATCH
		ROLLBACK TRANSACTION

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

-------------------------------
--Get All Promoter Categories--
-------------------------------

GO
CREATE OR ALTER PROCEDURE GetPromoterCategories

AS
	SELECT * FROM [dbo].[PromoterCategories]
GO

-------------------------------
--Get Promoter Category by ID--
-------------------------------

GO
CREATE OR ALTER PROCEDURE GetPromoterCategoriesByID
	@ID_PromoterCategory INT

AS
	BEGIN
		SELECT * FROM [dbo].[PromoterCategories] WHERE ID_PromoterCategory = @ID_PromoterCategory
	END
GO

------------------------
--Promoters Procedures--
------------------------

-------------------
--Insert Promoter--
-------------------

GO
CREATE OR ALTER PROCEDURE InsertPromoter
@ID_Promoter INT,
@Name NVARCHAR(25), 
@Description NVARCHAR(1000),
@ID_Credential INT,
@ID_PromoterCategory INT

AS
BEGIN
	BEGIN TRY

		BEGIN TRANSACTION
		INSERT INTO [dbo].[Promoters] 
		([ID_Promoter], [Name], [Description], [ID_Credential], [ID_PromoterCategory])
			VALUES (@ID_PromoterCategory, @Name, @Description, @ID_Credential, @ID_PromoterCategory)
		COMMIT TRANSACTION
	
	END TRY
	BEGIN CATCH
	ROLLBACK TRANSACTION 

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
--Delete Promoter--
-------------------

GO
CREATE OR ALTER PROCEDURE DeletePromoter
	@ID_Promoter INT

AS
BEGIN
	BEGIN TRANSACTION

		BEGIN TRY
			DELETE FROM [dbo].[Promoters]
			WHERE ID_Promoter = @ID_Promoter
			COMMIT TRANSACTION
		END TRY

	BEGIN CATCH
		ROLLBACK TRANSACTION

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
--Update Promoter--
-------------------

GO
CREATE OR ALTER PROCEDURE UpdatePromoter
@ID_Promoter INT,
@Name NVARCHAR(25), 
@Description NVARCHAR(1000),
@ID_Credential INT,
@ID_PromoterCategory INT

AS
BEGIN
	BEGIN TRY
		BEGIN TRANSACTION
		UPDATE [dbo].[Promoters]
		SET 
			[Name] = @Name,
			[Description] = @Description,
			[ID_Credential] = @ID_Credential,
			[ID_PromoterCategory] = @ID_PromoterCategory
		WHERE 
			ID_Promoter = @ID_Promoter
		COMMIT TRANSACTION
	END TRY

	BEGIN CATCH
		ROLLBACK TRANSACTION

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
--Get All Promoters--
---------------------

GO
CREATE OR ALTER PROCEDURE GetPromoters

AS
	SELECT * FROM [dbo].[Promoters]
GO

-------------------------------
--Get Promoter by ID--
-------------------------------

GO
CREATE OR ALTER PROCEDURE GetPromoterByID
	@ID_Promoter INT

AS
	BEGIN
		SELECT * FROM [dbo].[Promoters] WHERE ID_Promoter = @ID_Promoter
	END
GO

--------------------------
--Credentials Procedures--
--------------------------

-------------------
--Insert Credential--
-------------------

GO
CREATE OR ALTER PROCEDURE InsertCredential
@ID_Credential INT,
@Email NVARCHAR(25), 
@Password NVARCHAR(1000),
@Role INT

AS
BEGIN
	BEGIN TRY

		BEGIN TRANSACTION
		INSERT INTO [dbo].[Credentials] 
		([ID_Credential], [Email], [Password], [Role])
			VALUES (@ID_Credential, @Email, @Password, @Role)
		COMMIT TRANSACTION
	
	END TRY
	BEGIN CATCH
	ROLLBACK TRANSACTION 

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
--Delete Credential--
---------------------

GO
CREATE OR ALTER PROCEDURE DeleteCredential
	@ID_Credential INT

AS
BEGIN
	BEGIN TRANSACTION

		BEGIN TRY
			DELETE FROM [dbo].[Credentials]
			WHERE ID_Credential = @ID_Credential
			COMMIT TRANSACTION
		END TRY

	BEGIN CATCH
		ROLLBACK TRANSACTION

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
--Update Credential--
---------------------

GO
CREATE OR ALTER PROCEDURE UpdateCredential
@ID_Credential INT,
@Email NVARCHAR(25), 
@Password NVARCHAR(1000),
@Role INT

AS
BEGIN
	BEGIN TRY
		BEGIN TRANSACTION
		UPDATE [dbo].[Credentials]
		SET 
			[Email] = @Email,
			[Password] = @Password,
			[Role] = @Role
		WHERE 
			ID_Credential = @ID_Credential
		COMMIT TRANSACTION
	END TRY

	BEGIN CATCH
		ROLLBACK TRANSACTION

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
--Get All Credentials--
-----------------------

GO
CREATE OR ALTER PROCEDURE GetCredentials

AS
	SELECT * FROM [dbo].[Credentials]
GO

-------------------------------
--Get Credential by ID--
-------------------------------

GO
CREATE OR ALTER PROCEDURE GetCredentialByID
	@ID_Credential INT

AS
	BEGIN
		SELECT * FROM [dbo].[Credentials] WHERE ID_Credential = @ID_Credential
	END
GO

-- _________________________________________________________________________________________________________________________
-- Table ERRORS
-- _________________________________________________________________________________________________________________________
---------
-- get --
---------
GO
CREATE OR ALTER PROCEDURE Get_table_Errors
AS
BEGIN
	SELECT
		ERROR_NUMBER() AS ErrorNumber,
		ERROR_SEVERITY() AS ErrorSeverity,
		ERROR_STATE() AS ErrorState,
		ERROR_PROCEDURE() AS ErrorProcedure,
		ERROR_LINE() AS ErrorLine,
		ERROR_MESSAGE() AS ErrorMessage
END

-- _________________________________________________________________________________________________________________________
-- Table Users
-- _________________________________________________________________________________________________________________________
------------
-- update --
------------
GO
CREATE OR ALTER PROCEDURE Update_table_Users -- PARA CRIAR DE RAIZ OU ALTERAR
	
	@ID_User INT,
	@Name NVARCHAR(100),
	@Location GEOGRAPHY,
	@BirthDate DATE,
	@ProfilePicture NVARCHAR(50)
AS
BEGIN
	BEGIN TRANSACTION
		BEGIN TRY
			UPDATE Users 
			SET Name = @Name,
				Location = @Location,
				BirthDate = @BirthDate,
				ProfilePicture = @ProfilePicture
			WHERE ID_User = @ID_User
			COMMIT TRANSACTION
		END TRY

	BEGIN CATCH
		ROLLBACK TRANSACTION
		DECLARE @ErrorMessage NVARCHAR(4000);
		DECLARE @ErrorSeverity INT;
		DECLARE @ErrorState INT;

		SELECT
			@ErrorMessage = ERROR_MESSAGE(),
			@ErrorSeverity = ERROR_SEVERITY(),
			@ErrorState = ERROR_STATE();

		INSERT INTO [BoraLa].[dbo].[Errors]
			VALUES (SUSER_SNAME(), ERROR_NUMBER(), ERROR_STATE(), ERROR_SEVERITY(), ERROR_LINE(), ERROR_PROCEDURE(), ERROR_MESSAGE(), GETDATE());
			
		RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
	END CATCH
END
------------
-- insert --
------------
GO
CREATE OR ALTER PROCEDURE Insert_table_Users -- PARA CRIAR DE RAIZ OU ALTERAR

	@ID_User INT,
	@Name NVARCHAR(100),
	@Location GEOGRAPHY,
	@BirthDate DATE,
	@ProfilePicture NVARCHAR(50)
AS
BEGIN
	BEGIN TRANSACTION
		BEGIN TRY
			INSERT INTO Users(ID_User, Name, Location, BirthDate, ProfilePicture)
			VALUES (@ID_User, @Name, @Location, @BirthDate, @ProfilePicture)
			COMMIT TRANSACTION
		END TRY

	BEGIN CATCH
		ROLLBACK TRANSACTION		
		DECLARE @ErrorMessage NVARCHAR(4000);
		DECLARE @ErrorSeverity INT;
		DECLARE @ErrorState INT;

		SELECT
			@ErrorMessage = ERROR_MESSAGE(),
			@ErrorSeverity = ERROR_SEVERITY(),
			@ErrorState = ERROR_STATE();

		INSERT INTO [BoraLa].[dbo].[Errors]
			VALUES (SUSER_SNAME(), ERROR_NUMBER(), ERROR_STATE(), ERROR_SEVERITY(), ERROR_LINE(), ERROR_PROCEDURE(), ERROR_MESSAGE(), GETDATE());
			
		RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
	END CATCH
END
------------
-- delete --
------------
GO
CREATE OR ALTER PROCEDURE Delete_table_Users -- PARA CRIAR DE RAIZ OU ALTERAR

	@ID_User INT
AS
BEGIN
	BEGIN TRANSACTION
		BEGIN TRY
			DELETE FROM Users
			WHERE ID_User = @ID_User
			COMMIT TRANSACTION
		END TRY

	BEGIN CATCH
		ROLLBACK TRANSACTION
		DECLARE @ErrorMessage NVARCHAR(4000);
		DECLARE @ErrorSeverity INT;
		DECLARE @ErrorState INT;

		SELECT
			@ErrorMessage = ERROR_MESSAGE(),
			@ErrorSeverity = ERROR_SEVERITY(),
			@ErrorState = ERROR_STATE();

		INSERT INTO [BoraLa].[dbo].[Errors]
			VALUES (SUSER_SNAME(), ERROR_NUMBER(), ERROR_STATE(), ERROR_SEVERITY(), ERROR_LINE(), ERROR_PROCEDURE(), ERROR_MESSAGE(), GETDATE());
			
		RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);	END CATCH
END
-------------
---- get ----
-------------
GO
CREATE OR ALTER PROCEDURE	Get_table_Users -- PARA CRIAR DE RAIZ OU ALTERAR
AS SELECT * FROM Users
-----------------
---- get  by ----
-----------------
GO
CREATE OR ALTER PROCEDURE	GetByID_table_Users -- PARA CRIAR DE RAIZ OU ALTERAR
	@ID_User INT
AS SELECT * FROM Users WHERE ID_User = @ID_User

-- _________________________________________________________________________________________________________________________
-- Table Notifications
-- _________________________________________________________________________________________________________________________
------------
-- update --
------------
GO
CREATE OR ALTER PROCEDURE Update_table_Notifications -- PARA CRIAR DE RAIZ OU ALTERAR - - - - - - - - FALAR COM A EQUIPA
	
	@ID_Notification INT,
	@ID_User INT,
	@ID_Event INT,
	@Description NVARCHAR(100)
AS
BEGIN
	BEGIN TRANSACTION
		BEGIN TRY
			UPDATE Notifications 
			SET ID_User = @ID_User,
				ID_Event = @ID_Event,
				Description = @Description
			WHERE ID_Notification = @ID_Notification
			COMMIT TRANSACTION
		END TRY

	BEGIN CATCH
		ROLLBACK TRANSACTION
		DECLARE @ErrorMessage NVARCHAR(4000);
		DECLARE @ErrorSeverity INT;
		DECLARE @ErrorState INT;

		SELECT
			@ErrorMessage = ERROR_MESSAGE(),
			@ErrorSeverity = ERROR_SEVERITY(),
			@ErrorState = ERROR_STATE();

		INSERT INTO [BoraLa].[dbo].[Errors]
			VALUES (SUSER_SNAME(), ERROR_NUMBER(), ERROR_STATE(), ERROR_SEVERITY(), ERROR_LINE(), ERROR_PROCEDURE(), ERROR_MESSAGE(), GETDATE());
			
		RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
	END CATCH
END
------------
-- insert --
------------
GO
CREATE OR ALTER PROCEDURE Insert_table_Notifications -- PARA CRIAR DE RAIZ OU ALTERAR

	@ID_Notification INT,
	@ID_User INT,
	@ID_Event INT,
	@Description NVARCHAR(100)
AS
BEGIN
	BEGIN TRANSACTION
		BEGIN TRY
			INSERT INTO Notifications(ID_Notification, ID_User, ID_Event, Description)
			VALUES (@ID_Notification, @ID_User, @ID_Event, @Description)
			COMMIT TRANSACTION
		END TRY

	BEGIN CATCH
		ROLLBACK TRANSACTION		
		DECLARE @ErrorMessage NVARCHAR(4000);
		DECLARE @ErrorSeverity INT;
		DECLARE @ErrorState INT;

		SELECT
			@ErrorMessage = ERROR_MESSAGE(),
			@ErrorSeverity = ERROR_SEVERITY(),
			@ErrorState = ERROR_STATE();

		INSERT INTO [BoraLa].[dbo].[Errors]
			VALUES (SUSER_SNAME(), ERROR_NUMBER(), ERROR_STATE(), ERROR_SEVERITY(), ERROR_LINE(), ERROR_PROCEDURE(), ERROR_MESSAGE(), GETDATE());
			
		RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
	END CATCH
END
------------
-- delete --
------------
GO
CREATE OR ALTER PROCEDURE Delete_table_Notifications -- PARA CRIAR DE RAIZ OU ALTERAR

	@ID_Notification INT
AS
BEGIN
	BEGIN TRANSACTION
		BEGIN TRY
			DELETE FROM Notifications
			WHERE ID_Notification = @ID_Notification
			COMMIT TRANSACTION
		END TRY

	BEGIN CATCH
		ROLLBACK TRANSACTION
		DECLARE @ErrorMessage NVARCHAR(4000);
		DECLARE @ErrorSeverity INT;
		DECLARE @ErrorState INT;

		SELECT
			@ErrorMessage = ERROR_MESSAGE(),
			@ErrorSeverity = ERROR_SEVERITY(),
			@ErrorState = ERROR_STATE();

		INSERT INTO [BoraLa].[dbo].[Errors]
			VALUES (SUSER_SNAME(), ERROR_NUMBER(), ERROR_STATE(), ERROR_SEVERITY(), ERROR_LINE(), ERROR_PROCEDURE(), ERROR_MESSAGE(), GETDATE());
			
		RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
	END CATCH
END
-------------
---- get ----
-------------
GO
CREATE OR ALTER PROCEDURE	Get_table_Notifications -- PARA CRIAR DE RAIZ OU ALTERAR
AS SELECT * FROM Notifications

-----------------
---- get  by ----
-----------------
GO
CREATE OR ALTER PROCEDURE	GetByID_table_Notifications -- PARA CRIAR DE RAIZ OU ALTERAR
	@ID_Notification INT
AS SELECT * FROM Notifications WHERE ID_Notification = @ID_Notification

-- _________________________________________________________________________________________________________________________
-- Table ReportsTypes
-- _________________________________________________________________________________________________________________________
------------
-- update --
------------
GO
CREATE OR ALTER PROCEDURE Update_table_ReportsTypes -- PARA CRIAR DE RAIZ OU ALTERAR
	
	@ID_ReportType INT,
	@Type NVARCHAR(50),
	@Description NVARCHAR(100)
AS
BEGIN
	BEGIN TRANSACTION
		BEGIN TRY
			UPDATE ReportsTypes 
			SET Type = @Type,
				Description = @Description
			WHERE ID_ReportType = @ID_ReportType
			COMMIT TRANSACTION
		END TRY

	BEGIN CATCH
		ROLLBACK TRANSACTION
		DECLARE @ErrorMessage NVARCHAR(4000);
		DECLARE @ErrorSeverity INT;
		DECLARE @ErrorState INT;

		SELECT
			@ErrorMessage = ERROR_MESSAGE(),
			@ErrorSeverity = ERROR_SEVERITY(),
			@ErrorState = ERROR_STATE();

		INSERT INTO [BoraLa].[dbo].[Errors]
			VALUES (SUSER_SNAME(), ERROR_NUMBER(), ERROR_STATE(), ERROR_SEVERITY(), ERROR_LINE(), ERROR_PROCEDURE(), ERROR_MESSAGE(), GETDATE());
			
		RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
	END CATCH
END
------------
-- insert --
------------
GO
CREATE OR ALTER PROCEDURE Insert_table_ReportsTypes -- PARA CRIAR DE RAIZ OU ALTERAR

	@ID_ReportType INT,
	@Type NVARCHAR(50),
	@Description NVARCHAR(100)
AS
BEGIN
	BEGIN TRANSACTION
		BEGIN TRY
			INSERT INTO ReportsTypes(ID_ReportType, Type, Description)
			VALUES (@ID_ReportType, @Type, @Description)
			COMMIT TRANSACTION
		END TRY

	BEGIN CATCH
		ROLLBACK TRANSACTION
		DECLARE @ErrorMessage NVARCHAR(4000);
		DECLARE @ErrorSeverity INT;
		DECLARE @ErrorState INT;

		SELECT
			@ErrorMessage = ERROR_MESSAGE(),
			@ErrorSeverity = ERROR_SEVERITY(),
			@ErrorState = ERROR_STATE();

		INSERT INTO [BoraLa].[dbo].[Errors]
			VALUES (SUSER_SNAME(), ERROR_NUMBER(), ERROR_STATE(), ERROR_SEVERITY(), ERROR_LINE(), ERROR_PROCEDURE(), ERROR_MESSAGE(), GETDATE());
			
		RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
	END CATCH
END
------------
-- delete --
------------
GO
CREATE OR ALTER PROCEDURE Delete_table_ReportsTypes -- PARA CRIAR DE RAIZ OU ALTERAR

	@ID_ReportType INT
AS
BEGIN
	BEGIN TRANSACTION
		BEGIN TRY
			DELETE FROM ReportsTypes
			WHERE ID_ReportType = @ID_ReportType
			COMMIT TRANSACTION
		END TRY

	BEGIN CATCH
		ROLLBACK TRANSACTION
		DECLARE @ErrorMessage NVARCHAR(4000);
		DECLARE @ErrorSeverity INT;
		DECLARE @ErrorState INT;

		SELECT
			@ErrorMessage = ERROR_MESSAGE(),
			@ErrorSeverity = ERROR_SEVERITY(),
			@ErrorState = ERROR_STATE();

		INSERT INTO [BoraLa].[dbo].[Errors]
			VALUES (SUSER_SNAME(), ERROR_NUMBER(), ERROR_STATE(), ERROR_SEVERITY(), ERROR_LINE(), ERROR_PROCEDURE(), ERROR_MESSAGE(), GETDATE());
			
		RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
	END CATCH
END
-------------
---- get ----
-------------
GO
CREATE OR ALTER PROCEDURE	Get_table_ReportsTypes -- PARA CRIAR DE RAIZ OU ALTERAR
AS SELECT * FROM ReportsTypes
-----------------
---- get  by ----
-----------------
GO
CREATE OR ALTER PROCEDURE	GetByID_table_ReportsTypes -- PARA CRIAR DE RAIZ OU ALTERAR
	@ID_ReportType INT
AS SELECT * FROM ReportsTypes WHERE ID_ReportType = @ID_ReportType
-- _________________________________________________________________________________________________________________________
-- Table SpacesReports
-- _________________________________________________________________________________________________________________________
------------
-- update --
------------
GO
CREATE OR ALTER PROCEDURE Update_table_SpacesReports -- PARA CRIAR DE RAIZ OU ALTERAR
	
	@ID_SpaceReport INT,
	@ID_User INT,
	@ID_Space INT,
	@ID_ReportType INT,
	@Date DATE,
	@Comment NVARCHAR(100)
AS
BEGIN
	BEGIN TRANSACTION
		BEGIN TRY
			UPDATE SpacesReports 
			SET ID_User = @ID_User,
				ID_Space = @ID_Space,
				ID_ReportType = @ID_ReportType,
				Date = @Date,
				Comment = @Comment
			WHERE ID_SpaceReport = @ID_SpaceReport
			COMMIT TRANSACTION
		END TRY

	BEGIN CATCH
		ROLLBACK TRANSACTION
		DECLARE @ErrorMessage NVARCHAR(4000);
		DECLARE @ErrorSeverity INT;
		DECLARE @ErrorState INT;

		SELECT
			@ErrorMessage = ERROR_MESSAGE(),
			@ErrorSeverity = ERROR_SEVERITY(),
			@ErrorState = ERROR_STATE();

		INSERT INTO [BoraLa].[dbo].[Errors]
			VALUES (SUSER_SNAME(), ERROR_NUMBER(), ERROR_STATE(), ERROR_SEVERITY(), ERROR_LINE(), ERROR_PROCEDURE(), ERROR_MESSAGE(), GETDATE());
			
		RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
	END CATCH
END
------------
-- insert --
------------
GO
CREATE OR ALTER PROCEDURE Insert_table_SpacesReports -- PARA CRIAR DE RAIZ OU ALTERAR

	@ID_SpaceReport INT,
	@ID_User INT,
	@ID_Space INT,
	@ID_ReportType INT,
	@Date DATE,
	@Comment NVARCHAR(100)
AS
BEGIN
	BEGIN TRANSACTION
		BEGIN TRY
			INSERT INTO SpacesReports(ID_SpaceReport, ID_User, ID_Space, ID_ReportType, Date, Comment)
			VALUES (@ID_SpaceReport, @ID_User, @ID_Space, @ID_ReportType, @Date, @Comment)
			COMMIT TRANSACTION
		END TRY

	BEGIN CATCH
		ROLLBACK TRANSACTION
		DECLARE @ErrorMessage NVARCHAR(4000);
		DECLARE @ErrorSeverity INT;
		DECLARE @ErrorState INT;

		SELECT
			@ErrorMessage = ERROR_MESSAGE(),
			@ErrorSeverity = ERROR_SEVERITY(),
			@ErrorState = ERROR_STATE();

		INSERT INTO [BoraLa].[dbo].[Errors]
			VALUES (SUSER_SNAME(), ERROR_NUMBER(), ERROR_STATE(), ERROR_SEVERITY(), ERROR_LINE(), ERROR_PROCEDURE(), ERROR_MESSAGE(), GETDATE());
			
		RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
	END CATCH
END
------------
-- delete --
------------
GO
CREATE OR ALTER PROCEDURE Delete_table_SpacesReports -- PARA CRIAR DE RAIZ OU ALTERAR

	@ID_SpaceReport INT
AS
BEGIN
	BEGIN TRANSACTION
		BEGIN TRY
			DELETE FROM SpacesReports
			WHERE ID_SpaceReport = @ID_SpaceReport
			COMMIT TRANSACTION
		END TRY

	BEGIN CATCH
		ROLLBACK TRANSACTION
		DECLARE @ErrorMessage NVARCHAR(4000);
		DECLARE @ErrorSeverity INT;
		DECLARE @ErrorState INT;

		SELECT
			@ErrorMessage = ERROR_MESSAGE(),
			@ErrorSeverity = ERROR_SEVERITY(),
			@ErrorState = ERROR_STATE();

		INSERT INTO [BoraLa].[dbo].[Errors]
			VALUES (SUSER_SNAME(), ERROR_NUMBER(), ERROR_STATE(), ERROR_SEVERITY(), ERROR_LINE(), ERROR_PROCEDURE(), ERROR_MESSAGE(), GETDATE());
			
		RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
	END CATCH
END
-------------
---- get ----
-------------
GO
CREATE OR ALTER PROCEDURE	Get_table_SpacesReports -- PARA CRIAR DE RAIZ OU ALTERAR
AS SELECT * FROM SpacesReports
-----------------
---- get  by ----
-----------------
GO
CREATE OR ALTER PROCEDURE	GetByID_table_SpacesReports -- PARA CRIAR DE RAIZ OU ALTERAR
	@ID_SpaceReport INT
AS SELECT * FROM SpacesReports WHERE ID_SpaceReport = @ID_SpaceReport
-- _________________________________________________________________________________________________________________________
-- Table EventsReports
-- _________________________________________________________________________________________________________________________
------------
-- update --
------------
GO
CREATE OR ALTER PROCEDURE Update_table_EventsReports -- PARA CRIAR DE RAIZ OU ALTERAR
	
	@ID_EventReport INT,
	@ID_User INT,
	@ID_Event INT,
	@ID_ReportType INT,
	@Date DATE,
	@Comment NVARCHAR(100)
AS
BEGIN
	BEGIN TRANSACTION
		BEGIN TRY
			UPDATE EventsReports 
			SET ID_User = @ID_User,
				ID_Event = @ID_Event,
				ID_ReportType = @ID_ReportType,
				Date = @Date,
				Comment =@Comment
			WHERE ID_EventReport = @ID_EventReport
			COMMIT TRANSACTION
		END TRY

	BEGIN CATCH
		ROLLBACK TRANSACTION
		DECLARE @ErrorMessage NVARCHAR(4000);
		DECLARE @ErrorSeverity INT;
		DECLARE @ErrorState INT;

		SELECT
			@ErrorMessage = ERROR_MESSAGE(),
			@ErrorSeverity = ERROR_SEVERITY(),
			@ErrorState = ERROR_STATE();

		INSERT INTO [BoraLa].[dbo].[Errors]
			VALUES (SUSER_SNAME(), ERROR_NUMBER(), ERROR_STATE(), ERROR_SEVERITY(), ERROR_LINE(), ERROR_PROCEDURE(), ERROR_MESSAGE(), GETDATE());
			
		RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
	END CATCH
END
------------
-- insert --
------------
GO
CREATE OR ALTER PROCEDURE Insert_table_EventsReports -- PARA CRIAR DE RAIZ OU ALTERAR

	@ID_EventReport INT,
	@ID_User INT,
	@ID_Event INT,
	@ID_ReportType INT,
	@Date DATE,
	@Comment NVARCHAR(100)
AS
BEGIN
	BEGIN TRANSACTION
		BEGIN TRY
			INSERT INTO EventsReports(ID_EventReport, ID_User, ID_Event, ID_ReportType, Date, Comment)
			VALUES (@ID_EventReport, @ID_User, @ID_Event, @ID_ReportType, @Date, @Comment)
			COMMIT TRANSACTION
		END TRY

	BEGIN CATCH
		ROLLBACK TRANSACTION
		DECLARE @ErrorMessage NVARCHAR(4000);
		DECLARE @ErrorSeverity INT;
		DECLARE @ErrorState INT;

		SELECT
			@ErrorMessage = ERROR_MESSAGE(),
			@ErrorSeverity = ERROR_SEVERITY(),
			@ErrorState = ERROR_STATE();

		INSERT INTO [BoraLa].[dbo].[Errors]
			VALUES (SUSER_SNAME(), ERROR_NUMBER(), ERROR_STATE(), ERROR_SEVERITY(), ERROR_LINE(), ERROR_PROCEDURE(), ERROR_MESSAGE(), GETDATE());
			
		RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
	END CATCH
END
------------
-- delete --
------------
GO
CREATE OR ALTER PROCEDURE Delete_table_EventsReports -- PARA CRIAR DE RAIZ OU ALTERAR

	@ID_EventReport INT
AS
BEGIN
	BEGIN TRANSACTION
		BEGIN TRY
			DELETE FROM EventsReports
			WHERE ID_EventReport = @ID_EventReport
			COMMIT TRANSACTION
		END TRY

	BEGIN CATCH
		ROLLBACK TRANSACTION
		DECLARE @ErrorMessage NVARCHAR(4000);
		DECLARE @ErrorSeverity INT;
		DECLARE @ErrorState INT;

		SELECT
			@ErrorMessage = ERROR_MESSAGE(),
			@ErrorSeverity = ERROR_SEVERITY(),
			@ErrorState = ERROR_STATE();

		INSERT INTO [BoraLa].[dbo].[Errors]
			VALUES (SUSER_SNAME(), ERROR_NUMBER(), ERROR_STATE(), ERROR_SEVERITY(), ERROR_LINE(), ERROR_PROCEDURE(), ERROR_MESSAGE(), GETDATE());
			
		RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
	END CATCH
END
-------------
---- get ----
-------------
GO
CREATE OR ALTER PROCEDURE	Get_table_EventsReports -- PARA CRIAR DE RAIZ OU ALTERAR
AS SELECT * FROM EventsReports
-----------------
---- get  by ----
-----------------
GO
CREATE OR ALTER PROCEDURE	GetByID_table_EventsReports -- PARA CRIAR DE RAIZ OU ALTERAR
	@ID_EventReport INT
AS SELECT * FROM EventsReports WHERE ID_EventReport = @ID_EventReport
-- _________________________________________________________________________________________________________________________
-- Table FavoritesEventTypes
-- _________________________________________________________________________________________________________________________
------------
-- update --
------------
GO
CREATE OR ALTER PROCEDURE Update_table_FavoritesEventTypes -- PARA CRIAR DE RAIZ OU ALTERAR
	
	@ID_FavoritesEvents INT,
	@ID_User INT,
	@ID_EventSubType INT
AS
BEGIN
	BEGIN TRANSACTION
		BEGIN TRY
			UPDATE FavoritesEventTypes 
			SET ID_User = @ID_User,
				ID_EventSubType = @ID_EventSubType
			WHERE ID_FavoritesEvents = @ID_FavoritesEvents
			COMMIT TRANSACTION
		END TRY

	BEGIN CATCH
		ROLLBACK TRANSACTION
		DECLARE @ErrorMessage NVARCHAR(4000);
		DECLARE @ErrorSeverity INT;
		DECLARE @ErrorState INT;

		SELECT
			@ErrorMessage = ERROR_MESSAGE(),
			@ErrorSeverity = ERROR_SEVERITY(),
			@ErrorState = ERROR_STATE();

		INSERT INTO [BoraLa].[dbo].[Errors]
			VALUES (SUSER_SNAME(), ERROR_NUMBER(), ERROR_STATE(), ERROR_SEVERITY(), ERROR_LINE(), ERROR_PROCEDURE(), ERROR_MESSAGE(), GETDATE());
			
		RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
	END CATCH
END
------------
-- insert --
------------
GO
CREATE OR ALTER PROCEDURE Insert_table_FavoritesEventTypes -- PARA CRIAR DE RAIZ OU ALTERAR

	@ID_FavoritesEvents INT,
	@ID_User INT,
	@ID_EventSubType INT
AS
BEGIN
	BEGIN TRANSACTION
		BEGIN TRY
			INSERT INTO FavoritesEventTypes(ID_FavoritesEvents, ID_User, ID_EventSubType)
			VALUES (@ID_FavoritesEvents, @ID_User, @ID_EventSubType)
			COMMIT TRANSACTION
		END TRY

	BEGIN CATCH
		ROLLBACK TRANSACTION
		DECLARE @ErrorMessage NVARCHAR(4000);
		DECLARE @ErrorSeverity INT;
		DECLARE @ErrorState INT;

		SELECT
			@ErrorMessage = ERROR_MESSAGE(),
			@ErrorSeverity = ERROR_SEVERITY(),
			@ErrorState = ERROR_STATE();

		INSERT INTO [BoraLa].[dbo].[Errors]
			VALUES (SUSER_SNAME(), ERROR_NUMBER(), ERROR_STATE(), ERROR_SEVERITY(), ERROR_LINE(), ERROR_PROCEDURE(), ERROR_MESSAGE(), GETDATE());
			
		RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
	END CATCH
END
------------
-- delete --
------------
GO
CREATE OR ALTER PROCEDURE Delete_table_FavoritesEventTypes -- PARA CRIAR DE RAIZ OU ALTERAR

	@ID_FavoritesEvents INT
AS
BEGIN
	BEGIN TRANSACTION
		BEGIN TRY
			DELETE FROM FavoritesEventTypes
			WHERE ID_FavoritesEvents = @ID_FavoritesEvents
			COMMIT TRANSACTION
		END TRY

	BEGIN CATCH
		ROLLBACK TRANSACTION
		DECLARE @ErrorMessage NVARCHAR(4000);
		DECLARE @ErrorSeverity INT;
		DECLARE @ErrorState INT;

		SELECT
			@ErrorMessage = ERROR_MESSAGE(),
			@ErrorSeverity = ERROR_SEVERITY(),
			@ErrorState = ERROR_STATE();

		INSERT INTO [BoraLa].[dbo].[Errors]
			VALUES (SUSER_SNAME(), ERROR_NUMBER(), ERROR_STATE(), ERROR_SEVERITY(), ERROR_LINE(), ERROR_PROCEDURE(), ERROR_MESSAGE(), GETDATE());
			
		RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
	END CATCH
END
-------------
---- get ----
-------------
GO
CREATE OR ALTER PROCEDURE	Get_table_FavoritesEventTypes -- PARA CRIAR DE RAIZ OU ALTERAR
AS SELECT * FROM FavoritesEventTypes
-----------------
---- get  by ----
-----------------
GO
CREATE OR ALTER PROCEDURE	GetByID_table_FavoritesEventTypes -- PARA CRIAR DE RAIZ OU ALTERAR
	@ID_FavoritesEvents INT
AS SELECT * FROM FavoritesEventTypes WHERE ID_FavoritesEvents = @ID_FavoritesEvents
-- _________________________________________________________________________________________________________________________
-- Table FavoritesSpaces
-- _________________________________________________________________________________________________________________________
------------
-- update --
------------
GO
CREATE OR ALTER PROCEDURE Update_table_FavoritesSpaces -- PARA CRIAR DE RAIZ OU ALTERAR
	
	@ID_FavoritesSpaces INT,
	@ID_User INT,
	@ID_Space INT
AS
BEGIN
	BEGIN TRANSACTION
		BEGIN TRY
			UPDATE FavoritesSpaces 
			SET ID_User = @ID_User,
				ID_Space = @ID_Space
			WHERE ID_FavoritesSpaces = @ID_FavoritesSpaces
			COMMIT TRANSACTION
		END TRY

	BEGIN CATCH
		ROLLBACK TRANSACTION
		DECLARE @ErrorMessage NVARCHAR(4000);
		DECLARE @ErrorSeverity INT;
		DECLARE @ErrorState INT;

		SELECT
			@ErrorMessage = ERROR_MESSAGE(),
			@ErrorSeverity = ERROR_SEVERITY(),
			@ErrorState = ERROR_STATE();

		INSERT INTO [BoraLa].[dbo].[Errors]
			VALUES (SUSER_SNAME(), ERROR_NUMBER(), ERROR_STATE(), ERROR_SEVERITY(), ERROR_LINE(), ERROR_PROCEDURE(), ERROR_MESSAGE(), GETDATE());
			
		RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
	END CATCH
END
------------
-- insert --
------------
GO
CREATE OR ALTER PROCEDURE Insert_table_FavoritesSpaces -- PARA CRIAR DE RAIZ OU ALTERAR

	@ID_FavoritesSpaces INT,
	@ID_User INT,
	@ID_Space INT
AS
BEGIN
	BEGIN TRANSACTION
		BEGIN TRY
			INSERT INTO FavoritesSpaces(ID_FavoritesSpaces, ID_User, ID_Space)
			VALUES (@ID_FavoritesSpaces, @ID_User, @ID_Space)
			COMMIT TRANSACTION
		END TRY

	BEGIN CATCH
		ROLLBACK TRANSACTION
		DECLARE @ErrorMessage NVARCHAR(4000);
		DECLARE @ErrorSeverity INT;
		DECLARE @ErrorState INT;

		SELECT
			@ErrorMessage = ERROR_MESSAGE(),
			@ErrorSeverity = ERROR_SEVERITY(),
			@ErrorState = ERROR_STATE();

		INSERT INTO [BoraLa].[dbo].[Errors]
			VALUES (SUSER_SNAME(), ERROR_NUMBER(), ERROR_STATE(), ERROR_SEVERITY(), ERROR_LINE(), ERROR_PROCEDURE(), ERROR_MESSAGE(), GETDATE());
			
		RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
	END CATCH
END
------------
-- delete --
------------
GO
CREATE OR ALTER PROCEDURE Delete_table_FavoritesSpaces -- PARA CRIAR DE RAIZ OU ALTERAR

	@ID_FavoritesSpaces INT
AS
BEGIN
	BEGIN TRANSACTION
		BEGIN TRY
			DELETE FROM FavoritesSpaces
			WHERE ID_FavoritesSpaces = @ID_FavoritesSpaces
			COMMIT TRANSACTION
		END TRY

	BEGIN CATCH
		ROLLBACK TRANSACTION
		DECLARE @ErrorMessage NVARCHAR(4000);
		DECLARE @ErrorSeverity INT;
		DECLARE @ErrorState INT;

		SELECT
			@ErrorMessage = ERROR_MESSAGE(),
			@ErrorSeverity = ERROR_SEVERITY(),
			@ErrorState = ERROR_STATE();

		INSERT INTO [BoraLa].[dbo].[Errors]
			VALUES (SUSER_SNAME(), ERROR_NUMBER(), ERROR_STATE(), ERROR_SEVERITY(), ERROR_LINE(), ERROR_PROCEDURE(), ERROR_MESSAGE(), GETDATE());
			
		RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
	END CATCH
END
-------------
---- get ----
-------------
GO
CREATE OR ALTER PROCEDURE	Get_table_FavoritesSpaces -- PARA CRIAR DE RAIZ OU ALTERAR
AS SELECT * FROM FavoritesSpaces
-----------------
---- get  by ----
-----------------
GO
CREATE OR ALTER PROCEDURE	GetByID_table_FavoritesSpaces -- PARA CRIAR DE RAIZ OU ALTERAR
	@ID_FavoritesSpaces INT
AS SELECT * FROM FavoritesSpaces WHERE ID_FavoritesSpaces = @ID_FavoritesSpaces

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
@Capacity INT

AS
BEGIN
	BEGIN TRY
		BEGIN TRAN
		INSERT INTO [dbo].[Spaces] 
		([Name]
		, [Address]
		, [Coordinates]
		, [Capacity])
			VALUES (@Name, @Address, @Coordinates, @Capacity)
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
		UPDATE [dbo].[Spaces]
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
@Date DATE, 
@Time TIME,
@Duration TIME,
@MinPrice Decimal(7,2),
@MaxPrice Decimal(7,2),
@MinAge INT,
@Acessibility BIT,
@Description NVARCHAR(2000),
@Observations NVARCHAR(1000),
@PromoterIsOwner BIT,
@ID_EventSubtype INT,
@ID_Promoter INT,
@ID_Space INT

AS
BEGIN
	BEGIN TRY
		BEGIN TRAN
		INSERT INTO [dbo].[Events] 
		([Name],
		[Date],
		[Time],
		[Duration],
		[MinPrice],
		[MaxPrice],
		[MinAge],
		[Acessibility],
		[Description],
		[Observations],
		[PromoterIsOwner],
		[ID_EventSubtype],
		[ID_Promoter],
		[ID_Space])
			VALUES (@Name, @Date, @Time, @Duration, @MinPrice, @MaxPrice, @MinAge, 
			@Acessibility, @Description, @Observations, @PromoterIsOwner, @ID_EventSubtype, 
			@ID_Promoter, @ID_Space)
		COMMIT TRAN
		PRINT 'estou aqui'
		INSERT INTO [dbo].ChangeLog(LogText, Date, Username)
		 SELECT 
		CONCAT(@Name, Convert(NVARCHAR,  @Date), CONVERT(NVARCHAR, @TIME), CONVERT(NVARCHAR, @Duration), CONVERT(NVARCHAR, @MinPrice), CONVERT(NVARCHAR, @MaxPrice),
		CONVERT(NVARCHAR, @MinAge), CONVERT(NVARCHAR, @Acessibility), @Description, @Observations, CONVERT(NVARCHAR, @PromoterIsOwner), CONVERT(NVARCHAR, @ID_EventSubtype)
		, CONVERT(NVARCHAR, @ID_Promoter), CONVERT(NVARCHAR, @ID_Space)),
        GETDATE(),
        ORIGINAL_LOGIN()
		PRINT 'estou aqui2'
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

--recuperar uma lista de todas as avaliações de espaços e incluir informações sobre 
--os usuários que as fizeram, mesmo que nem todos os espaços tenham avaliações.
SELECT
    U.Name AS UserName,
    S.Name AS SpaceName,
    SR.Rating,
    SR.Comment
FROM
    SpacesRatings SR
RIGHT JOIN
    Users U ON SR.ID_User = U.ID_User
RIGHT JOIN
    Spaces S ON SR.ID_Space = S.ID_Space;
--RIGHT JOIN para garantir que todas as avaliações de espaços sejam incluídas, independentemente 
--de haver ou não correspondência com os usuários. Se não houver uma correspondência, os campos 
--relacionados aos usuários serão nulos.
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
@PromoterIsOwner BIT,
@ID_EventSubtype INT,
@ID_Promoter INT,
@ID_Space INT

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
			PromoterIsOwner = @PromoterIsOwner,
			ID_EventSubtype = @ID_EventSubtype,
			ID_Promoter = @ID_Promoter,
			ID_Space = @ID_Space
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
--recuperar uma lista de todos os usuários e as avaliações que 
--eles deram aos espaços (se tiverem feito alguma avaliação).
SELECT
    U.Name AS UserName,
    S.Name AS SpaceName,
    SR.Rating,
    SR.Comment
FROM
    Users U
LEFT JOIN
    SpacesRatings SR ON U.ID_User = SR.ID_User
LEFT JOIN
    Spaces S ON SR.ID_Space = S.ID_Space;
--LEFT JOIN para garantir que todos os usuários sejam incluídos, independentemente 
--de terem ou não feito alguma avaliação. Caso não tenham avaliações, 
--os campos relacionados a SpacesRatings serão nulos.

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