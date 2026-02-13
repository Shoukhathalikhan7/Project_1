# Quick Start - Run Everything in 5 Minutes

Follow these steps to get the entire application running.

## Prerequisites Checklist

Before starting, verify you have:
- ✅ SQL Server installed and running
- ✅ .NET 8 SDK installed
- ✅ Node.js 18+ installed
- ✅ VS Code or Terminal/PowerShell available

---

## Step 1: Create Database (1 minute)

### Option A: Using SSMS (Recommended)

1. **Open SSMS**
2. **Connect to server** (default: localhost, Windows Auth)
3. **File → New → Query with Current Connection**
4. **Copy entire content** from: `database/CreateLoginDB.sql`
5. **Paste into query editor**
6. **Press F5** to execute

Expected: "Database LoginDB created successfully"

### Option B: Using Command Line

```bash
# Open PowerShell as Administrator
sqlcmd -S localhost -i database/CreateLoginDB.sql
```

---

## Step 2: Start Backend (1 minute)

Open **Terminal 1** (Command Prompt or PowerShell):

```bash
cd backend/LoginAPI
dotnet run
```

Wait for message: `Now listening on: http://localhost:5000`

---

## Step 3: Start Frontend (1 minute)

Open **Terminal 2** (separate window):

```bash
cd frontend
npm install  # Only needed first time
npm start
```

Wait for message: `Application bundle generated successfully`

---

## Step 4: Test Login (1 minute)

1. **Open browser**: http://localhost:4200
2. **Enter credentials**:
   - Email: `admin@example.com`
   - Password: `Admin@123`
3. **Click Sign In**
4. Should see dashboard with "Welcome back, Admin User"

---

## Step 5: Test Registration (1 minute)

1. **Click "Sign up"**
2. **Enter details**:
   - Name: `My Test User`
   - Email: `test@example.com`
   - Password: `Test@1234`
   - Confirm: `Test@1234`
3. **Click Create Account**
4. **Login with new credentials**

---

## API Documentation

While backend is running (from Terminal 1):
- **Swagger UI**: http://localhost:5000/swagger/index.html

---

## Project Folders

```
Login page/
├── frontend/           # Angular app - runs on port 4200
├── backend/LoginAPI/   # C# API - runs on port 5000
├── database/           # SQL Server scripts
├── README.md           # Full documentation
├── INSTALLATION_GUIDE.md
└── ENVIRONMENT_CONFIG.md
```

---

## Key Files

| File | Purpose |
|------|---------|
| `database/CreateLoginDB.sql` | Creates database and Users table |
| `database/SSMS_CONNECTION_GUIDE.md` | Detailed SSMS setup instructions |
| `backend/LoginAPI/appsettings.json` | Backend configuration |
| `backend/LoginAPI/Program.cs` | Backend startup |
| `frontend/src/app/login/` | Login page UI |
| `frontend/src/app/services/auth.service.ts` | Authentication logic |

---

## Troubleshooting

### Backend won't start
```bash
# Port 5000 in use? Change it in backend/LoginAPI/Program.cs
# Or kill the process:
netstat -ano | findstr :5000
taskkill /PID <PID> /F
```

### Frontend won't start
```bash
# Reinstall dependencies:
cd frontend
rm -r node_modules
npm install
npm start
```

### Database errors
1. Verify SQL Server is running (Services → Search "SQL Server")
2. Update connection string in `appsettings.json`
3. Re-run the database creation script

---

## Full Documentation

- **Setup Guide**: See [README.md](./README.md)
- **SSMS Connection**: See [database/SSMS_CONNECTION_GUIDE.md](./database/SSMS_CONNECTION_GUIDE.md)
- **Installation Details**: See [INSTALLATION_GUIDE.md](./INSTALLATION_GUIDE.md)
- **Configuration**: See [ENVIRONMENT_CONFIG.md](./ENVIRONMENT_CONFIG.md)

---

## Terminal Commands Cheat Sheet

```bash
# Backend
cd backend/LoginAPI
dotnet restore          # Install dependencies
dotnet run              # Start server
dotnet watch run        # Auto-restart on changes
Ctrl+C                  # Stop

# Frontend
cd frontend
npm install             # Install dependencies
npm start               # Start dev server
npm run build           # Build for production
npm test                # Run tests
Ctrl+C                  # Stop

# Database
sqlcmd -S localhost -i database/CreateLoginDB.sql  # Run SQL script
```

---

**You're all set! 🎉 Enjoy building!**
