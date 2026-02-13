-- Backup script to save user data
-- Run this to backup the LoginDB database

-- Create backup directory if needed
-- BACKUP DATABASE LoginDB 
-- TO DISK = 'C:\SQLServerBackups\LoginDB.bak'
-- WITH FORMAT, INIT, STATS = 10;

-- Export users to CSV (run in SSMS)
SELECT Id, Name, Email, CreatedAt, LastLogin, IsActive
FROM LoginDB.dbo.Users;

-- Scheduled maintenance
-- Remove inactive users (created more than 90 days ago and never logged in)
DELETE FROM Users
WHERE CreatedAt < DATEADD(DAY, -90, GETUTCDATE())
AND LastLogin IS NULL;

-- List users sorted by last login
SELECT 
    Id,
    Name,
    Email,
    CreatedAt,
    LastLogin,
    DATEDIFF(DAY, LastLogin, GETUTCDATE()) AS DaysInactive
FROM Users
ORDER BY LastLogin DESC;
