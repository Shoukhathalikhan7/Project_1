# Login System Backend - ASP.NET Core

## Project Structure
- **Models/**: Contains data models (User, Dtos)
- **Data/**: Contains DbContext and database configuration
- **Services/**: Contains business logic (AuthService)
- **Controllers/**: Contains API endpoints

## Setup Instructions

### 1. Prerequisites
- .NET 8 SDK or later
- SQL Server (any edition)
- Visual Studio or VS Code with C# extension

### 2. Database Setup (See SSMS Connection Guide Below)
First, create the database in SQL Server before running migrations.

### 3. Install Dependencies
```bash
cd backend\LoginAPI
dotnet restore
```

### 4. Update Connection String
Edit `appsettings.json` and update the `DefaultConnection` if your SQL Server setup is different:
```json
"ConnectionStrings": {
    "DefaultConnection": "Server=YOUR_SERVER_NAME;Database=LoginDB;Trusted_Connection=True;TrustServerCertificate=True;"
}
```

### 5. Create Database and Apply Migrations
```bash
dotnet ef migrations add InitialCreate
dotnet ef database update
```

### 6. Run the Backend
```bash
dotnet run
```
The API will run on: `http://localhost:5000`

## API Endpoints

### POST /api/auth/login
Login a user
```json
{
    "email": "user@example.com",
    "password": "password123"
}
```

### POST /api/auth/register
Register a new user
```json
{
    "name": "John Doe",
    "email": "john@example.com",
    "password": "password123"
}
```

### GET /api/auth/verify
Verify JWT token (requires authentication)

## Configuration Files
- `appsettings.json`: Production configuration
- `appsettings.Development.json`: Development configuration
- `LoginAPI.csproj`: Project dependencies
