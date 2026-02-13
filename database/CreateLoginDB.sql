/*==========================================================
  Login System Database Setup Script
  Run in SQL Server Management Studio (SSMS)
==========================================================*/

-- Create the database if it does not exist
IF NOT EXISTS (SELECT 1 FROM sys.databases WHERE name = 'LoginDB')
BEGIN
    CREATE DATABASE LoginDB;
    PRINT 'Database LoginDB created successfully.';
END
ELSE
BEGIN
    PRINT 'Database LoginDB already exists.';
END
GO

-- Use the database
USE LoginDB;
GO

-- Create Users table if it does not exist
IF NOT EXISTS (SELECT 1 FROM sys.tables WHERE name = 'Users')
BEGIN
    CREATE TABLE dbo.Users
    (
        Id INT IDENTITY(1,1) PRIMARY KEY,
        Name NVARCHAR(256) NOT NULL,
        Email NVARCHAR(256) NOT NULL UNIQUE,
        PasswordHash NVARCHAR(MAX) NOT NULL,
        CreatedAt DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME(),
        LastLogin DATETIME2 NULL,
        IsActive BIT NOT NULL DEFAULT 1
    );

    PRINT 'Table Users created successfully.';

    -- Create index on Email for faster lookups
    CREATE INDEX IX_Users_Email ON dbo.Users (Email);
    PRINT 'Index created on Email column.';
END
ELSE
BEGIN
    PRINT 'Table Users already exists.';
END
GO

-- Insert sample data if it does not exist
IF NOT EXISTS (SELECT 1 FROM dbo.Users WHERE Email = 'admin@example.com')
BEGIN
    -- Sample password hash for "Admin@123"
    INSERT INTO dbo.Users
    (
        Name,
        Email,
        PasswordHash,
        CreatedAt,
        IsActive
    )
    VALUES
    (
        'Admin User',
        'admin@example.com',
        'vI+3K8xQmz7BmZQqId3FaILkPXe3k4nzGrHTqjBnIzs=',
        SYSUTCDATETIME(),
        1
    );

    PRINT 'Sample admin user created.';
END
ELSE
BEGIN
    PRINT 'Sample admin user already exists.';
END
GO

-- Display all users
PRINT 'Current users in the database:';
SELECT * FROM dbo.Users;
GO

-- Display database summary info
DECLARE @TotalUsers INT;

SELECT @TotalUsers = COUNT(*) FROM dbo.Users;

PRINT '';
PRINT 'Database setup complete!';
PRINT 'Database Name: LoginDB';
PRINT 'Total Users: ' + CAST(@TotalUsers AS VARCHAR(10));
GO
