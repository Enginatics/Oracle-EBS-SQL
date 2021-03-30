/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2021 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: INV Item Statuses
-- Description: Master data report of inventory items with the various status attributes, such as: is BOM allowed, Build in WIP, customer orders enabled, internal orders enabled and Invoice enabled, etc.
-- Excel Examle Output: https://www.enginatics.com/example/inv-item-statuses(12)/
-- Library Link: https://www.enginatics.com/reports/inv-item-statuses(12)/
-- Run Report: https://demo.enginatics.com/

select
*
from
(
select
msavav.inventory_item_status_code status_code,
misv.inventory_item_status_code_tl status,
misv.description,
&column1
xxen_util.meaning(decode(msavav.attribute_value,'Y','Y'),'YES_NO',0) value,
&column2
substr(msavav.attribute_name,18) column_name
from
mtl_item_status_vl misv,
mtl_stat_attrib_values_all_v msavav
where
1=1 and
misv.inventory_item_status_code=msavav.inventory_item_status_code
order by
msavav.inventory_item_status_code,
msavav.attribute_name_disp
)
&pivot