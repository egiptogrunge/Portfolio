--listar o nome as coord e o rating de todos os espaços e se tiver 1 evento hoje a informação e o subtipo 

SELECT sp.Name, sp.Coordinates, sp.AverageRating, est.Name FROM Spaces sp
JOIN [Events] ev ON sp.ID_Space = ev.ID_Space
JOIN EventSubTypes est ON ev.ID_EventSubtype = est.ID_EventSubType
WHERE ev.Date = GETDATE()

SELECT sp.Name, sp.Coordinates, sp.AverageRating, est.Name FROM Spaces sp
JOIN [Events] ev ON sp.ID_Space = ev.ID_Space
JOIN EventSubTypes est ON ev.ID_EventSubtype = est.ID_EventSubType
WHERE ev.Date = '2024-02-15'

SELECT sp.Name AS SpaceName, ev.Name AS EventName, sp.Coordinates, sp.AverageRating, est.Name FROM Spaces sp
LEFT JOIN [Events] ev ON sp.ID_Space = ev.ID_Space AND ev.Date = '2024-02-15'
LEFT JOIN EventSubTypes est ON ev.ID_EventSubtype = est.ID_EventSubType

SELECT * FROM EventSubTypes
SELECT * FROM Events