CREATE DATABASE Aremangala;
GO

USE Aremangala;
GO

CREATE TABLE Users (
    ID INT PRIMARY KEY,
    Name NVARCHAR(100)
);
GO

INSERT INTO Users (ID, Name) VALUES (1, 'John Doe'), (2, 'Jane Smith'), (3, 'Juan Perez');
GO
