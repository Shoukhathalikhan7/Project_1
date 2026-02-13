# Installation Guide

Complete installation and setup instructions for the Login Page System.

## Prerequisites

Before starting, ensure you have installed:

### Required Software
- [ ] **SQL Server** (2019 or later)
  - Download: https://www.microsoft.com/en-us/sql-server/sql-server-downloads
  - Choose Express (free) or Enterprise edition
  
- [ ] **SQL Server Management Studio (SSMS)**
  - Download: https://learn.microsoft.com/en-us/sql/ssms/download-sql-server-management-studio-ssms
  - Version: 20.0 or later

- [ ] **.NET 8 SDK**
  - Download: https://dotnet.microsoft.com/en-us/download/dotnet/8.0
  - Verify: Run `dotnet --version` in terminal

- [ ] **Node.js 18+**
  - Download: https://nodejs.org/
  - Verify: Run `node --version` in terminal

---

## Step 1: Database Installation

### 1.1 Install SQL Server

1. Download SQL Server from Microsoft website
2. Run the installer
3. Choose installation type: **Developer** (free with basic features)
4. Accept license terms
5. Select installation location
6. Select features:
   - ✅ Database Engine Services
   - ✅ Full-Text and Semantic Searches
   - Leave others as default
7. Configure instance: Keep default or choose custom name
8. Select authentication mode: **Windows Authentication** (simpler for development)
9. Wait for installation to complete

### 1.2 Verify SQL Server Installation

1. Open **Services** (press `Win + R`, type `services.msc`)
2. Find "SQL Server" service
3. Verify status is "Running" (green arrow)
4. If not running, right-click and select "Start"

### 1.3 Install SQL Server Management Studio (SSMS)

1. Down SSMS from Microsoft website
2. Run installer
3. Select installation folder
4. Follow installation wizard
5. Launch SSMS after installation

---

## Step 2: Create Database

### 2.1 Connect to SQL Server

1. Open **SSMS**
2. Connection dialog appears automatically
3. Server name: `localhost` (or `.`)
4. Authentication: `Windows Authentication`
5. Click `Connect`
6. Wait 5-10 seconds for connection

### 2.2 Run Database Creation Script

1. Click `File` → `New` → `Query with Current Connection`
2. Copy entire content from `database/CreateLoginDB.sql`
3. Paste into query window
4. Press `F5` to execute
5. Check output messages in Results window
6. Should see: "Database LoginDB created successfully"

### 2.3 Verify Database

1. Right-click "Databases" in Object Explorer
2. Select "Refresh" (or press `F5`)
3. Look for "LoginDB" in the list
4. Expand LoginDB → Tables
5. Verify "Users" table exists

---

## Step 3: Backend Setup

### 3.1 Install .NET SDK

1. Download .NET 8 SDK
2. Run installer
3. Follow installation steps
4. Restart your computer
5. Verify installation:
   ```bash
   dotnet --version
   ```
   Should show: `8.0.x` or higher

### 3.2 Configure Backend

1. Navigate to backend folder:
   ```bash
   cd backend/LoginAPI
   ```

2. Restore NuGet packages:
   ```bash
   dotnet restore
   ```
   Wait for completion (1-2 minutes)

3. Update connection string in `appsettings.json`:
   ```json
   "ConnectionStrings": {
       "DefaultConnection": "Server=localhost;Database=LoginDB;Trusted_Connection=True;TrustServerCertificate=True;"
   }
   ```

4. Apply Entity Framework migrations:
   ```bash
   dotnet ef database update
   ```

### 3.3 Test Backend

1. Run the backend:
   ```bash
   dotnet run
   ```

2. Expected output:
   ```
   info: Microsoft.Hosting.Lifetime[14]
         Now listening on: http://localhost:5000
   ```

3. Open browser: http://localhost:5000/swagger
   Should display Swagger API documentation

4. Keep terminal open, or close with `Ctrl+C`

---

## Step 4: Frontend Setup

### 4.1 Install Node.js

1. Download Node.js LTS from nodejs.org
2. Run installer
3. Use default settings (recommended)
4. Restart your computer
5. Verify installation:
   ```bash
   node --version
   npm --version
   ```

### 4.2 Configure Frontend

1. Navigate to frontend folder:
   ```bash
   cd frontend
   ```

2. Install dependencies:
   ```bash
   npm install
   ```
   Wait for completion (2-3 minutes)

3. Verify Angular CLI is installed:
   ```bash
   npm list --global @angular/cli
   ```
   Or install globally:
   ```bash
   npm install -g @angular/cli
   ```

### 4.3 Test Frontend

1. Start development server:
   ```bash
   npm start
   ```
   Or: `ng serve`

2. Expected output:
   ```
   ✔ Compiled successfully.
   Application bundle generated successfully
   ```

3. Open browser: http://localhost:4200
   Should display login page

4. Keep terminal open

---

## Step 5: Verify Full Setup

### 5.1 Test Database Connection

Open a browser and go to: http://localhost:5000/swagger

1. Find POST `/api/auth/login`
2. Expand it
3. Click "Try it out"
4. Use test credentials:
   ```json
   {
     "email": "admin@example.com",
     "password": "Admin@123"
   }
   ```
5. Click "Execute"
6. Should get response with JWT token

### 5.2 Test Frontend Login

1. Go to: http://localhost:4200
2. Enter:
   - Email: `admin@example.com`
   - Password: `Admin@123`
3. Click "Sign In"
4. Should redirect to dashboard
5. Verify user information is displayed

### 5.3 Test Registration

1. Back on login page
2. Click "Sign up"
3. Fill in:
   - Name: Test User
   - Email: test@example.com
   - Password: Test@1234
   - Confirm: Test@1234
4. Click "Create Account"
5. Message should confirm registration
6. Try logging in with new account

---

## Step 6: Troubleshooting

### Issue: Cannot connect to database

**Solution:**
1. Open Services (services.msc)
2. Find SQL Server service
3. Right-click and select "Start"
4. Wait 30 seconds
5. Update connection string if needed:
   - For Express: `Server=.\SQLEXPRESS;...`
   - For Named instance: `Server=COMPUTERNAME\INSTANCENAME;...`

### Issue: Port already in use

**Solution:**
```bash
# Find process using port 5000
netstat -ano | findstr :5000

# Kill the process (replace PID_NUMBER with actual PID)
taskkill /PID PID_NUMBER /F

# Or change port in Program.cs
```

### Issue: npm install fails

**Solution:**
```bash
# Clear npm cache
npm cache clean --force

# Delete node_modules and package-lock.json
rmdir /s node_modules
del package-lock.json

# Reinstall
npm install
```

### Issue: "Angular CLI not found"

**Solution:**
```bash
# Install Angular CLI globally
npm install -g @angular/cli

# Verify installation
ng version
```

---

## Next Steps

After successful installation:

1. **Customize UI**: Modify SCSS in `frontend/src/app/login/login.component.scss`
2. **Add Features**: Extend backend with more endpoints
3. **Deploy**: Follow deployment guides for production
4. **Security**: Update JWT keys and passwords for production

---

## Installation Checklist

- [ ] SQL Server installed and running
- [ ] SSMS installed
- [ ] LoginDB database created
- [ ] Users table verified in SSMS
- [ ] .NET 8 SDK installed
- [ ] Backend project dependencies restored
- [ ] Backend running on http://localhost:5000
- [ ] Node.js installed
- [ ] Frontend dependencies installed
- [ ] Frontend running on http://localhost:4200
- [ ] Login test successful
- [ ] Registration test successful

---

## Support

For SSMS database connection help, see:
**`database/SSMS_CONNECTION_GUIDE.md`**

For environment configuration, see:
**`ENVIRONMENT_CONFIG.md`**
