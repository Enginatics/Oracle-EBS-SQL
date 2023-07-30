/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2023 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: INV Organization Parameters
-- Description: None
-- Excel Examle Output: https://www.enginatics.com/example/inv-organization-parameters/
-- Library Link: https://www.enginatics.com/reports/inv-organization-parameters/
-- Run Report: https://demo.enginatics.com/

select
gl.name ledger,
hou.name operating_unit,
mpv.organization_code,
haouv.name organization_name,
haouv.date_to disable_date,
ftv.territory_short_name country,
nvl2(hla.address_line_1,hla.address_line_1||' ','')||
nvl2(hla.address_line_2,hla.address_line_2||' ','')||
nvl2(hla.address_line_3,hla.address_line_3||' ','')||
nvl2(hla.town_or_city,hla.town_or_city||' ','')||
nvl2(hla.region_2,hla.region_2||' ','')||
hla.postal_code address,
mpv.master_org master_organization,
mpv.calendar_code,
mpv.def_demand_dummy demand_class,
mpv.txn_approval_timeout_period move_order_timeout_period,
xxen_util.meaning(mpv.mo_approval_timeout_action,'TXN_APPROVAL_TIMEOUT_ACTION',700) move_order_timeout_action,
xxen_util.meaning(mpv.stock_locator_control_code,'MTL_LOCATION_CONTROL',700) locator_control,
(select mmsv.status_code from mtl_material_statuses_vl mmsv where mpv.default_status_id=mmsv.status_id) default_onhand_material_status,
xxen_util.meaning(decode(mpv.enforce_locator_alis_unq_flag,'Y','Y'),'YES_NO',0) enforce_locator_alias_unique,
xxen_util.meaning(decode(mpv.qa_skipping_insp_flag,'Y','Y'),'YES_NO',0) quality_skip_inspect_control,
xxen_util.meaning(decode(mpv.negative_inv_receipt_code,1,1),'SYS_YES_NO',700) allow_negative_balances,
xxen_util.meaning(decode(mpv.auto_del_alloc_flag,'Y','Y'),'YES_NO',0) auto_delete_allocations,
xxen_util.meaning(decode(mpv.trading_partner_org_flag,'Y','Y'),'YES_NO',0) manufacturing_partner_org,
mpv.trading_partner_org_type manufacturing_partner_org_type,
xxen_util.meaning(decode(mpv.eam_enabled_flag,'Y','Y'),'YES_NO',0) eam_enabled,
xxen_util.meaning(decode(mpv.wms_enabled_flag,'Y','Y'),'YES_NO',0) wms_enabled,
xxen_util.meaning(decode(mpv.wcs_enabled,'Y','Y'),'YES_NO',0) wcs_enabled,
xxen_util.meaning(decode(mpv.lcm_enabled_flag,'Y','Y'),'YES_NO',0) lcm_enabled,
xxen_util.meaning(decode(mpv.process_enabled_flag,'Y','Y'),'YES_NO',0) process_manufacturing_enabled,
mpv.process_orgn_code,
ood2.organization_code eam_organization_code,
ood2.organization_name eam_organization_name,
mpv.org_max_weight max_load_weight,
mpv.org_max_weight_uom_code max_weight_uom_code,
mpv.org_max_volume max_volume,
mpv.org_max_volume_uom_code max_volume_uom_code,
(select haouv.name from hr_all_organization_units_vl haouv where mpv.cost_organization_id=haouv.organization_id) costing_organization,
mpv.primary_cost_dummy costing_method,
(select cct.cost_type from cst_cost_types cct where mpv.avg_rates_cost_type_id=cct.cost_type_id) rates_cost_type,
xxen_util.meaning(decode(mpv.general_ledger_update_code,1,1),'SYS_YES_NO',700) transfer_to_gl,
xxen_util.meaning(decode(mpv.encumbrance_reversal_flag,1,1),'SYS_YES_NO',700) reverse_encumbrance,
xxen_util.meaning(decode(mpv.pm_cost_collection_enabled,1,1),'SYS_YES_NO',700) project_cost_collect_enabled,
xxen_util.meaning(decode(mpv.defer_logical_transactions,1,1),'SYS_YES_NO',700) defer_logical_transactions,
mpv.cost_cutoff_date,
mpv.default_material_sub default_material_subelement,
(select br.resource_code from bom_resources br where mpv.default_matl_ovhd_cost_id=br.resource_id) material_overhead_subelement,
(select ccg.cost_group from cst_cost_groups ccg where mpv.default_cost_group_id=ccg.cost_group_id) default_cost_group,
xxen_util.concatenated_segments(mpv.material_account) material_account,
xxen_util.segments_description(mpv.material_account) material_account_description,
xxen_util.concatenated_segments(mpv.outside_processing_account) outside_processing_account,
xxen_util.segments_description(mpv.outside_processing_account) outside_processing_accnt_desc,
xxen_util.concatenated_segments(mpv.material_overhead_account) material_overhead_account,
xxen_util.segments_description(mpv.material_overhead_account) material_overhead_account_desc,
xxen_util.concatenated_segments(mpv.overhead_account) overhead_account,
xxen_util.segments_description(mpv.overhead_account) overhead_account_description,
xxen_util.concatenated_segments(mpv.resource_account) resource_account,
xxen_util.segments_description(mpv.resource_account) resource_account_description,
xxen_util.concatenated_segments(mpv.expense_account) expense_account,
xxen_util.segments_description(mpv.expense_account) expense_account_description,
mpv.starting_revision,
decode(mpv.lot_number_uniqueness,1,'Across items','None') lot_number_uniqueness,
xxen_util.meaning(mpv.lot_number_generation,'MTL_LOT_GENERATION',700) lot_number_generation,
xxen_util.meaning(decode(mpv.lot_number_zero_padding,1,1),'SYS_YES_NO',700) lot_number_zero_padding,
mpv.auto_lot_alpha_prefix lot_number_prefix,
mpv.lot_number_length,
xxen_util.meaning(mpv.allocate_lot_flag,'YES_NO',0) allocate_lot,
xxen_util.meaning(mpv.parent_child_generation_flag,'INV_PARENT_CHILD_GENERATION',0) child_lot_generation, 
xxen_util.meaning(decode(mpv.child_lot_zero_padding_flag,'Y','Y'),'YES_NO',0) child_lot_zero_padding,
mpv.child_lot_alpha_prefix child_lot_prefix,
mpv.child_lot_number_length child_lot_length,
xxen_util.meaning(decode(mpv.child_lot_validation_flag,'Y','Y'),'YES_NO',0) child_lot_format_validation,
xxen_util.meaning(decode(mpv.copy_lot_attribute_flag,'Y','Y'),'YES_NO',0) copy_child_lot_attributes,
xxen_util.user_name(mpv.created_by) created_by,
xxen_util.client_time(mpv.creation_date) creation_date,
xxen_util.user_name(mpv.last_updated_by) last_updated_by,
xxen_util.client_time(mpv.last_update_date) last_update_date
from
mtl_parameters_view mpv,
hr_all_organization_units_vl haouv,
org_organization_definitions ood,
gl_ledgers gl,
hr_operating_units hou,
hr_locations_all hla,
fnd_territories_vl ftv,
org_organization_definitions ood2
where
1=1 and
mpv.organization_id=ood.organization_id(+) and
mpv.organization_id=haouv.organization_id and
ood.set_of_books_id=gl.ledger_id(+) and
ood.operating_unit=hou.organization_id(+) and
haouv.location_id=hla.location_id(+) and
hla.country=ftv.territory_code(+) and
mpv.maint_organization_id=ood2.organization_id(+)
order by
gl.name,
hou.name,
mpv.organization_code