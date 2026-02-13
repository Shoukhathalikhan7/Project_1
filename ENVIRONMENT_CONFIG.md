# Environment Configuration

This file contains environment-specific configurations for the authentication system.

## Frontend Environment Setup

Create a new file: `frontend/src/environments/environment.ts`

```typescript
export const environment = {
  production: false,
  apiUrl: 'http://localhost:5000'
};
```

Create a new file: `frontend/src/environments/environment.prod.ts`

```typescript
export const environment = {
  production: true,
  apiUrl: 'https://your-api-domain.com'
};
```

## Backend Environment Setup

### Development Configuration (`appsettings.Development.json`)

```json
{
  "Logging": {
    "LogLevel": {
      "Default": "Information",
      "Microsoft.AspNetCore": "Warning"
    }
  },
  "ConnectionStrings": {
    "DefaultConnection": "Server=localhost;Database=LoginDB;Trusted_Connection=True;TrustServerCertificate=True;"
  }
}
```

### Production Configuration (`appsettings.json`)

Update these values for production:

```json
{
  "ConnectionStrings": {
    "DefaultConnection": "Server=YOUR_SERVER;Database=LoginDB;User Id=sa;Password=YourPassword;TrustServerCertificate=True;"
  },
  "Jwt": {
    "Key": "CHANGE_THIS_TO_A_VERY_LONG_SECRET_KEY_MIN_32_CHARACTERS",
    "Issuer": "YourIssuer",
    "Audience": "YourAudience",
    "ExpirationMinutes": 60
  },
  "Cors": {
    "AllowedOrigins": [
      "https://yourdomain.com",
      "https://www.yourdomain.com"
    ]
  }
}
```

## Port Configuration

- **Frontend**: http://localhost:4200
- **Backend**: http://localhost:5000
- **Database**: localhost (default SQL Server port 1433)

To change backend port, edit `Program.cs`:
```csharp
app.Run("http://localhost:YOUR_PORT");
```

## Connection String Formats

### Windows Authentication
```
Server=localhost;Database=LoginDB;Trusted_Connection=True;TrustServerCertificate=True;
```

### SQL Server Authentication
```
Server=localhost;Database=LoginDB;User Id=sa;Password=YourPassword;TrustServerCertificate=True;
```

### Remote Server
```
Server=SERVER_IP_OR_HOSTNAME;Database=LoginDB;User Id=sa;Password=YourPassword;TrustServerCertificate=True;
```

## Important Notes

- ⚠️ **Never commit `appsettings.json` with real passwords to version control**
- ⚠️ **Change the JWT Key to a secure value in production**
- ⚠️ **Use HTTPS in production**
- ⚠️ **Update CORS allowed origins for your production domain**
