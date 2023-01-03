/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2023 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: INV Cycle count schedule requests
-- Description: Imported Oracle standard Cycle count schedule requests report
Source: Cycle count schedule requests report (XML)
Short Name: INVARRTA_XML
DB package: INV_INVARRTA_XMLP_PKG
-- Excel Examle Output: https://www.enginatics.com/example/inv-cycle-count-schedule-requests/
-- Library Link: https://www.enginatics.com/reports/inv-cycle-count-schedule-requests/
-- Run Report: https://demo.enginatics.com/

select
ood.organization_code,
ood.organization_name,
gl.currency_code,
mcch.cycle_count_header_name cycle_count_name,
msiv.concatenated_segments item,
msiv.description description,
mcsr.subinventory subinventory,
mcsr.revision revision,
mcsr.lot_number lot_number,
inv_project.get_locator(mil.inventory_location_id,mil.organization_id) locator,
mil.description locator_description,
mcsr.schedule_date request_date,
mcsr.count_due_date due_date,
ml.meaning request_type, 
mcsr.serial_number
from
mtl_cc_schedule_requests mcsr,
mfg_lookups ml,
mtl_item_locations mil,
mtl_system_items_vl msiv,
mtl_cycle_count_headers mcch,
org_organization_definitions ood,
gl_ledgers gl
where
1=1 and 
msiv.organization_id(+)=ood.organization_id and
nvl(mcch.disable_date,sysdate+1)>sysdate and
mil.organization_id(+)=ood.organization_id and
ood.set_of_books_id=gl.ledger_id and
mcch.organization_id=ood.organization_id and
mcsr.cycle_count_header_id=mcch.cycle_count_header_id and
msiv.inventory_item_id(+)=mcsr.inventory_item_id and 
mil.inventory_location_id(+)=mcsr.locator_id and
ml.lookup_type='MTL_CC_SOURCE_TYPES' and
ml.lookup_code=mcsr.request_source_type
order by 
mcsr.schedule_date,
mcsr.subinventory, 
mcsr.revision,
mcsr.request_source_type