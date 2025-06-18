-- A - verifier le nom de ligne perdu

-- 1 - column nb_eleves 

select sum(nb_eleves) from public.eff_ips_all; -- 13 554 219

select sum(nombre_eleves) from public.eff_total where rentree_scolaire between '2019-01-01' and '2021-01-01'; -- 13 554 219

--> pas de perte 

-- 2 - column ips

select count(ips) from public.eff_ips_all; -- 29 459

select count(ips) from public.ips_all where rentree_scolaire between '2019-01-01' and '2021-01-01'; -- 31 700 

--> 8% de perte 

-- 3 - columns uai

select count(distinct uai) from public.eff_ips_all; -- 30 073 // 10452 (distinct)
select count(distinct uai) from public.ips_all where rentree_scolaire between '2019-01-01' and '2021-01-01'; -- 31 700 // (10618)

--> 0,05% de perte

