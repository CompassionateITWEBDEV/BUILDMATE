# BUILDMATE API Documentation

This document describes the authentication API endpoints for the BUILDMATE application.

## Base URL
All API endpoints are prefixed with `/api/auth/`

## Authentication

The API uses JWT tokens for authentication. Include the token in the Authorization header:
```
Authorization: Bearer <your_jwt_token>
```

## Endpoints

### 1. User Registration

**POST** `/api/auth/register`

Register a new user account.

#### Request Body
```json
{
  "username": "string",
  "email": "string",
  "password": "string"
}
```

#### Validation Rules
- `username`: Required, string
- `email`: Required, valid email format
- `password`: Required, minimum 6 characters

#### Response

**Success (201)**
```json
{
  "success": true,
  "message": "User registered successfully",
  "user": {
    "id": "uuid",
    "email": "user@example.com",
    "username": "username",
    "user_type": "user",
    "created_at": "2024-01-01T00:00:00Z"
  }
}
```

**Error (400/409/500)**
```json
{
  "error": "Error message"
}
```

#### Error Codes
- `400`: Bad Request (missing fields, invalid email, weak password)
- `409`: Conflict (user already exists)
- `500`: Internal Server Error

---

### 2. User Login

**POST** `/api/auth/login`

Authenticate user and return JWT token.

#### Request Body
```json
{
  "email": "string",
  "password": "string"
}
```

#### Response

**Success (200)**
```json
{
  "success": true,
  "message": "Login successful",
  "user": {
    "id": "uuid",
    "email": "user@example.com",
    "username": "username",
    "user_type": "user",
    "created_at": "2024-01-01T00:00:00Z",
    "last_sign_in": "2024-01-01T00:00:00Z"
  },
  "session": {
    "access_token": "jwt_token",
    "refresh_token": "refresh_token",
    "expires_at": 1234567890
  }
}
```

**Error (400/401/500)**
```json
{
  "error": "Error message"
}
```

#### Error Codes
- `400`: Bad Request (missing fields, invalid email format)
- `401`: Unauthorized (invalid credentials)
- `500`: Internal Server Error

---

### 3. User Logout

**POST** `/api/auth/logout`

Logout user and invalidate session.

#### Headers
```
Authorization: Bearer <jwt_token>
```

#### Response

**Success (200)**
```json
{
  "success": true,
  "message": "Logout successful"
}
```

**Error (401/500)**
```json
{
  "error": "Error message"
}
```

#### Alternative: GET `/api/auth/logout`
Client-side logout without token validation.

---

### 4. Get Current User

**GET** `/api/auth/me`

Get current authenticated user's profile.

#### Headers
```
Authorization: Bearer <jwt_token>
```

#### Response

**Success (200)**
```json
{
  "success": true,
  "user": {
    "id": "uuid",
    "email": "user@example.com",
    "username": "username",
    "user_type": "user",
    "created_at": "2024-01-01T00:00:00Z",
    "last_sign_in": "2024-01-01T00:00:00Z",
    "email_confirmed": true
  }
}
```

**Error (401/500)**
```json
{
  "error": "Error message"
}
```

---

### 5. Update User Profile

**PUT** `/api/auth/profile`

Update user profile information.

#### Headers
```
Authorization: Bearer <jwt_token>
```

#### Request Body
```json
{
  "username": "string",
  "user_type": "user" // optional: "admin" | "user" | "moderator"
}
```

#### Response

**Success (200)**
```json
{
  "success": true,
  "message": "Profile updated successfully",
  "user": {
    "id": "uuid",
    "email": "user@example.com",
    "username": "new_username",
    "user_type": "user",
    "created_at": "2024-01-01T00:00:00Z",
    "last_sign_in": "2024-01-01T00:00:00Z"
  }
}
```

**Error (400/401/404/500)**
```json
{
  "error": "Error message"
}
```

#### Error Codes
- `400`: Bad Request (missing username, invalid user_type)
- `401`: Unauthorized (invalid token)
- `404`: Not Found (user profile not found)
- `500`: Internal Server Error

---

## Client-Side Usage

### Using the Auth API Service

```typescript
import { authAPI } from '@/lib/auth-api'

// Register a new user
try {
  const response = await authAPI.register('username', 'user@example.com', 'password123')
  console.log('User registered:', response.user)
} catch (error) {
  console.error('Registration failed:', error.message)
}

// Login
try {
  const response = await authAPI.login('user@example.com', 'password123')
  console.log('Login successful:', response.user)
  // Token is automatically stored in localStorage
} catch (error) {
  console.error('Login failed:', error.message)
}

// Get current user
const user = await authAPI.getCurrentUser()
if (user) {
  console.log('Current user:', user)
}

// Logout
await authAPI.logout()
```

### Using the Auth Context

```typescript
import { useAPIAuth } from '@/contexts/api-auth-context'

function MyComponent() {
  const { user, login, register, logout, isLoading, error } = useAPIAuth()
  
  const handleLogin = async () => {
    const success = await login('user@example.com', 'password123')
    if (success) {
      console.log('Login successful')
    }
  }
  
  return (
    <div>
      {user ? (
        <p>Welcome, {user.username}!</p>
      ) : (
        <button onClick={handleLogin}>Login</button>
      )}
    </div>
  )
}
```

## Security Features

1. **JWT Tokens**: Secure token-based authentication
2. **Password Hashing**: Passwords are hashed using Supabase Auth
3. **Input Validation**: All inputs are validated on both client and server
4. **Rate Limiting**: Built-in rate limiting (configured in Supabase)
5. **CORS Protection**: Proper CORS configuration
6. **SQL Injection Protection**: Using parameterized queries
7. **XSS Protection**: Input sanitization

## Error Handling

All API endpoints return consistent error responses:

```json
{
  "error": "Human-readable error message"
}
```

Common error scenarios:
- Invalid input data
- Authentication failures
- Database errors
- Network issues

## Rate Limiting

The API implements rate limiting to prevent abuse:
- Registration: 5 requests per minute per IP
- Login: 10 requests per minute per IP
- Other endpoints: 100 requests per minute per authenticated user

## Database Integration

The API integrates with Supabase for:
- User authentication
- User profile management
- Session management
- Data persistence

## Testing

You can test the API using tools like:
- Postman
- curl
- Thunder Client (VS Code extension)
- Built-in browser dev tools

### Example curl commands:

```bash
# Register
curl -X POST http://localhost:3000/api/auth/register \
  -H "Content-Type: application/json" \
  -d '{"username":"testuser","email":"test@example.com","password":"password123"}'

# Login
curl -X POST http://localhost:3000/api/auth/login \
  -H "Content-Type: application/json" \
  -d '{"email":"test@example.com","password":"password123"}'

# Get current user
curl -X GET http://localhost:3000/api/auth/me \
  -H "Authorization: Bearer YOUR_JWT_TOKEN"
```




