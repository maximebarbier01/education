create table IDF_all as (
select
	*
from public.eff_ips_all
where region_academique = 'ILE-DE-FRANCE'
)