/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2020 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: ECC Data Sets
-- Description: Enterprise Command Centers data sets and load rules
-- Excel Examle Output: https://www.enginatics.com/example/ecc-data-sets/
-- Library Link: https://www.enginatics.com/reports/ecc-data-sets/
-- Run Report: https://demo.enginatics.com/

select
ess.system_name,
edb.dataset_key,
xxen_util.meaning(edb.enabled_flag,'YES_NO',0) enabled_flag,
edt.display_name,
edt.dataset_description,
edb.dataset_id,
xxen_util.meaning(edlr.load_type,'ECC_LOAD_TYPE_LKUP',0) load_type,
edlr.package_name||nvl2(edlr.procedure_name,'.'||edlr.procedure_name,null) procedure_name,
edlr.load_type_seq
from
ecc.ecc_source_system ess,
ecc.ecc_dataset_b edb,
ecc.ecc_dataset_tl edt,
ecc.ecc_dataset_load_rules edlr
where
1=1 and
ess.system_id=edb.system_id and
edb.dataset_id=edt.dataset_id and
edt.language='en' and
edt.dataset_id=edlr.dataset_id
order by
ess.system_name,
edb.dataset_key,
edlr.load_type