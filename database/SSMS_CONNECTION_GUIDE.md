# SQL Server Management Studio (SSMS) Connection and Database Setup Guide

## Step-by-Step Guide to Connect to SSMS and Create the Database

### PART 1: Installing SSMS (if not already installed)

1. **Download SSMS**
   - Visit: https://learn.microsoft.com/en-us/sql/ssms/download-sql-server-management-studio-ssms
   - Download the latest version (currently SQL Server Management Studio 20.0)
   - Run the installer and follow the installation wizard

2. **Install SQL Server Express or Full Version**
   - Download from: https://www.microsoft.com/en-us/sql-server/sql-server-downloads
   - Choose SQL Server Express (free) or Enterprise Edition
   - Run the installer and complete the installation

---

### PART 2: Connecting to SQL Server Using SSMS

#### **Connection Method 1: Using Windows Authentication (Recommended for Local Development)**

1. **Open SQL Server Management Studio**
   - Launch SSMS from your Start Menu or Desktop shortcut

2. **Connect to Local Server**
   - Server name field: `localhost` or `.` (dot) or `YOUR_COMPUTER_NAME`
   - Authentication: `Windows Authentication` (selected by default)
   - Click `Connect`
   
   **Note:** If you're having issues finding the server, try these names:
   - `(LocalDB)\MSSQLLocalDB` for LocalDB
   - `.\SQLEXPRESS` for SQL Server Express
   - `localhost\SQLEXPRESS` for Remote Express

3. **Connection Successful**
   - You should now see the Object Explorer on the left side
   - Expand "Databases" to see existing databases

---

#### **Connection Method 2: Using SQL Server Authentication**

1. **Open SSMS**

2. **Fill Connection Details**
   - Server name: `localhost` or `YOUR_SERVER_NAME`
   - Authentication: `SQL Server Authentication`
   - Login: `sa` (System Administrator)
   - Password: (the password you set during SQL Server installation)
   - Click `Connect`

3. **Connection Successful**
   - Object Explorer will display the server contents

---

### PART 3: Creating the Login Database

#### **Method A: Using SQL Script (Recommended)**

1. **Open a New Query Window**
   - Click `File` → `New` → `Query with Current Connection`
   - OR use keyboard shortcut: `Ctrl + N`

2. **Copy Database Script**
   - Open [CreateLoginDB.sql](./CreateLoginDB.sql) file
   - Copy all the SQL code

3. **Paste into Query Editor**
   - Paste the script into the Query window
   - Select all the code: `Ctrl + A`

4. **Execute the Script**
   - Click `Execute` button (▶️) on the toolbar
   - OR use keyboard shortcut: `F5`
   - Wait for the script to complete

5. **Verify Database Creation**
   - Expand "Databases" in Object Explorer
   - You should see "LoginDB" in the list
   - Expand "LoginDB" → "Tables" to see the "Users" table

---

#### **Method B: Using SSMS GUI**

1. **Create Database Manually**
   - Right-click on "Databases" in Object Explorer
   - Select "New Database..."
   - Enter Name: `LoginDB`
   - Click `OK`

2. **Create Users Table**
   - Right-click on "Tables" in LoginDB
   - Select "New Table..."
   - Add columns:
     - Id (int, Primary Key, Identity Yes)
     - Name (nvarchar(256), Not Null)
     - Email (nvarchar(256), Not Null, Unique)
     - PasswordHash (nvarchar(max), Not Null)
     - CreatedAt (datetime2, Not Null, Default: GETUTCDATE())
     - LastLogin (datetime2, Nullable)
     - IsActive (bit, Not Null, Default: 1)
   - Save the table as "Users"

---

### PART 4: Verifying the Database Connection

#### **Test Connection in SSMS**

1. **Query the Users Table**
   ```sql
   USE LoginDB;
   SELECT * FROM Users;
   ```

2. **Expected Output**
   - If successful, you'll see the table structure with column headers
   - Sample data should be visible if you ran the creation script

3. **Get Database Info**
   ```sql
   -- Check database properties
   SELECT DB_NAME() AS DatabaseName;
   
   -- Count total users
   SELECT COUNT(*) AS TotalUsers FROM LoginDB.dbo.Users;
   ```

---

### PART 5: Connection String for Application

#### **For ASP.NET Core Application**

Copy this connection string to `appsettings.json`:

**Windows Authentication:**
```
Server=localhost;Database=LoginDB;Trusted_Connection=True;TrustServerCertificate=True;
```

**SQL Server Authentication:**
```
Server=localhost;Database=LoginDB;User Id=sa;Password=YourPassword;TrustServerCertificate=True;
```

#### **For Other Applications**

```
Data Source=localhost;Initial Catalog=LoginDB;Integrated Security=True;TrustServerCertificate=True;
```

---

### PART 6: Troubleshooting Connection Issues

#### **Issue 1: Cannot connect to server**

**Solution:**
- Ensure SQL Server service is running
  - Open Services (services.msc)
  - Search for "SQL Server (SQLEXPRESS)" or "MSSQLSERVER"
  - If not running, right-click and select "Start"
- Try different server names (localhost, ., (local), computer-name)
- Check firewall settings

#### **Issue 2: Login failed for user 'sa'**

**Solution:**
- Verify SQL Server Authentication is enabled
- Use correct password set during SQL Server installation
- Reset SA password using:
  ```sql
  ALTER LOGIN sa ENABLE;
  ALTER LOGIN sa WITH PASSWORD = 'NewPassword';
  ```

#### **Issue 3: Database not visible in Object Explorer**

**Solution:**
- Refresh Object Explorer: `F5` or right-click and "Refresh"
- Verify the connection is established
- Check server name and user permissions

#### **Issue 4: Table doesn't appear**

**Solution:**
- Refresh the database node: Select database → Press `F5`
- Expand "Tables" folder
- Check if table exists in database:
  ```sql
  SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Users';
  ```

---

### PART 7: Creating Additional Users in Database

#### **Insert Test Users**

```sql
USE LoginDB;

-- Insert test user
INSERT INTO Users (Name, Email, PasswordHash, IsActive)
VALUES ('John Doe', 'john@example.com', 'hashed_password_here', 1);

-- Insert another user
INSERT INTO Users (Name, Email, PasswordHash, IsActive)
VALUES ('Jane Smith', 'jane@example.com', 'hashed_password_here', 1);

-- View all users
SELECT * FROM Users;
```

---

### PART 8: Useful SSMS Commands

```sql
-- Get database size
EXEC sp_databases;

-- Check SQL Server version
SELECT @@VERSION;

-- List all databases
SELECT name FROM sys.databases;

-- Check table structure
EXEC sp_help 'Users';

-- Drop database (use with caution)
DROP DATABASE LoginDB;

-- Backup database
BACKUP DATABASE LoginDB TO DISK = 'C:\Backup\LoginDB.bak';

-- Restore database
RESTORE DATABASE LoginDB FROM DISK = 'C:\Backup\LoginDB.bak';
```

---

### PART 9: Setting Up for Development

#### **Enable Named Pipes (if needed for remote connection)**

1. Open SQL Server Configuration Manager
2. Expand "SQL Server Network Configuration"
3. Right-click on your instance
4. Select "Properties"
5. Verify protocols are enabled (Shared Memory, Named Pipes, TCP/IP)

#### **Create Database User for Application**

```sql
USE LoginDB;

-- Create a database user (optional, for better security)
CREATE LOGIN appuser WITH PASSWORD = 'AppPassword123!';
CREATE USER appuser FOR LOGIN appuser;
ALTER ROLE db_datareader ADD MEMBER appuser;
ALTER ROLE db_datawriter ADD MEMBER appuser;
GRANT EXECUTE ON SCHEMA::[dbo] TO appuser;
```

---

## Quick Reference: Connection Checklist

- [ ] SQL Server is installed and running
- [ ] SSMS is installed and launched
- [ ] Connected to SQL Server successfully
- [ ] LoginDB database is created
- [ ] Users table exists with correct columns
- [ ] Sample data is inserted
- [ ] Connection string is correct in application
- [ ] Firewall allows database connections
- [ ] Application can connect and communicate with database

---

## Need Help?

- SSMS Documentation: https://learn.microsoft.com/en-us/sql/ssms/sql-server-management-studio-ssms
- SQL Server: https://learn.microsoft.com/en-us/sql/
- Entity Framework Core: https://learn.microsoft.com/en-us/ef/core/
