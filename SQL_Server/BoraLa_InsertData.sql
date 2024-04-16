-- Tabela Errors
INSERT INTO ERRORS (UserName, ErrorNumber, ErrorState, ErrorSeverity, ErrorLine, ErrorProcedure, ErrorMessage, ErrorDateTime) VALUES
('User1', 1001, 1, 1, 10, 'Procedure1', 'Error message 1', '2024-01-01T08:00:00'),
('User2', 1002, 2, 2, 20, 'Procedure2', 'Error message 2', '2024-01-02T09:00:00'),
('User3', 1003, 3, 3, 30, 'Procedure3', 'Error message 3', '2024-01-03T10:00:00'),
('User4', 1004, 4, 4, 40, 'Procedure4', 'Error message 4', '2024-01-04T11:00:00'),
('User5', 1005, 5, 5, 50, 'Procedure5', 'Error message 5', '2024-01-05T12:00:00');

-- Tabela ChangeLog
INSERT INTO ChangeLog (LogText, [Date], Username) VALUES
('Log entry 1', '2024-01-01T08:00:00', 'User1'),
('Log entry 2', '2024-01-02T09:00:00', 'User2'),
('Log entry 3', '2024-01-03T10:00:00', 'User3'),
('Log entry 4', '2024-01-04T11:00:00', 'User4'),
('Log entry 5', '2024-01-05T12:00:00', 'User5');

-- Tabela Credentials
INSERT INTO Credentials (Email, [Password], [Role]) VALUES
('user1@example.com', 'passwordacc', 'Admin'),
('user2@example.com', 'passwordbcc', 'User'),
('user3@example.com', 'passwordccc', 'User'),
('user4@example.com', 'passworddcc', 'User'),
('user5@example.com', 'passwordecc', 'Admin');

-- Tabela Users
INSERT INTO Users (Name, Location, BirthDate, ProfilePicture) VALUES
('Ana Silva', geography::Point(38.7223, -9.1393, 4326), '1990-01-01', 'ana_silva.jpg'),
('Pedro Santos', geography::Point(40.4168, -3.7038, 4326), '1995-02-02', 'pedro_santos.jpg'),
('Marta Oliveira', geography::Point(41.1579, -8.6291, 4326), '1985-03-03', 'marta_oliveira.jpg'),
('Rui Costa', geography::Point(37.0171, -7.9307, 4326), '1980-04-04', 'rui_costa.jpg'),
('Sofia Pereira', geography::Point(37.0755, -8.7275, 4326), '1975-05-05', 'sofia_pereira.jpg');

-- Tabela Spaces
INSERT INTO Spaces ([Name], [Address], Coordinates, Capacity, AverageRating, Schedule) VALUES
('Lisbon Event Center', 'Praça das Indústrias, 1300-307 Lisboa', geography::Point(38.7223, -9.1393, 4326), 200, 4.2, NULL),
('Porto Convention Center', 'Rua da Madeira, 4000-330 Porto', geography::Point(41.1579, -8.6291, 4326), 300, 4.5, NULL),
('Algarve Expo Hall', 'Estrada da Penha, 8000-151 Faro', geography::Point(37.0171, -7.9307, 4326), 150, 4.0, NULL),
('Coimbra Conference Center', 'Avenida Fernão de Magalhães, 3000-184 Coimbra', geography::Point(40.2033, -8.4103, 4326), 180, 4.1, NULL),
('Braga Exhibition Hall', 'Avenida Central, 4710-229 Braga', geography::Point(41.5519, -8.4285, 4326), 250, 4.3, NULL);

-- Tabela PromoterCategories
INSERT INTO PromoterCategories (Name, ServiceDescription, Fee) VALUES
('Concerts', 'Promoting concerts and music events', 10.00),
('Exhibitions', 'Organizing art exhibitions and cultural events', 15.00),
('Sports', 'Managing sports events and tournaments', 20.00),
('Conferences', 'Arranging conferences and business meetings', 12.50),
('Festivals', 'Hosting festivals and outdoor events', 18.00);

INSERT INTO Promoters (Name, Description, ID_Credential, ID_PromoterCategory) VALUES
('Music Makers', 'Promoting live music events since 2005', 1, 1),
('Artistic Expressions', 'Organizing art exhibitions and cultural events', 2, 2),
('Sports Unlimited', 'Bringing sports events to the community', 3, 3),
('Business Minds', 'Connecting professionals through conferences', 4, 4),
('Festival Fun', 'Creating memorable festival experiences', 5, 5);

-- Tabela EventTypes
INSERT INTO EventTypes (Name) VALUES
('Concert'),
('Exhibition'),
('Sports'),
('Conference'),
('Festival');

-- Tabela EventSubTypes
INSERT INTO EventSubTypes (ID_EventType, Name, TargetAge) VALUES
(1, 'Rock Concert', NULL),
(1, 'Jazz Concert', NULL),
(2, 'Modern Art Exhibition', NULL),
(2, 'Classical Art Exhibition', NULL),
(3, 'Football Match', 18),
(3, 'Basketball Game', 16),
(4, 'Technology Conference', NULL),
(4, 'Business Summit', NULL),
(5, 'Music Festival', 18),
(5, 'Food Festival', NULL);

-- Tabela Events
INSERT INTO Events ([Name], AverageRating, [Date], [Time], Duration, MinPrice, MaxPrice, MinAge, Acessibility, [Description], Observations, PromoterIsOwner, ID_EventSubtype, ID_Promoter, ID_Space) VALUES
('Annual Rock Concert', 4.5, '2024-02-15', '19:00:00', '02:00:00', 20.00, 50.00, 18, 1, 'Reunem as melhores bandas de rock', 'Gates open at 18:00, ID required for entry', 1, 1, 1, 1),
('Modern Art Showcase', 4.0, '2024-03-20', '10:00:00', '08:00:00', 10.00, 30.00, 0, 1, 'Sao expostas as obras mais relevantes do ano', 'Free admission for all visitors', 0, 2, 2, 2),
('Basketball Championship', 4.2, '2024-04-25', '15:30:00', '03:30:00', 15.00, 40.00, 17, 1, 'Campeonato distrital', NULL, 1, 4, 3, 3),
('Global Tech Summit', 4.7, '2024-05-10', '09:00:00', '10:00:00', 30.00, 80.00, 0, 1, 'Evento que acontece anualmente', 'Limited seats available, register early', 0, 7, 4, 4),
('Summer Music Festival', 4.3, '2024-06-30', '16:00:00', '05:00:00', 25.00, 60.00, 18, 1, 'Reune a melhor musica eletronica', 'Outdoor event, rain or shine', 1, 10, 5, 5);

-- Tabela Pictures
INSERT INTO Pictures ([Name], Link, UploadDate, ID_Event, Id_User, ID_Promoter) VALUES
('Event1_Poster', 'event1_poster.jpg', '2024-02-15T21:30:00', 1, NULL, 1),
('Event2_Poster', 'event2_poster.jpg', '2022-05-15T09:30:00', 2, NULL, 2);

-- Tabela FavoritesEventTypes
INSERT INTO FavoritesEventTypes (ID_User, ID_EventSubType) VALUES
(1, 1),
(1, 2),
(2, 5),
(3, 7),
(4, 5);

-- Tabela FavoritesSpaces
INSERT INTO FavoritesSpaces (ID_User, ID_Space) VALUES
(1, 1),
(1, 3),
(2, 2),
(3, 4),
(4, 5);

-- Tabela EventsRatings
INSERT INTO EventsRatings (Title, Rating, Comment, [Date], ID_User, ID_Event) VALUES
('Great Event', 5, 'Fantastic experience overall', '2024-02-15T21:30:00', 1, 1),
('Good Show', 4, 'Enjoyed the music and atmosphere', '2024-03-20T12:15:00', 2, 2),
('Exciting Game', 4, 'Intense match, worth watching', '2024-04-25T18:00:00', 3, 3),
('Informative Sessions', 5, 'Learned a lot, well-organized', '2024-05-10T11:45:00', 4, 4),
('Awesome Festival', 5, 'Unforgettable performances and vibe', '2024-06-30T22:00:00', 5, 5);

-- Tabela SpacesRatings
INSERT INTO SpacesRatings (Title, Rating, Comment, [Date], ID_User, ID_Space) VALUES
('Excellent Venue', 5, 'Top-notch facilities and service', '2024-02-20T14:00:00', 1, 1),
('Nice Location', 4, 'Convenient spot with good amenities', '2024-03-25T16:45:00', 2, 2),
('Great Facilities', 4, 'Clean and well-maintained facilities', '2024-04-30T09:30:00', 3, 3),
('Good Atmosphere', 5, 'Lively ambiance, perfect for events', '2024-05-15T19:00:00', 4, 4),
('Beautiful Setting', 4, 'Scenic views and cozy atmosphere', '2024-07-01T12:00:00', 5, 5);

-- Tabela SpacesSchedules
INSERT INTO SpacesSchedules (ID_Space, [WeekDay], OpenHour, CloseHour) VALUES
(1, 1, '09:00:00', '18:00:00'),
(1, 2, '09:00:00', '18:00:00'),
(1, 3, '09:00:00', '18:00:00'),
(1, 4, '09:00:00', '18:00:00'),
(1, 5, '09:00:00', '18:00:00'),
(2, 1, '10:00:00', '20:00:00'),
(2, 2, '10:00:00', '20:00:00'),
(2, 3, '10:00:00', '20:00:00'),
(2, 4, '10:00:00', '20:00:00'),
(2, 5, '10:00:00', '20:00:00');

-- Tabela Notifications
INSERT INTO Notifications (ID_User, ID_Event, Description) VALUES
(1, 1, 'Reminder: Rock Concert Tomorrow'),
(2, 2, 'New Exhibition Opening This Weekend'),
(3, 3, 'Upcoming Basketball Game Notification'),
(4, 4, 'Tech Summit Registration Confirmation'),
(5, 5, 'Don''t Miss the Summer Music Festival');

-- Tabela ReportsTypes
INSERT INTO ReportsTypes ([Type], Description) VALUES
('Spam', 'Reported content is spam or unsolicited'),
('Inappropriate', 'Content violates community guidelines'),
('Copyright', 'Reported content infringes on copyright'),
('Other', 'Other type of report or issue');

-- Tabela EventsReports
INSERT INTO EventsReports (ID_User, ID_Event, ID_ReportType, [Date], Comment) VALUES
(1, 1, 2, '2024-02-15', 'Reported inappropriate behavior at the event'),
(2, 2, 1, '2024-03-20', 'Suspected spam content in event description'),
(3, 3, 3, '2024-04-25', 'Possible copyright violation in event materials'),
(4, 4, 4, '2024-05-10', 'Other issues with event organization'),
(5, 5, 2, '2024-06-30', 'Reported inappropriate content in event promotion');

-- Tabela SpacesReports
INSERT INTO SpacesReports (ID_User, ID_Space, ID_ReportType, [Date], Comment) VALUES
(1, 1, 3, '2024-02-20', 'Reported safety concerns regarding the venue'),
(2, 2, 1, '2024-03-25', 'Suspected spam listings for the space'),
(3, 3, 2, '2024-04-30', 'Content posted violates community guidelines'),
(4, 4, 4, '2024-05-15', 'Reported issues with accessibility in the space'),
(5, 5, 3, '2024-07-01', 'Safety hazards observed during a visit to the space');