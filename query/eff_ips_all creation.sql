-- 1 - join eff and ips 

-- eff - rentree_scolaire : de 2019 à 2023
-- ips - rentree_scolaire : de 2016 à 2021

--select
--rentree_scolaire
--from eff_total
--group by rentree_scolaire;

-- 1.1 jointure de 2019-01-01 à 2021-01-01

create table eff_ips_all as (
with eff as (
	select
		uai
		,rentree_scolaire
		,region_academique
		,academie
		,departement
		,commune
		,denomination_principale
		,secteur
		,nombre_eleves as nb_eleves
		,rep
	from public.eff_total
	where rentree_scolaire between '2019-01-01' and '2021-01-01'
), ips as 
(
	select 
		*
	from public.ips_all
	where rentree_scolaire between '2019-01-01' and '2021-01-01'
)
select 
	e.uai
	,e.rentree_scolaire
	,e.region_academique
	,e.academie
	,e.departement
	,e.commune
	,e.denomination_principale
	,e.secteur
	,e.nb_eleves 
	,e.rep
	,i.ips
from eff as e
left join ips as i
	on(i.uai = e.uai and i.rentree_scolaire = e.rentree_scolaire)
order by e.rentree_scolaire
)
