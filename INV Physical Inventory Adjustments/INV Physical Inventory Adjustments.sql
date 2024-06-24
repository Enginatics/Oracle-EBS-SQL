/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: INV Physical Inventory Adjustments
-- Description: Imported from BI Publisher
Description: Physical inventory adjustments report
Application: Inventory
Source: Physical inventory adjustments report (XML)
Short Name: INVARPAR_XML
DB package: INV_INVARPAR_XMLP_PKG
-- Excel Examle Output: https://www.enginatics.com/example/inv-physical-inventory-adjustments/
-- Library Link: https://www.enginatics.com/reports/inv-physical-inventory-adjustments/
-- Run Report: https://demo.enginatics.com/

with
q_dual as (select dummy from dual)
&lp_with_query
--
-- Main Query starts here
--
select
qm.physical_inventory_name,
qm.c_item_flex item,
qm.rev,
qm.subinv subinventory,
qm.c_loc_flex locator,
qm.lot_number,
case
when qm.serial_count_option = 2 then qs.sl_serial_number
else qm.serial_number
end serial_number,
--
case when 1 = row_number() over (partition by qm.adjustment_id order by nvl(qs.sl_serial_number,qm.serial_number)) then qm.cf_approver else null end approver,
--
case when 1 = row_number() over (partition by qm.adjustment_id order by nvl(qs.sl_serial_number,qm.serial_number)) then qm.count_quantity else null end count_quantity,
case when 1 = row_number() over (partition by qm.adjustment_id order by nvl(qs.sl_serial_number,qm.serial_number)) then qm.uom else null end uom,
case when 1 = row_number() over (partition by qm.adjustment_id order by nvl(qs.sl_serial_number,qm.serial_number)) then qm.adjustment_quantity else null end adjustment_quantity,
case when 1 = row_number() over (partition by qm.adjustment_id order by nvl(qs.sl_serial_number,qm.serial_number)) then qm.count_value else null end count_value,
case when 1 = row_number() over (partition by qm.adjustment_id order by nvl(qs.sl_serial_number,qm.serial_number)) then qm.adjustment_value else null end adjustment_value,
&lp_select_clause
from
q_main qm,
q_serial qs
where
1=1 and
:p_version_control = :p_version_control and
case when :p_show_detail_sn = 'Y' and qm.serial_count_option = 2 and qm.serial_number_control_code in (2,5) then qm.adjustment_id else null end = qs.adjustment_id (+)
order by
qm.physical_inventory_name,
(nvl(qm.count_quantity*qm.actual_cost, 0)-nvl(qm.system_quantity*qm.actual_cost,0)) &c_sort,
qm.system_value asc,
qm.c_item_flex asc,
qm.rev asc,
qm.c_loc_flex asc,
qm.lot_number asc,
nvl(qs.sl_serial_number,qm.serial_number) asc