/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2020 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: PO Purchase Requisition Interface
-- Description: Purchase requisitions interface listing with status for support and operational purposes.
-- Excel Examle Output: https://www.enginatics.com/example/po-purchase-requisition-interface/
-- Library Link: https://www.enginatics.com/reports/po-purchase-requisition-interface/
-- Run Report: https://demo.enginatics.com/

select 
msib.segment1,
pria.rowid, 
pria.process_flag, 
pria.org_id, 
pria.deliver_to_requestor_name, 
pria.deliver_to_requestor_id,
pria.requisition_header_id,              
pria.requisition_line_id,              
pria.req_distribution_id, 
pria.req_number_segment1,
pria.*
from 
po_requisitions_interface_all pria,
mtl_system_items_b msib
where 1=1
and pria.item_id=msib.inventory_item_id
and msib.organization_id=pria.destination_organization_id
--and interface_source_code='msc'