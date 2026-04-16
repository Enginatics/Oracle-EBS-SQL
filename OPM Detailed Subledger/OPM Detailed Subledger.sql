/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: OPM Detailed Subledger
-- Description: OPM Financials Detailed Subledger Report showing transaction headers, extract lines with debit/credit amounts, and GL account distributions. Based on Oracle standard report GMFDSUR (Detailed Subledger Report).
-- Excel Examle Output: https://www.enginatics.com/example/opm-detailed-subledger/
-- Library Link: https://www.enginatics.com/reports/opm-detailed-subledger/
-- Run Report: https://demo.enginatics.com/

select
gsrv.reference_no,
xep.name legal_entity,
gl.name ledger,
gsrv.base_currency,
gsrv.valuation_cost_type cost_type,
gss.fiscal_year,
gss.period,
(select glp.period_name from gl_periods glp where glp.period_set_name=gl.period_set_name and glp.period_type=gl.accounted_period_type and glp.period_year=gss.fiscal_year and glp.period_num=gss.period) period_name,
mp.organization_code,
haou.name organization,
(select xetv.name from xla_entity_types_vl xetv where xetv.application_id=555 and xetv.entity_code=gsrv.entity_code) entity_type,
(select xecv.name from xla_event_classes_vl xecv where xecv.application_id=555 and xecv.entity_code=gsrv.entity_code and xecv.event_class_code=gsrv.event_class) event_class,
(select xetyv.name from xla_event_types_vl xetyv where xetyv.application_id=555 and xetyv.entity_code=gsrv.entity_code and xetyv.event_class_code=gsrv.event_class and xetyv.event_type_code=gsrv.event_type) event_type,
gsrv.transaction_id,
gsrv.transaction_date,
msibk.concatenated_segments item,
msibk.description item_description,
gsrv.item_revision,
gsrv.transaction_quantity,
gsrv.transaction_uom,
gxel.journal_line_type,
gxel.component_cost,
decode(sign(gxel.base_amount),1,gxel.base_amount,0,0) base_dr_amount,
decode(sign(gxel.base_amount),-1,abs(gxel.base_amount),0,0) base_cr_amount,
decode(sign(gxel.trans_amount),1,gxel.trans_amount,0,0) trans_dr_amount,
decode(sign(gxel.trans_amount),-1,abs(gxel.trans_amount),0,0) trans_cr_amount,
gxel.entered_amount,
gxel.accounted_amount,
gcck.concatenated_segments account,
gl_flexfields_pkg.get_concat_description(gcck.chart_of_accounts_id,gcck.code_combination_id,'N') account_description,
gsrv.in_subinventory_code subinventory,
gsrv.in_transfer_subinventory transfer_subinventory,
gsrv.pm_batch_number batch_number,
gsrv.pm_batch_status batch_status,
gsrv.pm_actual_start_date batch_actual_start_date,
gsrv.pm_actual_cmplt_date batch_actual_completion_date,
gsrv.pm_formula_no formula,
nullif(gsrv.pm_formula_vers,-1) formula_version,
gsrv.pm_routing_no routing,
nullif(gsrv.pm_routing_vers,-1) routing_version,
gsrv.pm_recipe_no recipe,
nullif(gsrv.pm_recipe_version,-1) recipe_version,
gsrv.pm_resources resources,
gsrv.po_purchase_number purchase_order,
gsrv.po_supplier_name supplier,
gsrv.po_receipt_number receipt_number,
nullif(gsrv.po_receipt_line_number,-1) receipt_line_number,
nullif(gsrv.om_order_number,-1) order_number,
gsrv.om_customer_name customer,
nullif(gsrv.om_line_number,-1) om_line_number,
gsrv.om_shipment_number shipment_number,
gsrv.cm_adjustment_type,
gsrv.cm_adjust_cost,
gsrv.cm_reason_code,
gsrv.cm_period_code,
gsrv.cm_calendar_code,
gsrv.cm_lot_number
from
gmf_subledger_rep_v gsrv,
gl_subr_sta gss,
gmf_xla_extract_lines gxel,
xla_distribution_links xdl,
xla_ae_lines xal,
gl_code_combinations_kfv gcck,
xle_entity_profiles xep,
gl_ledgers gl,
mtl_parameters mp,
hr_all_organization_units haou,
mtl_system_items_b_kfv msibk
where
gsrv.reference_no=gss.reference_no and
gsrv.header_id=gxel.header_id and
gsrv.event_id=xdl.event_id(+) and
xdl.application_id(+)=555 and
gsrv.entity_code=xdl.source_distribution_type(+) and
gxel.line_id=xdl.source_distribution_id_num_1(+) and
xdl.ae_header_id=xal.ae_header_id(+) and
xdl.ae_line_num=xal.ae_line_num(+) and
xal.ledger_id(+)=gsrv.ledger_id and
xal.code_combination_id=gcck.code_combination_id(+) and
gsrv.legal_entity_id=xep.legal_entity_id(+) and
gsrv.ledger_id=gl.ledger_id(+) and
gsrv.organization_id=mp.organization_id(+) and
gsrv.organization_id=haou.organization_id(+) and
gsrv.inventory_item_id=msibk.inventory_item_id(+) and
gsrv.organization_id=msibk.organization_id(+) and
(:include_zero_amount_lines='Y' or abs(gxel.base_amount)>=0.005 or abs(gxel.trans_amount)>=0.005) and
1=1
order by
gsrv.entity_code,
mp.organization_code,
gsrv.transaction_id,
gxel.line_number,
gxel.cost_cmpntcls_id,
gxel.cost_analysis_code