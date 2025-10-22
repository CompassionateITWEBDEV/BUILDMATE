# Database Setup - Complete Instructions

## ✅ Current Status
- ✅ **Correct API keys configured**
- ✅ **Users table created**
- ❌ **Other tables need to be created**

## 🔧 Next Steps

### Step 1: Create Remaining Database Tables

1. **Go to your Supabase Dashboard**: https://supabase.com/dashboard
2. **Select your project**: `sldiqjjgddegffbzjqma.supabase.co`
3. **Navigate to SQL Editor** (in the left sidebar)
4. **Copy and paste the following SQL** and click "Run":

```sql
-- Create sequences (if not already created)
CREATE SEQUENCE IF NOT EXISTS build_types_build_type_id_seq;
CREATE SEQUENCE IF NOT EXISTS builds_build_id_seq;
CREATE SEQUENCE IF NOT EXISTS component_categories_category_id_seq;
CREATE SEQUENCE IF NOT EXISTS components_component_id_seq;
CREATE SEQUENCE IF NOT EXISTS retailers_retailer_id_seq;
CREATE SEQUENCE IF NOT EXISTS build_components_build_component_id_seq;
CREATE SEQUENCE IF NOT EXISTS build_history_bhistory_id_seq;
CREATE SEQUENCE IF NOT EXISTS comments_comment_id_seq;

-- Create build_types table
CREATE TABLE IF NOT EXISTS public.build_types (
  build_type_id integer NOT NULL DEFAULT nextval('build_types_build_type_id_seq'::regclass),
  type_name character varying NOT NULL,
  description text,
  CONSTRAINT build_types_pkey PRIMARY KEY (build_type_id)
);

-- Create component_categories table
CREATE TABLE IF NOT EXISTS public.component_categories (
  category_id integer NOT NULL DEFAULT nextval('component_categories_category_id_seq'::regclass),
  category_name character varying NOT NULL,
  description text,
  CONSTRAINT component_categories_pkey PRIMARY KEY (category_id)
);

-- Create retailers table
CREATE TABLE IF NOT EXISTS public.retailers (
  retailer_id integer NOT NULL DEFAULT nextval('retailers_retailer_id_seq'::regclass),
  retailer_name character varying NOT NULL,
  email character varying,
  website text,
  retailer_address text,
  retailer_phone character varying,
  retailer_contact_person character varying,
  CONSTRAINT retailers_pkey PRIMARY KEY (retailer_id)
);

-- Create components table
CREATE TABLE IF NOT EXISTS public.components (
  component_id integer NOT NULL DEFAULT nextval('components_component_id_seq'::regclass),
  component_name character varying NOT NULL,
  component_price numeric,
  compatibility_information text,
  category_id integer NOT NULL,
  retailer_id integer,
  CONSTRAINT components_pkey PRIMARY KEY (component_id),
  CONSTRAINT fk_component_category FOREIGN KEY (category_id) REFERENCES public.component_categories(category_id),
  CONSTRAINT fk_component_retailer FOREIGN KEY (retailer_id) REFERENCES public.retailers(retailer_id)
);

-- Create builds table
CREATE TABLE IF NOT EXISTS public.builds (
  build_id integer NOT NULL DEFAULT nextval('builds_build_id_seq'::regclass),
  user_id integer NOT NULL,
  build_type_id integer NOT NULL,
  build_name character varying NOT NULL,
  date_created timestamp without time zone DEFAULT now(),
  CONSTRAINT builds_pkey PRIMARY KEY (build_id),
  CONSTRAINT fk_build_user FOREIGN KEY (user_id) REFERENCES public.users(user_id),
  CONSTRAINT fk_build_type FOREIGN KEY (build_type_id) REFERENCES public.build_types(build_type_id)
);

-- Create build_components table
CREATE TABLE IF NOT EXISTS public.build_components (
  build_component_id integer NOT NULL DEFAULT nextval('build_components_build_component_id_seq'::regclass),
  build_id integer NOT NULL,
  component_id integer NOT NULL,
  CONSTRAINT build_components_pkey PRIMARY KEY (build_component_id),
  CONSTRAINT fk_build_component_build FOREIGN KEY (build_id) REFERENCES public.builds(build_id),
  CONSTRAINT fk_build_component_component FOREIGN KEY (component_id) REFERENCES public.components(component_id)
);

-- Create build_history table
CREATE TABLE IF NOT EXISTS public.build_history (
  bhistory_id integer NOT NULL DEFAULT nextval('build_history_bhistory_id_seq'::regclass),
  build_id integer NOT NULL,
  change_description text,
  changed_at timestamp without time zone DEFAULT now(),
  CONSTRAINT build_history_pkey PRIMARY KEY (bhistory_id),
  CONSTRAINT fk_build_history_build FOREIGN KEY (build_id) REFERENCES public.builds(build_id)
);

-- Create comments table
CREATE TABLE IF NOT EXISTS public.comments (
  comment_id integer NOT NULL DEFAULT nextval('comments_comment_id_seq'::regclass),
  bhistory_id integer NOT NULL,
  user_id integer NOT NULL,
  comment_text text NOT NULL,
  commented_at timestamp without time zone DEFAULT now(),
  CONSTRAINT comments_pkey PRIMARY KEY (comment_id),
  CONSTRAINT fk_comment_history FOREIGN KEY (bhistory_id) REFERENCES public.build_history(bhistory_id),
  CONSTRAINT fk_comment_user FOREIGN KEY (user_id) REFERENCES public.users(user_id)
);
```

### Step 2: Test Authentication

After creating the tables:

1. **Go to** `http://localhost:3000/register`
2. **Create a new account** with your email and password
3. **Login** with those credentials
4. **You should be redirected to the dashboard**

## 🎯 Expected Result

- ✅ **No more "Invalid API key" errors**
- ✅ **Registration works** and creates user in database
- ✅ **Login works** and authenticates against database
- ✅ **Dashboard loads** with user data from database
- ✅ **All data stored** in your Supabase database

## Current Status
- ✅ **API keys configured correctly**
- ✅ **Server running with correct configuration**
- ❌ **Need to create remaining database tables**
- ❌ **Ready to test authentication once tables are created**

