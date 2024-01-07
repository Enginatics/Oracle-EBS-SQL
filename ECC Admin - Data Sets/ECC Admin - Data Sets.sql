/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: ECC Admin - Data Sets
-- Description: Enterprise Command Centers applications with data sets and load rule DB procedure names for incremental, full and metadata load.
For description of the load process, see ECC Concurrent Programs <a href="https://www.enginatics.com/reports/ecc-concurrent-programs/" rel="nofollow" target="_blank">https://www.enginatics.com/reports/ecc-concurrent-programs/</a>
-- Excel Examle Output: https://www.enginatics.com/example/ecc-admin-data-sets/
-- Library Link: https://www.enginatics.com/reports/ecc-admin-data-sets/
-- Run Report: https://demo.enginatics.com/

select
ess.system_name,
(
select distinct
listagg(eat.application_name,', ') within group (order by eat.application_name) over (partition by eadr.dataset_id) application 
from
ecc.ecc_app_ds_relationships eadr,
ecc.ecc_application_tl eat
where
edb.dataset_id=eadr.dataset_id and
eadr.app_ds_rel_type='OWNED' and
eadr.application_id=eat.application_id and
eat.language=xxen_util.bcp47_language(userenv('lang'))
) application,
edt.display_name data_set,
edb.dataset_key data_set_key,
decode(edt.dataset_description,'null',null,edt.dataset_description) description,
xxen_util.meaning(decode(edb.enabled_flag,'Y','Y'),'YES_NO',0) enabled,
x.*,
esr.security_handler_name
from
ecc.ecc_source_system ess,
ecc.ecc_dataset_b edb,
ecc.ecc_dataset_tl edt,
(
select
edlr.dataset_id,
xxen_util.meaning(edlr.load_type,'ECC_LOAD_TYPE_LKUP',0) load_type,
edlr.package_name||nvl2(edlr.procedure_name,'.'||edlr.procedure_name,null) procedure_name
from
ecc.ecc_dataset_load_rules edlr
)
pivot (
max(procedure_name) proc
for
load_type in (
'Incremental data load' incremental_load,
'Full data load' full_load,
'Metadata load' metadata_load
)
) x,
ecc.ecc_security_rules esr
where
1=1 and
ess.system_id=edb.system_id and
edb.dataset_id=edt.dataset_id and
edt.language=xxen_util.bcp47_language(userenv('lang')) and
edt.dataset_id=x.dataset_id(+) and
edb.dataset_id=esr.applies_to_entity(+) and
esr.applies_to_type(+)='DATASET'
order by
ess.system_name,
edb.dataset_key