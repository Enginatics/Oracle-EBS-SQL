/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: MRP Exceptions
-- Description: Detail report for MRP Exception messages, including item, make or buy, default buyer, planner and exception message to use.
-- Excel Examle Output: https://www.enginatics.com/example/mrp-exceptions/
-- Library Link: https://www.enginatics.com/reports/mrp-exceptions/
-- Run Report: https://demo.enginatics.com/

select
medv.organization_code,
medv.compile_designator plan,
medv.item_segments item,
msiv.description item_description,
xxen_util.meaning(msiv.planning_make_buy_code,'MTL_PLANNING_MAKE_BUY',700) make_or_buy,
ppx.full_name buyer,
msiv.planner_code planner,
mpl.description planner_description,
medv.exception_type_text exception_message,
medv.project_number,
medv.task_number,
medv.to_project_number,
medv.to_task_number,
medv.due_date,
medv.from_date,
medv.to_date,
medv.days_compressed,
medv.quantity,
medv.lot_number,
medv.order_number,
medv.supply_type,
medv.end_item_segments end_item,
medv.end_order_number,
medv.planning_group,
medv.department_line_code,
medv.resource_code,
medv.utilization_rate,
medv.exception_type
from
mrp_exception_details_v medv,
mtl_system_items_vl msiv,
per_people_x ppx,
mtl_planners mpl
where
1=1 and
(
medv.exception_type<>19 or not exists
(
select
null
from
mrp_exception_details_v medv2
where
medv.exception_type=medv2.exception_type and
medv.compile_designator=medv2.compile_designator and
medv.organization_id=medv2.organization_id and
medv.inventory_item_id=medv2.inventory_item_id and
medv.to_project_number=medv2.project_number and
medv.to_task_number=medv2.task_number
)
) and
medv.exception_type<>5 and
medv.exception_type in (1,2,3,4,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29) and
medv.organization_id=msiv.organization_id(+) and
medv.inventory_item_id=msiv.inventory_item_id(+) and
msiv.buyer_id=ppx.person_id(+) and
msiv.planner_code=mpl.planner_code(+) and
msiv.organization_id=mpl.organization_id(+)