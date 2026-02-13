# Step-by-Step Execution Guide

Complete instructions to run the entire project from start to finish.

---

## PART 1: DATABASE SETUP (First Time Only)

### Option A: Using SQL Server Management Studio (SSMS) - Recommended

**Step 1: Open SSMS**
1. Search for "SQL Server Management Studio" in Start Menu
2. Click to open SSMS
3. Wait for connection dialog

**Step 2: Connect to Local Server**
1. Leave default settings:
   - Server name: `localhost`
   - Authentication: `Windows Authentication`
2. Click `Connect` button
3. Wait for Object Explorer to load (10-15 seconds)

**Step 3: Run Database Script**
1. Go to File → New → Query with Current Connection
2. Open file: `Login page\database\CreateLoginDB.sql`
3. Copy ALL content (Ctrl+A, then Ctrl+C)
4. Paste into SSMS query window (Ctrl+V)
5. Click `Execute` button (toolbar button that looks like ▶️ or press F5)
6. Wait for script execution (should say "Database LoginDB created successfully")

**Step 4: Verify Database**
1. In Object Explorer (left panel), find "Databases"
2. Right-click "Databases" and click "Refresh"
3. Look for "LoginDB" in the list
4. Expand "LoginDB" → "Tables" → verify "Users" table exists

✅ Database is ready!

---

### Option B: Using Command Line (Advanced)

```powershell
# Open PowerShell as Administrator
# Navigate to project folder
cd "c:\Users\ShoukhathalikhanN\Downloads\Login page"

# Run SQL script
sqlcmd -S localhost -i database/CreateLoginDB.sql
```

---

## PART 2: BACKEND SETUP & RUN

### Step 1: Open Command Prompt / PowerShell

Press `Win + R`, type `cmd` or `powershell`, press Enter

### Step 2: Navigate to Backend Folder

```bash
cd "c:\Users\ShoukhathalikhanN\Downloads\Login page\backend\LoginAPI"
```

### Step 3: Install Dependencies (First Time Only)

```bash
dotnet restore
```

Wait for completion (2-3 minutes). You should see:
```
Restore completed in X.XX seconds
```

### Step 4: Start Backend Server

```bash
dotnet run
```

**Expected Output:**
```
info: Microsoft.Hosting.Lifetime[14]
      Now listening on: http://localhost:5000
      Now listening on: https://localhost:5001
Press CTRL+C to shut down.
```

**✅ Keep this terminal open and running!**

---

## PART 3: FRONTEND SETUP & RUN

### Step 1: Open NEW Command Prompt / PowerShell

Press `Win + R`, type `cmd` or `powershell`, press Enter

**Important: Do NOT close the backend terminal! Use a NEW terminal window.**

### Step 2: Navigate to Frontend Folder

```bash
cd "c:\Users\ShoukhathalikhanN\Downloads\Login page\frontend"
```

### Step 3: Install Dependencies (First Time Only)

```bash
npm install
```

Wait for completion (2-5 minutes). You should see:
```
added XXX packages
```

### Step 4: Start Frontend Server

```bash
npm start
```

**Or alternatively:**
```bash
ng serve
```

**Expected Output:**
```
✔ Compiled successfully.
Application bundle generated successfully.
```

**A browser window should automatically open with http://localhost:4200**

**✅ Keep this terminal open and running!**

---

## PART 4: TEST THE APPLICATION

### Test 1: Test Login

1. **Open browser**: http://localhost:4200
   - Should display login page with gradient background

2. **Enter Credentials**:
   - Email: `admin@example.com`
   - Password: `Admin@123`

3. **Click "Sign In"**

4. **Expected Result**:
   - Page redirects to dashboard
   - Displays "Welcome back, Admin User!"
   - Shows user information

✅ **Login successful!**

---

### Test 2: Test Registration

1. **Go back to login page**
   - URL: http://localhost:4200 or http://localhost:4200/login
   - Click "Sign up" button

2. **Fill Registration Form**:
   - Name: `Test User`
   - Email: `testuser@example.com`
   - Password: `Test@1234`
   - Confirm Password: `Test@1234`

3. **Click "Create Account"**

4. **Expected Result**:
   - Alert says "Registration successful! Please login."
   - Form clears and returns to login mode

5. **Login with New Account**:
   - Email: `testuser@example.com`
   - Password: `Test@1234`
   - Click "Sign In"

✅ **Registration successful!**

---

### Test 3: Test Protected Route

1. **Click "Logout"** on dashboard
   - Token is cleared from browser storage
   - Redirected to login page

2. **Try accessing dashboard directly**:
   - Go to: http://localhost:4200/dashboard
   - Should automatically redirect to login

✅ **Route protection working!**

---

## PART 5: TEST API ENDPOINTS (Optional)

### Using Swagger UI (Easiest)

1. **Open browser**: http://localhost:5000/swagger/index.html
   - Displays all API endpoints with documentation

2. **Test Login Endpoint**:
   - Find "POST /api/auth/login"
   - Click to expand
   - Click "Try it out"
   - Fill in:
     ```json
     {
       "email": "admin@example.com",
       "password": "Admin@123"
     }
     ```
   - Click "Execute"
   - Should return JWT token

3. **Test Register Endpoint**:
   - Find "POST /api/auth/register"
   - Click "Try it out"
   - Fill in:
     ```json
     {
       "name": "Another User",
       "email": "another@example.com",
       "password": "Password123"
     }
     ```
   - Click "Execute"
   - Should succeed

---

### Using Postman (For Advanced Testing)

1. **Download Postman**: https://www.postman.com/downloads/

2. **Create Login Request**:
   - Method: POST
   - URL: `http://localhost:5000/api/auth/login`
   - Body (raw, JSON):
     ```json
     {
       "email": "admin@example.com",
       "password": "Admin@123"
     }
     ```
   - Click Send
   - Copy the `token` from response

3. **Create Verify Request**:
   - Method: GET
   - URL: `http://localhost:5000/api/auth/verify`
   - Headers:
     - Key: `Authorization`
     - Value: `Bearer YOUR_TOKEN_HERE`
   - Click Send
   - Should return your email and "Token is valid"

---

## PART 6: VERIFY IN DATABASE

Open SSMS and verify data was saved:

```sql
USE LoginDB;
SELECT * FROM Users;
```

You should see:
- Original admin user
- Any new users you created during testing

---

## STOPPING THE APPLICATION

### To Stop Backend
- Go to backend terminal
- Press `Ctrl + C`
- Type `Y` and Enter if prompted
- Terminal will show: "Application stopped"

### To Stop Frontend
- Go to frontend terminal
- Press `Ctrl + C`
- Type `Y` and Enter if prompted
- Terminal will show: "Compilation will be disabled"

### To Restart
1. In each terminal, press up arrow to recall last command
2. Press Enter to execute
3. Wait for servers to start

---

## TROUBLESHOOTING DURING EXECUTION

### Backend won't start

**Error: "Address already in use"**
- Port 5000 is in use
- Solution:
  ```bash
  netstat -ano | findstr :5000
  taskkill /PID <number from output> /F
  ```
- Or run on different port by editing `Program.cs`

**Error: "Database connection failed"**
- SQL Server is not running or script wasn't executed
- Verify:
  1. Open Services (services.msc)
  2. Find "SQL Server"
  3. Right-click → Start
  4. Wait 30 seconds
  5. Try running backend again

### Frontend won't start

**Error: "npm: not found"**
- Node.js not installed
- Download and install from: https://nodejs.org/

**Error: "@angular/cli not found"**
```bash
npm install -g @angular/cli
ng serve
```

**Browser shows blank page**
- Clear browser cache: Ctrl+Shift+Delete
- Hard refresh: Ctrl+F5
- Check console (F12) for errors

### Login doesn't work

**Error: "Invalid credentials"**
- Wrong email/password
- Use: `admin@example.com` / `Admin@123`
- Or register new account first

**Error: "Cannot connect to server"**
- Backend not running
- Check backend terminal for errors
- Restart with: `dotnet run`

---

## QUICK REFERENCE COMMANDS

```bash
# Backend startup
cd backend/LoginAPI
dotnet restore      # First time only
dotnet run

# Frontend startup
cd frontend
npm install         # First time only
npm start
# OR
ng serve

# Database
# Open SSMS and run: database/CreateLoginDB.sql

# Find what's using port 5000
netstat -ano | findstr :5000

# Kill process on port 5000
taskkill /PID <PID> /F

# Stop servers
# Press Ctrl+C in each terminal

# Clear npm cache if having issues
npm cache clean --force
```

---

## NEXT TIME YOU RUN THE PROJECT

**Skip database setup (already created)**, go directly to:

```bash
# Terminal 1: Backend
cd backend/LoginAPI
dotnet run

# Terminal 2: Frontend
cd frontend
npm start
```

Then open http://localhost:4200 in browser.

---

## AFTER TESTING

You can close the terminals with `Ctrl+C`, but keep notes of:
- Any errors you see
- Features you want to add
- Customizations you want to make

Proceed to [README.md](./README.md) for detailed documentation on next steps.

---

**You're all set! Enjoy the application! 🚀**
