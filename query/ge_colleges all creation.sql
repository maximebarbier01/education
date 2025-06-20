-- Création de la table College Grand Est ALL

-- 0 - Transformation de rentree_scolaire en date type
ALTER TABLE public.eff_colleges 
ADD COLUMN rentree_scolaire_date date;

UPDATE public.eff_colleges
SET rentree_scolaire_date = make_date(rentree_scolaire, 1, 1);

ALTER TABLE public.eff_colleges DROP COLUMN rentree_scolaire;
ALTER TABLE public.eff_colleges RENAME COLUMN rentree_scolaire_date TO rentree_scolaire;

SELECT * FROM public.eff_colleges;

-- 1 - Jointure de effectif et IPS
-- table effectif - Grand Est
create table GE_colleges_all as (
with eff as (
	select 
		uai
		,departement
		,academie
		,commune
		,denomination_principale
		,secteur
		,nombre_d_eleves_total as nb_eleves
		,rep
		,rep_plus
		,rentree_scolaire
	from public.eff_colleges
	where true 
		and region_academique = 'GRAND EST'
		and rentree_scolaire between '2019-01-01' and '2021-01-01'
), ips as (
	select
		uai
		,rentree_scolaire
		,ips
	from public.ips_colleges
	where true 
		and rentree_scolaire between '2019-01-01' and '2021-01-01'
), eff_ips as (
	select 
		e.uai
		,e.rentree_scolaire
		,e.academie
		,e.departement
		,e.commune
		,e.denomination_principale
		,e.secteur
		,e.nb_eleves 
		,e.rep
		,e.rep_plus
		,i.ips
	from eff as e
	inner join ips as i
		on(i.uai = e.uai and i.rentree_scolaire = e.rentree_scolaire)
), ind as (
	select
		uai
		,annee - INTERVAL '1 year' as rentree_scolaire
		,nb_candidats_g
		,taux_de_reussite_g
		,va_du_taux_de_reussite_g
		,note_a_lecrit_g
		,va_de_la_note_g
		,taux_dacces_6eme_3eme
		,part_presents_3eme_ordinaire_total
		,round(nb_mentions_ab_g::NUMERIC / nb_candidats_g * 100, 2) as part_mention_ab_g
		,round(nb_mentions_b_g::NUMERIC / nb_candidats_g * 100, 2) as part_mention_b_g
		,round(nb_mentions_tb_g::NUMERIC / nb_candidats_g * 100, 2) as part_mention_tb_g
		,round(nb_mentions_global_g::NUMERIC / nb_candidats_g * 100, 2) as part_mention_global_g
	from public.ind_colleges
)
select 
	e.*
	,i.nb_candidats_g
	,i.taux_de_reussite_g
	,i.va_du_taux_de_reussite_g
	,i.note_a_lecrit_g
	,i.va_de_la_note_g
	,i.taux_dacces_6eme_3eme
	,i.part_presents_3eme_ordinaire_total
	,i.part_mention_ab_g
	,i.part_mention_b_g
	,i.part_mention_tb_g
	,i.part_mention_global_g
from eff_ips as e
inner join ind as i
	on(i.uai = e.uai and i.rentree_scolaire = e.rentree_scolaire)
order by e.rentree_scolaire
)