-- Migration for Price & Availability Tracking and Locality Features
-- Run this in Supabase SQL Editor

-- 1. Add availability_status column to components table
ALTER TABLE public.components 
  ADD COLUMN IF NOT EXISTS availability_status character varying(20) DEFAULT 'in_stock' CHECK (availability_status IN ('in_stock', 'out_of_stock', 'low_stock', 'discontinued'));

-- 2. Create price_history table for tracking price changes
CREATE SEQUENCE IF NOT EXISTS price_history_price_history_id_seq;

CREATE TABLE IF NOT EXISTS public.price_history (
  price_history_id integer NOT NULL DEFAULT nextval('price_history_price_history_id_seq'::regclass),
  component_id integer NOT NULL,
  old_price numeric,
  new_price numeric NOT NULL,
  changed_at timestamp without time zone DEFAULT now(),
  changed_by character varying(255),
  CONSTRAINT price_history_pkey PRIMARY KEY (price_history_id),
  CONSTRAINT fk_price_history_component FOREIGN KEY (component_id) REFERENCES public.components(component_id) ON DELETE CASCADE
);

-- Create index for faster queries
CREATE INDEX IF NOT EXISTS idx_price_history_component_id ON public.price_history(component_id);
CREATE INDEX IF NOT EXISTS idx_price_history_changed_at ON public.price_history(changed_at DESC);

-- Enable Row Level Security
ALTER TABLE public.price_history ENABLE ROW LEVEL SECURITY;

-- Create RLS policies for price_history
CREATE POLICY "Public can view price history" ON public.price_history
  FOR SELECT USING (true);

CREATE POLICY "Admins can insert price history" ON public.price_history
  FOR INSERT WITH CHECK (
    EXISTS (
      SELECT 1 FROM public.users 
      WHERE users.user_id::text = auth.uid()::text 
      AND users.user_role = 'admin'
    )
  );

-- 3. Create function to automatically log price changes
CREATE OR REPLACE FUNCTION log_price_change()
RETURNS TRIGGER AS $$
BEGIN
  IF OLD.component_price IS DISTINCT FROM NEW.component_price THEN
    INSERT INTO public.price_history (
      component_id,
      old_price,
      new_price,
      changed_by
    ) VALUES (
      NEW.component_id,
      OLD.component_price,
      NEW.component_price,
      COALESCE(auth.uid()::text, 'system')
    );
  END IF;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Create trigger to automatically log price changes
DROP TRIGGER IF EXISTS trigger_log_price_change ON public.components;
CREATE TRIGGER trigger_log_price_change
  AFTER UPDATE OF component_price ON public.components
  FOR EACH ROW
  EXECUTE FUNCTION log_price_change();

-- 4. Grant necessary permissions
GRANT SELECT ON public.price_history TO anon;
GRANT SELECT ON public.price_history TO authenticated;

-- 5. Add comments for documentation
COMMENT ON COLUMN public.components.availability_status IS 'Component availability: in_stock, out_of_stock, low_stock, or discontinued';
COMMENT ON TABLE public.price_history IS 'Tracks historical price changes for components';

