/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: INV Cycle count schedule requests
-- Description: Imported Oracle standard Cycle count schedule requests report
-- Source: Cycle count schedule requests report (XML)
-- Short Name: INVARRTAXML
-- DB package: INVINVARRTAXMLPPKG
-- Excel Example Output: https://www.enginatics.com/example/inv-cycle-count-schedule-requests/
-- Library Link: https://www.enginatics.com/reports/inv-cycle-count-schedule-requests/
-- Run Report: https://demo.enginatics.com/

select
ood.organization_code,
ood.organization_name,
gl.currency_code,
mcch.cycle_count_header_name cycle_count_name,
msiv.concatenated_segments item,
msiv.description description,
&category_columns
xxen_util.meaning(msiv.item_type,'ITEM_TYPE',3) user_item_type,
mcsr.subinventory subinventory,
mcsr.revision revision,
mcsr.lot_number lot_number,
nvl(inv_project.get_locator(milk.inventory_location_id,milk.organization_id),milk.concatenated_segments) locator,
milk.description locator_description,
mcsr.schedule_date request_date,
mcsr.count_due_date due_date,
xxen_util.meaning(mcsr.request_source_type,'MTL_CC_SOURCE_TYPES',700) request_type, 
mcsr.serial_number
from
mtl_cycle_count_headers mcch,
mtl_cc_schedule_requests mcsr,
mtl_item_locations_kfv milk,
mtl_system_items_vl msiv,
org_organization_definitions ood,
gl_ledgers gl
where
1=1 and
mcch.organization_id in (select xroa.id from xxen_report_org_access xroa where xroa.access_type='INV') and
nvl(mcch.disable_date,sysdate+1)>sysdate and
mcch.cycle_count_header_id=mcsr.cycle_count_header_id and
mcch.organization_id=milk.organization_id(+) and
mcsr.locator_id=milk.inventory_location_id(+) and
mcch.organization_id=msiv.organization_id(+) and
mcsr.inventory_item_id=msiv.inventory_item_id(+) and
mcch.organization_id=ood.organization_id and
ood.set_of_books_id=gl.ledger_id
order by
ood.organization_code,
mcsr.schedule_date,
mcsr.subinventory, 
mcsr.revision,
mcsr.request_source_type
