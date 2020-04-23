/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2020 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: Testing Zero Cost Items SQL
-- Excel Examle Output: https://www.enginatics.com/example/testing-zero-cost-items-sql/
-- Library Link: https://www.enginatics.com/reports/testing-zero-cost-items-sql/
-- Run Report: https://demo.enginatics.com/

select mp.organization_code, msi.segment1, msi.description, msi.inventory_item_status_Code, msi.creation_date, msi.planner_code,
       decode(msi.planning_make_buy_code, 1, 'MAKE', 'BUY') Mk_Buy, decode(cic.based_on_rollup_flag, 1, 'Yes', 'No') Based_on_rollup
from cst_item_costs cic, mtl_system_items msi, hr_organization_units hou, mtl_parameters mp
where 1=1
and msi.organization_id = mp.organization_id 
and cic.organization_id = msi.organization_id
and cic.inventory_item_id = msi.inventory_item_id 
and cic.cost_type_id = 1 
and hou.organization_id = mp.organization_id
and msi.costing_enabled_flag = 'Y' 
and hou.date_to is null
and nvl(cic.item_cost,0) = 0
order by msi.segment1, mp.organization_code