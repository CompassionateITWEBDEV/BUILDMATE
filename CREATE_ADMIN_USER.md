# How to Create Admin User

Para makapag-login sa admin dashboard, kailangan mo ng user account na may `user_type = 'admin'`.

## Method 1: Via Supabase Dashboard (Recommended)

1. **Go to Supabase Dashboard**
   - Open: https://supabase.com/dashboard
   - Select your project

2. **Go to Table Editor**
   - Click "Table Editor" sa left sidebar
   - Select `users` table

3. **Update Existing User to Admin**
   - Find your user account
   - Click on the row to edit
   - Change `user_type` from `'user'` to `'admin'`
   - Click "Save"

4. **Or Create New Admin User**
   - Click "Insert row"
   - Fill in:
     - `user_name`: Your desired username
     - `email`: Your email address
     - `password`: (will be hashed by Supabase Auth)
     - `user_type`: `'admin'`
   - Click "Save"

## Method 2: Via SQL Editor

1. **Go to SQL Editor** sa Supabase Dashboard

2. **Run this SQL** (replace with your email):
```sql
-- Update existing user to admin
UPDATE public.users 
SET user_type = 'admin' 
WHERE email = 'your-email@gmail.com';

-- Or create new admin user (you'll need to create auth user first)
-- First create in Supabase Auth, then:
INSERT INTO public.users (user_name, email, password, user_type)
VALUES ('Admin User', 'admin@buildmate.com', 'hashed_password_here', 'admin');
```

## Method 3: Via Registration + Database Update

1. **Register normally** sa `/register` page
2. **Go to Supabase Dashboard** → Table Editor → `users` table
3. **Find your new user** and change `user_type` to `'admin'`

## After Creating Admin User

1. **Logout** from current session (if logged in)
2. **Login** with your admin account
3. **Navigate to** `/admin` - you should now have access!

## Admin Credentials Example

**Email:** `admin@buildmate.com`  
**Password:** (your chosen password)  
**User Type:** `admin`

## Verification

After setting `user_type = 'admin'`:
- ✅ You can access `/admin` page
- ✅ You'll see "Admin Dashboard" link in navigation menu
- ✅ You can manage users, builds, components, and view purchases

---

**Note:** Make sure to keep your admin credentials secure!

