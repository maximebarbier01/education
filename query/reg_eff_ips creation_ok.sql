-- by region - ajout du ratio - nb_eleve_par_etablissement

-- Création de la table reg_eff_ips

create table reg_eff_ips as (
select
	region_academique
	,departement
	,count(uai) as nb_etablissements
	,sum(nb_eleves) as nb_eleves
	,round(avg(rep)*100, 2) as rep_percentage
	,round(avg(ips), 2) as avg_ips
	,round(sum(nb_eleves) / count( distinct uai),0) as nb_eleve_par_etablissement
from public.eff_ips_all
group by
	region_academique
	,departement
order by region_academique
)