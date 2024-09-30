/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: CST Periodic Inventory Value
-- Description: Imported from BI Publisher
Description: Periodic Inventory Value Report
Application: Bills of Material
Source: Periodic Inventory Value Report (XML)
Short Name: CSTRPICR_XML
DB package: BOM_CSTRPICR_XMLP_PKG
-- Excel Examle Output: https://www.enginatics.com/example/cst-periodic-inventory-value/
-- Library Link: https://www.enginatics.com/reports/cst-periodic-inventory-value/
-- Run Report: https://demo.enginatics.com/

with
q_ic_main as
(
select
 cpic.cost_group_id,
 cpic.pac_period_id period_id,
 decode(:p_sort_option,2 , mc.concatenated_segments,msi.concatenated_segments) ic_order,
 ccg.cost_group cost_group,
 msi.inventory_item_id ic_item_id_p,
 mc.padded_concatenated_segments ic_cat_pseg,
 msi.padded_concatenated_segments ic_item_pseg,
 mc.concatenated_segments ic_category_segment,
 msi.concatenated_segments ic_item_segment,
 msi.description ic_description,
 msi.primary_uom_code ic_uom,
 round(nvl(cpic.total_layer_quantity,0),:p_qty_precision) ic_qty,
 round((nvl(cpic.item_cost,0)* :p_exchange_rate),:p_ext_prec) ic_unit_cost,
 round((nvl(cpic.item_cost,0)* :p_exchange_rate),:p_precision) ic_stdunit_cost,
 nvl(cpic.item_cost,0)*nvl(cpic.total_layer_quantity,0)*:p_exchange_rate ic_total_cost,
 round((nvl(cpic.material_cost,0)* :p_exchange_rate),:p_ext_prec) ic_matl_cost,
 round((nvl(cpic.material_overhead_cost,0)* :p_exchange_rate),:p_ext_prec) ic_mo_cost,
 round((nvl(cpic.resource_cost,0)* :p_exchange_rate),:p_ext_prec) ic_res_cost,
 round((nvl(cpic.overhead_cost,0)* :p_exchange_rate),:p_ext_prec) ic_ovhd_cost,
 round((nvl(cpic.outside_processing_cost,0)* :p_exchange_rate),:p_ext_prec) ic_osp_cost,
 nvl(cpic.material_cost,0)*nvl(cpic.total_layer_quantity,0)*:p_exchange_rate ic_tot_matl_cost,
 nvl(cpic.material_overhead_cost,0)*nvl(cpic.total_layer_quantity,0)*:p_exchange_rate ic_tot_mo_cost,
 nvl(cpic.resource_cost,0)*nvl(cpic.total_layer_quantity,0)*:p_exchange_rate ic_tot_res_cost,
 nvl(cpic.overhead_cost,0)*nvl(cpic.total_layer_quantity,0)*:p_exchange_rate ic_tot_ovhd_cost,
 nvl(cpic.outside_processing_cost,0)*nvl(cpic.total_layer_quantity,0)*:p_exchange_rate ic_tot_osp_cost,
 1 ic_count,
 bom_cstrpicr_xmlp_pkg.ic_total_cost_rformula(nvl(cpic.item_cost,0) * nvl(cpic.total_layer_quantity,0) * :p_exchange_rate) ic_total_cost_r,
 bom_cstrpicr_xmlp_pkg.ic_res_cost_rformula(round((nvl(cpic.resource_cost,0) * :p_exchange_rate) , :p_ext_prec)) ic_res_cost_r,
 bom_cstrpicr_xmlp_pkg.ic_osp_cost_rformula(round((nvl(cpic.outside_processing_cost,0) * :p_exchange_rate),:p_ext_prec)) ic_osp_cost_r,
 bom_cstrpicr_xmlp_pkg.ic_ovhd_cost_rformula(round((nvl(cpic.overhead_cost,0) * :p_exchange_rate),:p_ext_prec)) ic_ovhd_cost_r,
 bom_cstrpicr_xmlp_pkg.ic_tot_osp_cost_rformula(nvl(cpic.outside_processing_cost,0) * nvl(cpic.total_layer_quantity,0) * :p_exchange_rate) ic_tot_osp_cost_r,
 bom_cstrpicr_xmlp_pkg.ic_tot_ovhd_cost_rformula(nvl(cpic.overhead_cost,0) * nvl(cpic.total_layer_quantity,0) * :p_exchange_rate) ic_tot_ovhd_cost_r,
 bom_cstrpicr_xmlp_pkg.ic_matl_cost_rformula(round((nvl(cpic.material_cost,0) * :p_exchange_rate ), :p_ext_prec)) ic_matl_cost_r,
 bom_cstrpicr_xmlp_pkg.ic_tot_res_cost_rformula(nvl(cpic.resource_cost,0) * nvl(cpic.total_layer_quantity,0) * :p_exchange_rate) ic_tot_res_cost_r,
 bom_cstrpicr_xmlp_pkg.ic_mo_cost_rformula(round((nvl( cpic.material_overhead_cost,0) * :p_exchange_rate ),:p_ext_prec)) ic_mo_cost_r,
 bom_cstrpicr_xmlp_pkg.ic_tot_matl_cost_rformula(nvl(cpic.material_cost,0) * nvl(cpic.total_layer_quantity,0) * :p_exchange_rate) ic_tot_matl_cost_r,
 bom_cstrpicr_xmlp_pkg.ic_tot_mo_cost_rformula(nvl(cpic.material_overhead_cost,0) * nvl(cpic.total_layer_quantity,0) * :p_exchange_rate) ic_tot_mo_cost_r
from
 mtl_item_categories mic,
 mtl_categories_kfv mc,
 mtl_system_items_vl msi,
 cst_pac_item_costs cpic,
 cst_cost_groups ccg
where
 1=1 and
 cpic.pac_period_id = :p_period_id and
 cpic.inventory_item_id = mic.inventory_item_id and
 mic.organization_id = :p_item_master_org_id and
 mic.category_set_id = :p_category_set and
 mc.category_id = mic.category_id and
 msi.inventory_item_id = mic.inventory_item_id and
 msi.organization_id = mic.organization_id and
 cpic.cost_group_id = ccg.cost_group_id
),
q_ic_rcv as
(
select
 cprvv.cost_group_id,
 cpp.pac_period_id period_id,
 cprvv.rcv_transaction_id ic_txn_id,
 cpp.pac_period_id ic_pac_period,
 cpp.cost_type_id ic_cost_type,
 cpp.period_start_date ic_start_date,
 cpp.period_end_date ic_end_date,
 msi.segment1 ic_item_num,
 mic.category_id ic_category,
 cprvv.receipt_date ic_receipt_date,
 cprvv.receipt_num ic_receipt_num,
 cprvv.shipment_num ic_shipment_num,
 hr.location_code ic_current_location,
 hr2.location_code ic_deliver_to_location,
 cprvv.packing_slip ic_packing_slip,
 pol.displayed_field ic_document_type,
 cprvv.source_document ic_document_number,
 cprvv.document_line_num ic_document_line_num,
 cstppacq.get_net_undel_qty(cprvv.rcv_transaction_id, (cpp.period_end_date + 1 )) ic_quantity,
 cprvv.acquisition_cost ic_acquisition_cost,
 cstppacq.get_net_undel_qty(cprvv.rcv_transaction_id, (cpp.period_end_date +1)) *cprvv.acquisition_cost ic_value,
 cprvv.txn_unit_of_measure ic_uom_code,
 cprvv.item_revision ic_revision,
 cprvv.item_description ic_description,
 msi.inventory_item_id ic_item_id_c,
 bom_cstrpicr_xmlp_pkg.ic_value_rformula(cstppacq.get_net_undel_qty ( cprvv.rcv_transaction_id , ( cpp.period_end_date + 1 ) ) * cprvv.acquisition_cost) ic_value_r,
 bom_cstrpicr_xmlp_pkg.ic_acquisition_cost_rformula(cprvv.acquisition_cost) ic_acquisition_cost_r
from
 cst_pac_receiving_values_v cprvv,
 mtl_system_items msi,
 mtl_item_categories mic,
 mtl_categories mc,
 hr_locations hr,
 hr_locations hr2,
 po_lookup_codes pol,
 cst_pac_periods cpp,
 po_vendors pov
where
 2=2 and
 cprvv.location_id = hr.location_id (+) and
 cprvv.deliver_to_location_id = hr2.location_id (+) and
 mic.organization_id(+) = cprvv.txn_organization_id and
 mic.inventory_item_id(+) = cprvv.item_id and
 mc.category_id(+) = mic.category_id and
 pol.lookup_type = 'DOCUMENT TYPE' and
 pol.lookup_code = cprvv.source_document_code and
 pov.vendor_id(+) = cprvv.vendor_id and
 cpp.legal_entity = cprvv.legal_entity and
 cprvv.transaction_date >= cpp.period_start_date and
 cprvv.transaction_date < (cpp.period_end_date + 1 ) and
 msi.inventory_item_id = cprvv.item_id and
 msi.organization_id = cprvv.txn_organization_id and
 cpp.pac_period_id = :p_period_id and
 mic.category_set_id = :p_category_set
)
--
-- Main Query Starts Here
--
select
 :p_legal_entity legal_entity,
 :p_cost_type cost_type,
 :p_period_name period,
 :p_currency_dsp currency,
 :p_exchange_rate exchange_rate,
 x.cost_group org_cost_group,
 x.item,
 x.description,
 x.category,
 x.uom,
 case when x.row_num = 1 then x.onhand_quantity end onhand_quantity,
 case when x.row_num = 1 then x.onhand_unit_cost end onhand_unit_cost,
 case when x.row_num = 1 then x.onhand_value end onhand_value,
 case when x.row_num = 1 then x.rcv_quantity end rcv_quantity,
 case when x.row_num = 1 then x.rcv_avg_acquisition_cost end rcv_avg_acquisition_cost,
 case when x.row_num = 1 then x.rcv_value end rcv_value,
 case when x.row_num = 1 then x.total_value end total_value,
 --
 case when x.row_num = 1 then x.material_cost end material_cost,
 case when x.row_num = 1 then x.material_value end material_value,
 case when x.row_num = 1 then x.material_overhead_cost end material_overhead_cost,
 case when x.row_num = 1 then x.material_overhead_value end material_overhead_value,
 case when x.row_num = 1 then x.resource_cost end resource_cost,
 case when x.row_num = 1 then x.resource_value end resource_value,
 case when x.row_num = 1 then x.outside_processing_cost end outside_processing_cost,
 case when x.row_num = 1 then x.outside_processing_value end outside_processing_value,
 case when x.row_num = 1 then x.overhead_cost end overhead_cost,
 case when x.row_num = 1 then x.overhead_value end overhead_value,
 case when x.row_num = 1 then x.cost_elements_total_cost end cost_elements_total_cost,
 case when x.row_num = 1 then x.cost_elements_total_value end cost_elements_total_value,
 --q_ic_rcv.*
 x.receipt_date,
 x.receipt_number,
 x.shipment_number,
 x.current_location,
 x.deliver_to_location,
 x.packing_slip,
 x.document_type,
 x.document_number,
 x.document_line_number,
 x.receipt_qty,
 x.acquisition_cost,
 x.value,
 --
 x.ic_txn_id,
 x.item_id,
 x.row_num item_seq
from
(
select /*+ push_pred(q_ic_rcv) */
 --q_ic_main.*,
 q_ic_main.cost_group cost_group,
 q_ic_main.ic_item_segment item,
 q_ic_main.ic_description description,
 q_ic_main.ic_category_segment category,
 q_ic_main.ic_uom uom,
 q_ic_main.ic_qty onhand_quantity,
 q_ic_main.ic_stdunit_cost onhand_unit_cost,
 q_ic_main.ic_total_cost_r onhand_value,
 sum(q_ic_rcv.ic_quantity) over (partition by q_ic_main.ic_item_id_p) rcv_quantity,
 avg(q_ic_rcv.ic_acquisition_cost) over (partition by q_ic_main.ic_item_id_p) rcv_avg_acquisition_cost,
 case
 when sum(q_ic_rcv.ic_quantity) over (partition by q_ic_main.ic_item_id_p) is not null
 and  avg(q_ic_rcv.ic_acquisition_cost) over (partition by q_ic_main.ic_item_id_p) is not null
 then round( (  sum(q_ic_rcv.ic_quantity) over (partition by q_ic_main.ic_item_id_p)
              * avg(q_ic_rcv.ic_acquisition_cost) over (partition by q_ic_main.ic_item_id_p)
             ) / :round_unit
           ) * :round_unit
 end  rcv_value,
 case
 when sum(q_ic_rcv.ic_quantity) over (partition by q_ic_main.ic_item_id_p) is not null
 and  avg(q_ic_rcv.ic_acquisition_cost) over (partition by q_ic_main.ic_item_id_p) is not null
 then round( ( (  sum(q_ic_rcv.ic_quantity) over (partition by q_ic_main.ic_item_id_p)
                * avg(q_ic_rcv.ic_acquisition_cost) over (partition by q_ic_main.ic_item_id_p)
               ) +
               q_ic_main.ic_total_cost_r
             ) / :round_unit
           ) * :round_unit
 else round(q_ic_main.ic_total_cost_r / :round_unit) * :round_unit
 end  total_value,
 --
 q_ic_main.ic_matl_cost material_cost,
 q_ic_main.ic_tot_matl_cost_r material_value,
 q_ic_main.ic_mo_cost material_overhead_cost,
 q_ic_main.ic_tot_mo_cost_r material_overhead_value,
 q_ic_main.ic_res_cost resource_cost,
 q_ic_main.ic_tot_res_cost_r resource_value,
 q_ic_main.ic_osp_cost outside_processing_cost,
 q_ic_main.ic_osp_cost_r outside_processing_value,
 q_ic_main.ic_ovhd_cost overhead_cost,
 q_ic_main.ic_ovhd_cost_r overhead_value,
 q_ic_main.ic_unit_cost cost_elements_total_cost,
 q_ic_main.ic_total_cost_r cost_elements_total_value,
 --
 q_ic_main.ic_item_id_p item_id,
 q_ic_main.ic_order,
 row_number() over (partition by ic_item_id_p order by q_ic_rcv.ic_txn_id) row_num,
 --q_ic_rcv.*
 q_ic_rcv.ic_receipt_date receipt_date,
 q_ic_rcv.ic_receipt_num receipt_number,
 q_ic_rcv.ic_shipment_num shipment_number,
 q_ic_rcv.ic_current_location current_location,
 q_ic_rcv.ic_deliver_to_location deliver_to_location,
 q_ic_rcv.ic_packing_slip packing_slip,
 q_ic_rcv.ic_document_type document_type,
 q_ic_rcv.ic_document_number document_number,
 q_ic_rcv.ic_document_line_num document_line_number,
 q_ic_rcv.ic_quantity receipt_qty,
 q_ic_rcv.ic_acquisition_cost_r acquisition_cost,
 q_ic_rcv.ic_value_r value,
 q_ic_rcv.ic_txn_id,
 --
 q_ic_rcv.ic_pac_period,
 q_ic_rcv.ic_cost_type,
 q_ic_rcv.ic_start_date,
 q_ic_rcv.ic_end_date,
 q_ic_rcv.ic_item_num,
 q_ic_rcv.ic_category,
 q_ic_rcv.ic_uom_code,
 q_ic_rcv.ic_revision,
 q_ic_rcv.ic_description,
 q_ic_rcv.ic_acquisition_cost,
 q_ic_rcv.ic_value
from
q_ic_main,
q_ic_rcv
where
q_ic_main.ic_item_id_p = q_ic_rcv.ic_item_id_c (+) and
q_ic_main.cost_group_id = q_ic_rcv.cost_group_id (+) and
q_ic_main.period_id = q_ic_rcv.period_id (+)
) x
order by
x.ic_order,
x.item,
x.row_num,
x.ic_txn_id