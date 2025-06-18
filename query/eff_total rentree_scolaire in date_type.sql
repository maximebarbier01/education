-- Transformation de rentree_scolaire en date type

ALTER TABLE public.eff_total 
ADD COLUMN rentree_scolaire_date date;

UPDATE public.eff_total
SET rentree_scolaire_date = make_date(rentree_scolaire, 1, 1);

ALTER TABLE public.eff_total DROP COLUMN rentree_scolaire;
ALTER TABLE public.eff_total RENAME COLUMN rentree_scolaire_date TO rentree_scolaire;

select * from public.eff_total

