with sub as (
	select 
		region_academique as region
--		,denominaton_principale
		,count(distinct uai) as nb_etablissements
		,sum(nombre_eleves) as nb_eleves
	from public.eff_total
	where rentree_scolaire = 2020
	group by region_academique
	order by nb_eleves DESC
)
select
	*
	,round(nb_eleves / nb_etablissements,2) as ratio
from sub
order by ratio DESC