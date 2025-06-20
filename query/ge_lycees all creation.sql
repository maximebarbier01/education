-- Création de la table LYCEES Grand Est ALL

-- 0 - Transformation de rentree_scolaire en date type
ALTER TABLE public.eff_lycees 
ADD COLUMN rentree_scolaire_date date;

UPDATE public.eff_lycees
SET rentree_scolaire_date = make_date(rentree_scolaire, 1, 1);

ALTER TABLE public.eff_lycees DROP COLUMN rentree_scolaire;
ALTER TABLE public.eff_lycees RENAME COLUMN rentree_scolaire_date TO rentree_scolaire;

SELECT * FROM public.eff_lycees;

-- 1 - Jointure de effectif et IPS
-- table effectif - Grand Est
create table GE_lycees_all as (
with eff as (
	select 
		uai
		,rentree_scolaire
		,departement
		,academie
		,commune
		,denomination_principale
		,secteur
		,nombre_d_eleves as nb_eleves
	from public.eff_lycees
	where true 
		and region_academique = 'GRAND EST'
		and rentree_scolaire between '2019-01-01' and '2021-01-01'
), ips as (
	select
		uai
		,rentree_scolaire
		,ips_voie_gt
		,ips_voie_pro
		,ips_ensemble_gt_pro
	from public.ips_lycees
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
		,i.ips_voie_gt
		,i.ips_voie_pro
		,i.ips_ensemble_gt_pro
	from eff as e
	inner join ips as i
		on(i.uai = e.uai and i.rentree_scolaire = e.rentree_scolaire)
), ind as (
	select 
		uai
		,annee - INTERVAL '1 year' as rentree_scolaire
		,taux_de_reussite
		,va_taux_de_reussite
		,taux_de_mentions
		,va_du_taux_de_mentions
		,effectif_de_2de
		,effectif_de_1re
		,effectif_de_ter
		,taux_dacces_2nde_bac
		,va_taux_dacces_2nde_bac
		,taux_dacces_1re_bac
		,va_du_taux_dacces_1re_bac
		,taux_dacces_term_bac
		,va_du_taux_dacces_term_bac
		-- part mentions
    	,round((nb_mentions_ab / effectif_de_ter * 100), 2) as part_mention_ab
    	,round((nb_mentions_b / effectif_de_ter * 100), 2) as part_mention_b
    	,round((nb_mentions_tb_sans_felicitations / effectif_de_ter * 100), 2) as part_mention_tb_sf
    	,round((nb_mentions_tb_sans_felicitations / effectif_de_ter * 100), 2) as part_mention_tb_af
	from public.ind_lycees
)
select 
	e.*
	,i.taux_de_reussite
	,i.va_taux_de_reussite
	,i.taux_de_mentions
	,i.va_du_taux_de_mentions
	,i.effectif_de_2de
	,i.effectif_de_1re
	,i.effectif_de_ter
	,i.taux_dacces_2nde_bac
	,i.va_taux_dacces_2nde_bac
	,i.taux_dacces_1re_bac
	,i.va_du_taux_dacces_1re_bac
	,i.taux_dacces_term_bac
	,i.va_du_taux_dacces_term_bac
	,i.part_mention_ab
	,i.part_mention_b
	,i.part_mention_tb_sf
	,i.part_mention_tb_af
from eff_ips as e
inner join ind as i
	on(i.uai = e.uai and i.rentree_scolaire = e.rentree_scolaire)
order by e.rentree_scolaire
)