/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2023 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: ECC Admin - Metadata Attributes
-- Description: Enterprise Command Centers metadata attributes
-- Excel Examle Output: https://www.enginatics.com/example/ecc-admin-metadata-attributes/
-- Library Link: https://www.enginatics.com/reports/ecc-admin-metadata-attributes/
-- Run Report: https://demo.enginatics.com/

select
(
select distinct
listagg(eat.application_name,', ') within group (order by eat.application_name) over (partition by eadr.dataset_id) application 
from
ecc.ecc_app_ds_relationships eadr,
ecc.ecc_application_tl eat
where
edb.dataset_id=eadr.dataset_id and
eadr.application_id=eat.application_id and
eat.language=xxen_util.bcp47_language(userenv('lang'))
) application,
edb.dataset_key data_set_key,
edt.display_name data_set,
edab.attribute_key,
initcap(edab.attr_source_datatype) source_data_type,
edab.attr_profile_key profile,
edat.display_name,
edat.custom_display_name,
xxen_util.meaning(decode(edab.text_searchable_flag,'Y','Y'),'YES_NO',0) text_searchable,
xxen_util.meaning(decode(edab.dim_enable_refinements_flag,'Y','Y'),'YES_NO',0) refinable,
xxen_util.meaning(decode(edab.translation_flag,'Y','Y'),'YES_NO',0) translatable,
edab.select_type_code refinement_behavior,
edab.ranking_type_code refinement_order,
xxen_util.meaning(decode(edab.show_in_guided_discovery_flag,'Y','Y'),'YES_NO',0) show_in_guided_discovery,
xxen_util.meaning(decode(edab.show_record_counts_flag,'Y','Y'),'YES_NO',0) show_record_count,
edat.default_value
from
ecc.ecc_dataset_b edb,
ecc.ecc_dataset_tl edt,
ecc.ecc_dataset_attrs_b edab,
ecc.ecc_dataset_attrs_tl edat
where
1=1 and
edb.dataset_id=edt.dataset_id and
edt.language=xxen_util.bcp47_language(userenv('lang')) and
edb.dataset_id=edab.dataset_id and
edab.attribute_id=edat.attribute_id and
edat.language=xxen_util.bcp47_language(userenv('lang'))
order by
edab.attribute_id