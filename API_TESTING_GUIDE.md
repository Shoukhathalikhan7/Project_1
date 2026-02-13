# API Testing Guide

Complete guide to test the Login API using Postman, cURL, or browser.

## API Base URL

```
http://localhost:5000
```

---

## Authentication Endpoints

### 1. User Registration

**Endpoint:** `POST /api/auth/register`

**Request:**
```bash
curl -X POST http://localhost:5000/api/auth/register \
  -H "Content-Type: application/json" \
  -d '{
    "name": "John Doe",
    "email": "john@example.com",
    "password": "Password123"
  }'
```

**Postman:**
- Method: `POST`
- URL: `http://localhost:5000/api/auth/register`
- Body (raw JSON):
```json
{
  "name": "John Doe",
  "email": "john@example.com",
  "password": "Password123"
}
```

**Success Response (200):**
```json
{
  "success": true,
  "message": "Registration successful. Please login.",
  "data": null
}
```

**Error Response (400):**
```json
{
  "success": false,
  "message": "Email already registered",
  "data": null
}
```

---

### 2. User Login

**Endpoint:** `POST /api/auth/login`

**Request:**
```bash
curl -X POST http://localhost:5000/api/auth/login \
  -H "Content-Type: application/json" \
  -d '{
    "email": "admin@example.com",
    "password": "Admin@123"
  }'
```

**Postman:**
- Method: `POST`
- URL: `http://localhost:5000/api/auth/login`
- Body (raw JSON):
```json
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
  "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxIiwiZW1haWwiOiJhZG1pbkBleGFtcGxlLmNvbSIsIm5hbWUiOiJBZG1pbiBVc2VyIiwibmJmIjoxNzM4NTcxMjAwLCJleHAiOjE3Mzg1NzQ4MDAsImlhdCI6MTczODU3MTIwMH0.xxxXXXxxxXXXxxx"
}
```

**Error Response (401):**
```json
"Invalid email or password"
```

---

### 3. Verify Token

**Endpoint:** `GET /api/auth/verify`

**Request:**
```bash
curl -X GET http://localhost:5000/api/auth/verify \
  -H "Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9..."
```

**Postman:**
1. Method: `GET`
2. URL: `http://localhost:5000/api/auth/verify`
3. Headers: Add
   - Key: `Authorization`
   - Value: `Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyMywiZW1haWwiOiJ1c2VyQGV4YW1wbGUuY29tIiwiaWF0IjoxNzcwODAwMTIzLCJleHAiOjE3NzA4MDM3MjN9.N0IvivD5Pnwq4VasDmMa4l6SJ7XiO40IdNWO_sQiWzM`
4. Click Send

**Success Response (200):**
```json
{
  "email": "admin@example.com",
  "message": "Token is valid"
}
```

**Error Response (401):**
```
Unauthorized
```

---

## Testing Workflow

### 1. Register New User

1. Use the Register endpoint above
2. Provide unique email
3. Store response (should say registration successful)

### 2. Login with New User

1. Use the Login endpoint
2. Provide same email and password
3. **Copy the returned token** from response

### 3. Verify Token Works

1. Use Verify Token endpoint
2. Paste token in Authorization header
3. Should display your email

---

## Postman Collection

Create a Postman collection for easy testing:

1. Open Postman
2. Click **New** → **Request**
3. Create 3 requests:

**Request 1: Register**
- Name: Register
- Method: POST
- URL: {{base_url}}/api/auth/register
- Body:
```json
{
  "name": "Test User {{$timestamp}}",
  "email": "test{{$timestamp}}@example.com",
  "password": "Test@123456"
}
```

**Request 2: Login**
- Name: Login
- Method: POST
- URL: {{base_url}}/api/auth/login
- Body:
```json
{
  "email": "admin@example.com",
  "password": "Admin@123"
}
```
- Tests tab (save token):
```javascript
var jsonData = pm.response.json();
pm.environment.set("jwt_token", jsonData.token);
```

**Request 3: Verify**
- Name: Verify Token
- Method: GET
- URL: {{base_url}}/api/auth/verify
- Headers:
```
Authorization: Bearer {{jwt_token}}
```

### Set Environment Variable

In Postman:
1. Click gear icon → Environments
2. Create new environment: "Login API"
3. Add variable:
   - Key: `base_url`
   - Value: `http://localhost:5000`

---

## JavaScript/Fetch Examples

### Register in JavaScript

```javascript
async function register() {
  const response = await fetch('http://localhost:5000/api/auth/register', {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({
      name: 'John Doe',
      email: 'john@example.com',
      password: 'Password123'
    })
  });
  
  const data = await response.json();
  console.log(data);
}
```

### Login in JavaScript

```javascript
async function login() {
  const response = await fetch('http://localhost:5000/api/auth/login', {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({
      email: 'admin@example.com',
      password: 'Admin@123'
    })
  });
  
  const data = await response.json();
  localStorage.setItem('token', data.token);
  console.log('Token saved:', data.token);
}
```

### Verify Token in JavaScript

```javascript
async function verifyToken() {
  const token = localStorage.getItem('token');
  const response = await fetch('http://localhost:5000/api/auth/verify', {
    method: 'GET',
    headers: {
      'Authorization': `Bearer ${token}`
    }
  });
  
  const data = await response.json();
  console.log(data);
}
```

---

## Test Credentials

### Sample User (Pre-created)
- Email: `admin@example.com`
- Password: `Admin@123`

### Create Your Own

Use the Register endpoint to create new test users.

---

## Swagger UI

View and test API directly in browser:

**URL:** `http://localhost:5000/swagger/index.html`

Features:
- See all endpoints
- View request/response schemas
- Try endpoints directly
- Copy cURL commands

---

## Common Errors

### 400 Bad Request
- Check JSON format is valid
- Verify all required fields present
- Check field types (email should be string, not number)

### 401 Unauthorized
- Check email and password are correct
- Verify token is not expired
- Include "Bearer " prefix in authorization header

### 404 Not Found
- Verify endpoint URL is correct
- Check backend is running on correct port
- Verify API version in URL

### 500 Internal Server Error
- Check backend logs for errors
- Verify database connection
- Check if SQL Server is running

---

## Load Testing

Simple load test with Apache Bench:

```bash
# Login 100 times
ab -n 100 -c 10 -p data.json -T application/json http://localhost:5000/api/auth/login
```

File `data.json`:
```json
{"email":"admin@example.com","password":"Admin@123"}
```

---

## Debugging Tips

1. **Check backend logs** - Terminal running `dotnet run`
2. **Use browser DevTools** - F12 → Network tab
3. **Check CORS errors** - Browser console shows CORS issues
4. **Verify database** - Run SELECT queries in SSMS
5. **Check token expiry** - Decode JWT at jwt.io

---

## Next Steps

- Automate tests with Jest
- Set up CI/CD pipeline
- Load test the API
- Add more endpoints
- Implement refresh tokens
