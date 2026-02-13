🚀 Login System Project

A full-stack login & registration system built with:

Frontend: Angular 17

Backend: ASP.NET Core 8 Web API

Database: SQL Server

Authentication: JWT

✨ Features

User Registration & Login

JWT Authentication

Password Hashing (SHA256)

Protected Dashboard

Responsive UI

Email validation & duplicate checking

🛠 Tech Stack
Layer	Technology
Frontend	Angular 17, TypeScript
Backend	ASP.NET Core 8
Database	SQL Server
Auth	JWT
⚡ Quick Setup
1️⃣ Database

Open SQL Server Management Studio

Run: database/CreateLoginDB.sql

Update connection string in:

backend/LoginAPI/appsettings.json


Example:

"DefaultConnection": "Server=localhost;Database=LoginDB;Trusted_Connection=True;TrustServerCertificate=True;"

2️⃣ Run Backend
cd backend/LoginAPI
dotnet restore
dotnet run


Backend runs at:

http://localhost:5000


Swagger:

http://localhost:5000/swagger

3️⃣ Run Frontend
cd frontend
npm install
npm start


Frontend runs at:

http://localhost:4200

🔐 Test Login
Email: admin@example.com
Password: Admin@123

📁 Project Structure
Login-page/
 ├── frontend/       # Angular App
 ├── backend/        # ASP.NET Core API
 ├── database/       # SQL Scripts
 └── README.md

🔑 API Endpoints
Method	Endpoint
POST	/api/auth/login
POST	/api/auth/register
GET	/api/auth/verify
🧪 Production Build
Frontend
npm run build

Backend
dotnet publish -c Release

📌 Notes

JWT expires in 60 minutes

CORS restricted to Angular app

