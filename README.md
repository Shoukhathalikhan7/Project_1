# Login System Project - Complete Setup Guide

A complete login page system with **Angular Frontend**, **C# ASP.NET Core Backend**, and **SQL Server Database**.

## 📋 Project Overview

This project implements a modern login/registration system with:
- **Attractive UI** with gradient design and smooth animations
- **User authentication** with JWT tokens
- **Secure password** hashing (SHA256)
- **Email validation** and duplicate checking
- **Responsive design** that works on mobile and desktop
- **Dashboard** for logged-in users

### Technology Stack

| Layer | Technology |
|-------|-----------|
| Frontend | Angular 17, TypeScript, SCSS |
| Backend | ASP.NET Core 8, Entity Framework Core |
| Database | SQL Server 2019+ |
| Authentication | JWT (JSON Web Tokens) |

---

## 🚀 Quick Start (5 Minutes)

### Prerequisites
- SQL Server (Express or Full edition)
- .NET 8 SDK
- Node.js 18+ and npm
- VS Code or Visual Studio

### 1. Database Setup (5 min)

**Step 1a: Open SQL Server Management Studio (SSMS)**
- Connect to your local server
- Click `File` → `New` → `Query with Current Connection`

**Step 1b: Run Database Script**
- Open: `database/CreateLoginDB.sql`
- Copy all content into SSMS Query window
- Press `F5` to execute

**Expected Result:** You should see "Database LoginDB created successfully" message

---

### 2. Backend Setup (2 min)

```bash
# Navigate to backend folder
cd backend/LoginAPI

# Restore dependencies
dotnet restore

# Run the backend
dotnet run
```

**Expected Output:**
```
info: Microsoft.Hosting.Lifetime[14]
      Now listening on: http://localhost:5000
      Now listening on: https://localhost:5001
```

---

### 3. Frontend Setup (2 min)

```bash
# Open new terminal/command prompt
cd frontend

# Install dependencies
npm install

# Start development server
npm start
```

**Expected Output:**
```
✔ Compiled successfully.
Application bundle generated successfully
```

---

### 4. Access the Application

- **Frontend**: Open browser → http://localhost:4200
- **Backend API**: http://localhost:5000/swagger/index.html
- **Test Login**: 
  - Email: `admin@example.com`
  - Password: `Admin@123` (use sample user from database script)

---

## 📁 Project Structure

```
Login page/
├── frontend/                          # Angular Application
│   ├── src/
│   │   ├── app/
│   │   │   ├── login/               # Login component
│   │   │   ├── dashboard/           # Dashboard component
│   │   │   ├── services/            # HTTP services
│   │   │   └── app.routes.ts        # Routing configuration
│   │   ├── styles.scss              # Global styles
│   │   └── main.ts                  # Bootstrap
│   ├── package.json                 # Dependencies
│   └── angular.json                 # Angular config
│
├── backend/
│   └── LoginAPI/                     # ASP.NET Core API
│       ├── Controllers/              # API endpoints
│       ├── Services/                 # Business logic
│       ├── Models/                   # Data models
│       ├── Data/                     # DbContext
│       ├── appsettings.json          # Configuration
│       └── Program.cs                # Startup config
│
├── database/
│   ├── CreateLoginDB.sql             # Database creation script
│   ├── SSMS_CONNECTION_GUIDE.md      # Detailed SSMS guide
│   └── Maintenance.sql               # Maintenance queries
│
└── README.md                         # This file
```

---

## 💾 Database Setup - Detailed Guide

### Using SSMS Connection Guide

For complete step-by-step instructions on connecting to SSMS and creating the database, see:
**[SSMS Connection Guide](./database/SSMS_CONNECTION_GUIDE.md)**

This guide includes:
- ✅ Installing SSMS
- ✅ Connecting to SQL Server
- ✅ Creating databases
- ✅ Running SQL scripts
- ✅ Troubleshooting connection issues
- ✅ Verifying database setup

### Quick Database Connection String

Update the connection string in `backend/LoginAPI/appsettings.json`:

```json
"ConnectionStrings": {
    "DefaultConnection": "Server=localhost;Database=LoginDB;Trusted_Connection=True;TrustServerCertificate=True;"
}
```

For SQL Server Express:
```json
"DefaultConnection": "Server=.\\SQLEXPRESS;Database=LoginDB;Trusted_Connection=True;TrustServerCertificate=True;"
```

---

## 🎯 API Endpoints

### Authentication Endpoints

#### Login
```
POST http://localhost:5000/api/auth/login
Content-Type: application/json

{
  "email": "admin@example.com",
  "password": "Admin@123"
}
```

**Success Response (200):**
```json
{
  "id": 1,
  "name": "Admin User",
  "email": "admin@example.com",
  "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9..."
}
```

---

#### Register
```
POST http://localhost:5000/api/auth/register
Content-Type: application/json

{
  "name": "John Doe",
  "email": "john@example.com",
  "password": "password123"
}
```

**Success Response (200):**
```json
{
  "success": true,
  "message": "Registration successful. Please login."
}
```

---

#### Verify Token
```
GET http://localhost:5000/api/auth/verify
Authorization: Bearer <JWT_TOKEN>
```

---

## 🔐 Security Features

- **Password Hashing**: SHA256 with no salt (production requires bcrypt/PBKDF2)
- **JWT Tokens**: 60-minute expiration
- **CORS**: Restricted to Angular app origin
- **Email Validation**: Format checking and uniqueness enforcement
- **Input Validation**: Server-side validation on all endpoints

---

## 🎨 Frontend Features

### Login Page
- Clean, modern UI with gradient background
- Email and password validation
- "Remember me" checkbox
- "Forgot password" link
- Toggle between login and registration

### Registration Page
- Full name input
- Email validation
- Password confirmation
- Error messaging

### Dashboard
- Welcome message with user name
- Display user information
- Logout functionality
- Protected route (redirects to login if not authenticated)

---

## ⚙️ Configuration Files

### Backend Configuration (`appsettings.json`)

```json
{
  "ConnectionStrings": {
    "DefaultConnection": "Server=localhost;Database=LoginDB;..."
  },
  "Jwt": {
    "Key": "YourSuperSecretKeyThatIsAtLeast32CharactersLong!@#$",
    "Issuer": "LoginAPI",
    "Audience": "LoginClient",
    "ExpirationMinutes": 60
  },
  "Cors": {
    "AllowedOrigins": ["http://localhost:4200"]
  }
}
```

### Frontend Configuration (`environment.ts`)

Located in `frontend/src/environments/`:

```typescript
export const environment = {
  production: false,
  apiUrl: 'http://localhost:5000'
};
```

---

## 🧪 Testing the Application

### 1. Test Login Flow
1. Go to http://localhost:4200
2. Click "Sign In"
3. Use credentials:
   - Email: `admin@example.com`
   - Password: `Admin@123`
4. Should redirect to dashboard

### 2. Test Registration
1. Click "Sign up"
2. Enter name, email, and password
3. Confirm password
4. Click "Create Account"
5. Message confirms registration
6. Login with new account

### 3. Test Protected Route
1. Without logging in, try directly accessing http://localhost:4200/dashboard
2. Should redirect to login page

### 4. Test API with Postman
- Open Postman
- Create POST request to `http://localhost:5000/api/auth/login`
- Enter test credentials
- Should receive JWT token

---

## 📝 Database Schema

### Users Table
```sql
CREATE TABLE Users (
    Id INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(256) NOT NULL,
    Email NVARCHAR(256) NOT NULL UNIQUE,
    PasswordHash NVARCHAR(MAX) NOT NULL,
    CreatedAt DATETIME2 NOT NULL DEFAULT GETUTCDATE(),
    LastLogin DATETIME2 NULL,
    IsActive BIT NOT NULL DEFAULT 1
)
```

**Columns:**
- `Id`: Unique identifier
- `Name`: User's full name
- `Email`: Email address (unique)
- `PasswordHash`: SHA256 hashed password
- `CreatedAt`: Account creation timestamp
- `LastLogin`: Last login timestamp
- `IsActive`: Account status

---

## 🚨 Troubleshooting

### Frontend Issues

**Issue: "Cannot connect to server" in browser**
- Check backend is running: `dotnet run`
- Verify CORS settings in `appsettings.json`
- Check frontend API URL matches backend URL

**Issue: Blank page on http://localhost:4200**
- Run `npm install` again
- Clear browser cache (Ctrl+Shift+Delete)
- Check console for errors: F12 → Console tab

### Backend Issues

**Issue: "Database connection failed"**
- Verify SQL Server is running
- Check connection string in `appsettings.json`
- Run database script in SSMS
- Check firewall settings

**Issue: "Cannot find MSSQL instance"**
- SQL Server service not running
- Open Services (services.msc)
- Find and start "SQL Server" service
- Wait 30 seconds and try again

**Issue: "Port 5000 already in use"**
```bash
# Find and kill process using port 5000
netstat -ano | findstr :5000
taskkill /PID <PID> /F

# Or use different port in Program.cs
```

### Database Issues

**Issue: Database not created**
- See [SSMS_CONNECTION_GUIDE.md](./database/SSMS_CONNECTION_GUIDE.md) sections on database creation
- Verify SQL Server authentication is enabled
- Check file permissions for database folder

**Issue: "Login failed for user 'sa'"**
- Use Windows Authentication instead
- Or reset SA password in SSMS

---

## 📚 Additional Resources

- [Angular Documentation](https://angular.io/docs)
- [ASP.NET Core Documentation](https://learn.microsoft.com/en-us/dotnet/core/)
- [SQL Server Documentation](https://learn.microsoft.com/en-us/sql/)
- [JWT Introduction](https://jwt.io/)
- [Entity Framework Core](https://learn.microsoft.com/en-us/ef/core/)

---

## 🔄 Development Workflow

### Making Changes to Frontend

1. Edit files in `frontend/src/`
2. Changes auto-reload at http://localhost:4200
3. Rebuild: `ng build`

### Making Changes to Backend

1. Edit files in `backend/LoginAPI/`
2. Restart: `Ctrl+C` then `dotnet run`
3. Or use watch mode: `dotnet watch run`

### Database Changes

1. Update models in `Models/` folder
2. Create migration: `dotnet ef migrations add DescriptionOfChange`
3. Apply migration: `dotnet ef database update`

---

## 📦 Building for Production

### Frontend Build
```bash
cd frontend
npm run build
# Output: dist/login-frontend/
```

### Backend Build
```bash
cd backend/LoginAPI
dotnet publish -c Release
# Output: bin/Release/net8.0/publish/
```

---

## 📞 Support

For detailed SSMS setup and database connection instructions, refer to:
**`database/SSMS_CONNECTION_GUIDE.md`**

This comprehensive guide covers:
- Installing SSMS
- Connecting to SQL Server
- Creating and managing databases
- Running SQL scripts
- Troubleshooting connection issues

---

## 📄 License

This project is provided as-is for educational purposes.

---

**Happy Coding! 🎉**
