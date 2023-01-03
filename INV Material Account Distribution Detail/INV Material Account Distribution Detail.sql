/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2023 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: INV Material Account Distribution Detail
-- Description: Description: Material account distribution detail
Application: Inventory

Source: Material account distribution detail (XML)
Short Name: INVTRDST_XML
-- Excel Examle Output: https://www.enginatics.com/example/inv-material-account-distribution-detail/
-- Library Link: https://www.enginatics.com/reports/inv-material-account-distribution-detail/
-- Run Report: https://demo.enginatics.com/

with
material_account_dist_q as
(
select --Q1
 gsob.name ledger,
 gsob.currency_code,
 haou.name operating_unit,
 mp.organization_code,
 mta.transaction_date txn_date,
 msi.description description,
 mtst.transaction_source_type_name,
 mtt.transaction_type_name,
 case mta.transaction_source_type_id
 when 1  then (select pha.segment1 from po_headers_all pha where pha.po_header_id = mmt.transaction_source_id)
 when 4  then (select mtrh.request_number from mtl_txn_request_headers mtrh where mtrh.header_id = mmt.transaction_source_id)
 when 5  then (select we.wip_entity_name from  wip_entities we where we.wip_entity_id = mmt.transaction_source_id)
 when 7  then (select prha.segment1 from po_requisition_headers_all prha where prha.requisition_header_id = mmt.transaction_source_id)
 when 9  then (select mcch.cycle_count_header_name from mtl_cycle_count_headers mcch where mcch.cycle_count_header_id = mmt.transaction_source_id and mcch.organization_id = mmt.organization_id)
 when 10 then (select mpi.physical_inventory_name from mtl_physical_inventories mpi where mpi.physical_inventory_id = mmt.transaction_source_id and mpi.organization_id = mmt.organization_id)
 when 11 then (select ccu.description from  cst_cost_updates ccu where ccu.cost_update_id = mmt.transaction_source_id)
 else nvl(mmt.transaction_source_name, to_char(mmt.transaction_source_id))
 end source,
 decode(mmt.transaction_action_id
       , 3, decode(mmt.organization_id,mta.organization_id,mmt.subinventory_code, mmt.transfer_subinventory)
       , 2, decode(sign(mta.primary_quantity),-1,mmt.subinventory_code,1, mmt.transfer_subinventory,mmt.subinventory_code)
       ,28, decode(sign(mta.primary_quantity),-1,mmt.subinventory_code,1, mmt.transfer_subinventory,mmt.subinventory_code)
       , 5, mmt.subinventory_code
          , mmt.subinventory_code
      ) subinv,
 decode(mta.transaction_source_type_id, 11,mmt.quantity_adjusted, mta.primary_quantity ) quantity,
 msi.primary_uom_code primary_uom,
 decode(mmt.transaction_action_id
       ,30, abs(round(nvl(mta.rate_or_amount,mta.base_transaction_value/decode(mta.primary_quantity,0,1,null,1,mta.primary_quantity)) * nvl(:p_exchange_rate,1) ,:p_ext_prec))
          , (  abs(round(nvl(mta.rate_or_amount,mta.base_transaction_value/decode(mta.primary_quantity,0, 1, null,1,mta.primary_quantity)) * nvl(:p_exchange_rate,1) ,:p_ext_prec))
             * sign(mta.base_transaction_value) * sign(mta.primary_quantity)
            )
       ) unit_cost,
 nvl(mta.base_transaction_value,0) * nvl(:p_exchange_rate,1) value,
 round(nvl(mta.base_transaction_value,0) * nvl(:p_exchange_rate,1), :p_ext_prec) value_r,
 decode(mmt.transaction_action_id
       ,30, abs(nvl(mta.rate_or_amount,mta.base_transaction_value/decode(mta.primary_quantity,0,1,null,1,mta.primary_quantity)))
          , (  abs(nvl(mta.rate_or_amount,mta.base_transaction_value/decode(mta.primary_quantity,0, 1, null,1,mta.primary_quantity)))
             * sign(mta.base_transaction_value) * sign(mta.primary_quantity)
            )
       ) base_unit_cost,
 mta.base_transaction_value,
 gcc.concatenated_segments account_segments,
 fnd_flex_xml_publisher_apis.process_kff_combination_1('acc desc', 'SQLGL', 'GL#', gcc.chart_of_accounts_id, null, gcc.code_combination_id, 'ALL', 'Y', 'DESCRIPTION') account_segments_desc,
 xxen_util.meaning(mta.accounting_line_type,'CST_ACCOUNTING_LINE_TYPE',700) accounting_type,
 msi.concatenated_segments item,
 mc.concatenated_segments category,
 mta.transaction_source_type_id source_type_id,
 decode(mta.transaction_source_type_id
       , 1,to_char(mmt.transaction_source_id)
       , 4,to_char(mmt.transaction_source_id)
       , 5,to_char(mmt.transaction_source_id)
       , 7,to_char(mmt.transaction_source_id)
       , 9,to_char(mmt.transaction_source_id)
       ,10,to_char(mmt.transaction_source_id)
       ,11,to_char(mmt.transaction_source_id)
          ,nvl(mmt.transaction_source_name, to_char(mmt.transaction_source_id))
       ) source_id,
 mmt.transaction_type_id,
 mmt.transaction_action_id,
 mta.organization_id,
 mta.inventory_item_id,
 mta.reference_account code_combination_id,
 mta.gl_batch_id,
 mmt.reason_id,
 mta.transaction_id
from
 mtl_transaction_accounts mta,
 mtl_material_transactions mmt,
 mtl_parameters mp,
 mtl_system_items_vl msi,
 mtl_item_categories mic,
 mtl_categories_kfv mc,
 mtl_txn_source_types mtst,
 mtl_transaction_types mtt,
 gl_code_combinations_kfv gcc,
 hr_organization_information hoi,
 hr_all_organization_units haou,
 gl_sets_of_books gsob
where
 1=1 and
 mta.transaction_id = mmt.transaction_id and
 mta.organization_id = mp.organization_id and
 mta.inventory_item_id = msi.inventory_item_id and 
 mta.organization_id = msi.organization_id and
 mic.inventory_item_id = msi.inventory_item_id and
 mic.organization_id = msi.organization_id and
 mic.category_set_id = :p_cat_set_id and
 mc.category_id = mic.category_id and 
 mta.transaction_source_type_id = mtst.transaction_source_type_id and
 mmt.transaction_type_id = mtt.transaction_type_id and
 mta.reference_account = gcc.code_combination_id and
 mta.transaction_source_type_id not in (2,3,6,8,12,101) and
 mta.accounting_line_type <> 15 and
 mta.organization_id = hoi.organization_id and
 hoi.org_information_context || '' ='Accounting Information' and
 haou.organization_id = to_number(hoi.org_information3) and
 gsob.set_of_books_id = to_number(hoi.org_information1)
union all
select --Q2
 gsob.name ledger,
 gsob.currency_code,
 haou.name operating_unit,
 mp.organization_code,
 mta.transaction_date txn_date,
 msi.description description,
 mtst.transaction_source_type_name,
 mtt.transaction_type_name,
 fnd_flex_xml_publisher_apis.process_kff_combination_1('so', 'INV', 'MKTS', 101, null, mkts.sales_order_id, 'ALL', 'Y', 'VALUE') source,
 decode(mmt.transaction_action_id
       , 3, decode(mmt.organization_id,mta.organization_id,mmt.subinventory_code, mmt.transfer_subinventory)
       , 2, decode(sign(mta.primary_quantity),-1,mmt.subinventory_code,1, mmt.transfer_subinventory,mmt.subinventory_code)
       ,28, decode(sign(mta.primary_quantity),-1,mmt.subinventory_code,1, mmt.transfer_subinventory,mmt.subinventory_code)
       , 5, mmt.subinventory_code, mmt.subinventory_code
       ) subinv,
 decode(mta.transaction_source_type_id,11,mmt.quantity_adjusted, mta.primary_quantity) quantity,
 msi.primary_uom_code primary_uom,
 decode(mmt.transaction_action_id
       ,30, abs(round(nvl(mta.rate_or_amount,mta.base_transaction_value/decode(mta.primary_quantity,0,1,null,1,mta.primary_quantity)) * nvl(:p_exchange_rate,1) ,:p_ext_prec))
          , (  abs(round(nvl(mta.rate_or_amount,mta.base_transaction_value/decode(mta.primary_quantity,0, 1, null,1,mta.primary_quantity))
             * nvl(:p_exchange_rate,1) ,:p_ext_prec)) * sign(mta.base_transaction_value) * sign(mta.primary_quantity)
            )
       ) unit_cost,
 nvl(mta.base_transaction_value,0) * nvl(:p_exchange_rate,1) value,
 round(nvl ( mta.base_transaction_value , 0 ) * nvl(:p_exchange_rate,1), :p_ext_prec) value_r,
 decode(mmt.transaction_action_id
       ,30, abs(nvl(mta.rate_or_amount,mta.base_transaction_value/decode(mta.primary_quantity,0,1,null,1,mta.primary_quantity)))
          , ( abs(nvl(mta.rate_or_amount,mta.base_transaction_value/decode(mta.primary_quantity,0, 1, null,1,mta.primary_quantity))) * sign(mta.base_transaction_value)
              * sign(mta.primary_quantity)
            )
       ) base_unit_cost,
 mta.base_transaction_value,
 gcc.concatenated_segments account_segments,
 fnd_flex_xml_publisher_apis.process_kff_combination_1('acc desc', 'SQLGL', 'GL#', gcc.chart_of_accounts_id, null, gcc.code_combination_id, 'ALL', 'Y', 'DESCRIPTION') account_segments_desc,
 xxen_util.meaning(mta.accounting_line_type,'CST_ACCOUNTING_LINE_TYPE',700) accounting_type,
 msi.concatenated_segments item,
 mc.concatenated_segments category,
 mta.transaction_source_type_id source_type_id,
 to_char(mkts.sales_order_id) source_id,
 mmt.transaction_type_id,
 mmt.transaction_action_id,
 mta.organization_id,
 mta.inventory_item_id,
 mta.reference_account code_combination_id,
 mta.gl_batch_id,
 mmt.reason_id,
 mta.transaction_id
from
 mtl_transaction_accounts mta,
 mtl_material_transactions mmt,
 mtl_parameters mp,
 mtl_system_items_vl msi,
 mtl_item_categories mic,
 mtl_categories_kfv mc,
 mtl_txn_source_types mtst,
 mtl_transaction_types mtt,
 gl_code_combinations_kfv gcc,
 mtl_sales_orders mkts,
 hr_organization_information hoi,
 hr_all_organization_units haou,
 gl_sets_of_books gsob
where
 1=1 and
 mta.transaction_id = mmt.transaction_id and
 mta.organization_id = mp.organization_id and
 mta.organization_id = msi.organization_id and
 mta.inventory_item_id = msi.inventory_item_id and 
 mic.organization_id = msi.organization_id and 
 mic.inventory_item_id = msi.inventory_item_id and
 mic.category_set_id = :p_cat_set_id and
 mic.category_id = mc.category_id and  
 mta.transaction_source_type_id = mtst.transaction_source_type_id and
 mmt.transaction_type_id = mtt.transaction_type_id and
 mta.reference_account = gcc.code_combination_id and
 mta.transaction_source_id = mkts.sales_order_id and
 mta.transaction_source_type_id in (2,8,12,101) and
 mta.accounting_line_type <> 15 and
 mta.organization_id = hoi.organization_id and
 hoi.org_information_context || '' ='Accounting Information' and
 haou.organization_id = to_number(hoi.org_information3) and
 gsob.set_of_books_id = to_number(hoi.org_information1)
union all
select --Q3
 gsob.name ledger,
 gsob.currency_code,
 haou.name operating_unit,
 mp.organization_code,
 mta.transaction_date txn_date,
 msi.description description,
 mtst.transaction_source_type_name,
 mtt.transaction_type_name,
 fnd_flex_xml_publisher_apis.process_kff_combination_1('alias', 'INV', 'MDSP', 101, mdsp.organization_id, mdsp.disposition_id, 'ALL', 'Y', 'VALUE') source,
 decode(mmt.transaction_action_id
       , 3, decode(mmt.organization_id,mta.organization_id,mmt.subinventory_code, mmt.transfer_subinventory)
       , 2, decode(sign(mta.primary_quantity),-1,mmt.subinventory_code,1, mmt.transfer_subinventory,mmt.subinventory_code)
       ,28, decode(sign(mta.primary_quantity),-1,mmt.subinventory_code,1, mmt.transfer_subinventory,mmt.subinventory_code)
       , 5, mmt.subinventory_code
          , mmt.subinventory_code
       ) subinv,
 decode(mta.transaction_source_type_id, 11,mmt.quantity_adjusted, mta.primary_quantity) quantity,
 msi.primary_uom_code primary_uom,
 decode(mmt.transaction_action_id
       ,30, abs(round(nvl(mta.rate_or_amount,mta.base_transaction_value/decode(mta.primary_quantity,0,1,null,1,mta.primary_quantity)) * nvl(:p_exchange_rate,1) ,:p_ext_prec))
          , ( abs(round(nvl(mta.rate_or_amount,mta.base_transaction_value/decode(mta.primary_quantity,0, 1, null,1,mta.primary_quantity)) * nvl(:p_exchange_rate,1) ,:p_ext_prec))
             * sign(mta.base_transaction_value) * sign(mta.primary_quantity)
            )
       ) unit_cost,
 nvl(mta.base_transaction_value,0) * nvl(:p_exchange_rate,1) value,
 round(nvl ( mta.base_transaction_value , 0 ) * nvl(:p_exchange_rate,1), :p_ext_prec) value_r,
 decode(mmt.transaction_action_id
       ,30, abs(nvl(mta.rate_or_amount,mta.base_transaction_value/decode(mta.primary_quantity,0,1,null,1,mta.primary_quantity)))
          , ( abs(nvl(mta.rate_or_amount,mta.base_transaction_value/decode(mta.primary_quantity,0, 1, null,1,mta.primary_quantity)))
             * sign(mta.base_transaction_value) * sign(mta.primary_quantity)
            )
       ) base_unit_cost,
 mta.base_transaction_value,
 gcc.concatenated_segments account_segments,
 fnd_flex_xml_publisher_apis.process_kff_combination_1('acc desc', 'SQLGL', 'GL#', gcc.chart_of_accounts_id, null, gcc.code_combination_id, 'ALL', 'Y', 'DESCRIPTION') account_segments_desc,
 xxen_util.meaning(mta.accounting_line_type,'CST_ACCOUNTING_LINE_TYPE',700) accounting_type,
 msi.concatenated_segments item,
 mc.concatenated_segments category,
 mta.transaction_source_type_id source_type_id,
 to_char(mdsp.disposition_id) source_id,
 mmt.transaction_type_id,
 mmt.transaction_action_id,
 mta.organization_id,
 mta.inventory_item_id,
 mta.reference_account code_combination_id,
 mta.gl_batch_id,
 mmt.reason_id,
 mta.transaction_id
from
 mtl_transaction_accounts mta,
 mtl_material_transactions mmt,
 mtl_parameters mp,
 mtl_system_items_vl msi,
 mtl_item_categories mic,
 mtl_categories_kfv mc,
 mtl_txn_source_types mtst,
 mtl_transaction_types mtt,
 gl_code_combinations_kfv gcc,
 mtl_generic_dispositions mdsp,
 hr_organization_information hoi,
 hr_all_organization_units haou,
 gl_sets_of_books gsob 
where
 1=1 and
 mta.transaction_id = mmt.transaction_id and
 mta.organization_id = mp.organization_id and
 mta.organization_id = msi.organization_id and
 mta.inventory_item_id = msi.inventory_item_id and
 mic.organization_id = msi.organization_id and 
 mic.inventory_item_id = msi.inventory_item_id and
 mic.category_set_id = :p_cat_set_id and
 mic.category_id = mc.category_id and
 mta.transaction_source_type_id = mtst.transaction_source_type_id and
 mmt.transaction_type_id = mtt.transaction_type_id and
 mta.reference_account = gcc.code_combination_id and
 mta.transaction_source_id = mdsp.disposition_id and
 mta.transaction_source_type_id = 6 and
 mta.accounting_line_type <> 15 and
 mta.organization_id = hoi.organization_id and
 hoi.org_information_context || '' ='Accounting Information' and
 haou.organization_id = to_number(hoi.org_information3) and
 gsob.set_of_books_id = to_number(hoi.org_information1)
union all
select --Q4
 gsob.name ledger,
 gsob.currency_code,
 haou.name operating_unit,
 mp.organization_code,
 mta.transaction_date txn_date,
 msi.description description,
 mtst.transaction_source_type_name,
 mtt.transaction_type_name,
 glc.concatenated_segments source,
 decode(mmt.transaction_action_id
       , 3, decode(mmt.organization_id,mta.organization_id,mmt.subinventory_code, mmt.transfer_subinventory)
       , 2, decode(sign(mta.primary_quantity),-1,mmt.subinventory_code,1, mmt.transfer_subinventory,mmt.subinventory_code)
       ,28, decode(sign(mta.primary_quantity),-1,mmt.subinventory_code,1, mmt.transfer_subinventory,mmt.subinventory_code)
       , 5, mmt.subinventory_code
          , mmt.subinventory_code
       ) subinv,
 decode(mta.transaction_source_type_id, 11,mmt.quantity_adjusted, mta.primary_quantity ) quantity,
 msi.primary_uom_code primary_uom,
 decode(mmt.transaction_action_id
       ,30, abs(round(nvl(mta.rate_or_amount,mta.base_transaction_value/decode(mta.primary_quantity,0,1,null,1,mta.primary_quantity)) * nvl(:p_exchange_rate,1) ,:p_ext_prec))
          , ( abs(round(nvl(mta.rate_or_amount,mta.base_transaction_value/decode(mta.primary_quantity,0, 1, null,1,mta.primary_quantity)) * nvl(:p_exchange_rate,1) ,:p_ext_prec))
             * sign(mta.base_transaction_value) * sign(mta.primary_quantity)
            )
       ) unit_cost,
 nvl(mta.base_transaction_value,0) * nvl(:p_exchange_rate,1) value,
 round(nvl ( mta.base_transaction_value , 0 ) * nvl(:p_exchange_rate,1), :p_ext_prec) value_r,
 decode(mmt.transaction_action_id
       ,30, abs(nvl(mta.rate_or_amount,mta.base_transaction_value/decode(mta.primary_quantity,0,1,null,1,mta.primary_quantity)))
          , ( abs(nvl(mta.rate_or_amount,mta.base_transaction_value/decode(mta.primary_quantity,0, 1, null,1,mta.primary_quantity)))
             * sign(mta.base_transaction_value) * sign(mta.primary_quantity)
            )
       ) base_unit_cost,
 mta.base_transaction_value,
 gcc.concatenated_segments account_segments,
 fnd_flex_xml_publisher_apis.process_kff_combination_1('acc desc', 'SQLGL', 'GL#', gcc.chart_of_accounts_id, null, gcc.code_combination_id, 'ALL', 'Y', 'DESCRIPTION') account_segments_desc,
 xxen_util.meaning(mta.accounting_line_type,'CST_ACCOUNTING_LINE_TYPE',700) accounting_type,
 msi.concatenated_segments item,
 mc.concatenated_segments category,
 mta.transaction_source_type_id source_type_id,
 to_char(glc.code_combination_id) source_id,
 mmt.transaction_type_id,
 mmt.transaction_action_id,
 mta.organization_id,
 mta.inventory_item_id,
 mta.reference_account code_combination_id,
 mta.gl_batch_id,
 mmt.reason_id,
 mta.transaction_id
from
 mtl_transaction_accounts mta,
 mtl_material_transactions mmt,
 mtl_parameters mp,
 mtl_system_items_vl msi,
 mtl_item_categories mic,
 mtl_categories_kfv mc,
 mtl_txn_source_types mtst,
 mtl_transaction_types mtt,
 gl_code_combinations_kfv gcc,
 gl_code_combinations_kfv glc,
 hr_organization_information hoi,
 hr_all_organization_units haou,
 gl_sets_of_books gsob
where
 1=1 and
 mta.transaction_id = mmt.transaction_id and
 mta.organization_id = mp.organization_id and
 mta.organization_id = msi.organization_id and 
 mta.inventory_item_id = msi.inventory_item_id and 
 mic.organization_id = msi.organization_id and 
 mic.inventory_item_id = msi.inventory_item_id and
 mic.category_set_id = :p_cat_set_id and
 mic.category_id = mc.category_id and
 mta.transaction_source_type_id = mtst.transaction_source_type_id and
 mmt.transaction_type_id = mtt.transaction_type_id and
 mta.reference_account = gcc.code_combination_id and
 mta.transaction_source_id = glc.code_combination_id and
 mta.transaction_source_type_id = 3 and
 mta.accounting_line_type <> 15 and
 mta.organization_id = hoi.organization_id and
 hoi.org_information_context || '' ='Accounting Information' and
 haou.organization_id = to_number(hoi.org_information3) and
 gsob.set_of_books_id = to_number(hoi.org_information1)
)
--
-- Main Query Starts Here
--
select
 mad.ledger,
 mad.operating_unit,
 mad.organization_code,
 trunc(mad.txn_date) transaction_date,
 mad.description,
 mad.transaction_source_type_name source_type,
 mad.transaction_type_name transaction_type,
 mad.source,
 mad.subinv subinventory,
 mad.account_segments,
 mad.account_segments_desc,
 mad.accounting_type,
 mad.item,
 mad.category,
 mad.quantity,
 mad.primary_uom uom,
 mad.base_unit_cost,
 mad.base_transaction_value,
 nvl(:p_currency_code,mad.currency_code) currency,
 nvl(:p_exchange_rate,1) exchange_rate,
 mad.unit_cost,
 mad.value transaction_value,
 (select mtr.reason_name from mtl_transaction_reasons mtr where mtr.reason_id = mad.reason_id) transaction_reason,
 mad.gl_batch_id,
 mad.transaction_id
from
 material_account_dist_q mad
where
2=2 and
:p_category_set_name=:p_category_set_name and
nvl(:p_source_type_id,-1) = nvl(:p_source_type_id,-1)
order by
 mad.ledger,
 mad.account_segments,
 mad.txn_date,
 mad.transaction_source_type_name,
 mad.transaction_type_name,
 mad.source,
 mad.subinv,
 mad.quantity,
 mad.unit_cost,
 mad.value