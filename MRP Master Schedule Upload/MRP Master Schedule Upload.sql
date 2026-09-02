/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: MRP Master Schedule Upload
-- Description: MRP Master Schedule Upload
==========================
- Create new MDS/MPS schedule entries.
- Create and Update existing schedule entries.

Each row stages one schedule entry into the MRP schedule interface (mrp_schedule_interface, process_status=2) for an existing schedule designator (MDS or MPS). The staged entries are loaded into the master schedule (mrp_schedule_dates) asynchronously by the customer's MRP Planning Manager.

Upload Modes
============
Create - opens an empty spreadsheet to enter new schedule entries against any accessible schedule designator.
Create and Update - downloads existing schedule entries for the selected schedule designators and lets the user add new entries and re-stage modifications. Existing entries are matched on the hidden Transaction Id.

Prerequisites
=============
- Schedule designators (Master Demand Schedule / Master Production Schedule) must be defined.

-- Excel Examle Output: https://www.enginatics.com/example/mrp-master-schedule-upload/
-- Library Link: https://www.enginatics.com/reports/mrp-master-schedule-upload/
-- Run Report: https://demo.enginatics.com/

select
null action_,
null status_,
null message_,
null request_id_,
null modified_columns_,
to_char(null) row_id,
:p_upload_mode upload_mode,
:p_source_code source_code,
--
mp.organization_code,
msd.schedule_designator,
xxen_util.meaning(msd.schedule_type,'MRP_SCHEDULE_TYPE',700) schedule_type,
msd.description schedule_description,
msiv.concatenated_segments item,
msiv.description item_description,
msiv.primary_uom_code uom,
msiv.planner_code planner,
msdt.schedule_date,
to_date(null) new_schedule_date,
msdt.rate_end_date,
msdt.schedule_quantity,
to_char(null) workday_control,
msdt.schedule_comments,
msdt.attribute1,
msdt.attribute2,
msdt.attribute3,
msdt.attribute4,
msdt.attribute5,
msdt.attribute6,
msdt.attribute7,
msdt.attribute8,
msdt.attribute9,
msdt.attribute10,
msdt.attribute11,
msdt.attribute12,
msdt.attribute13,
msdt.attribute14,
msdt.attribute15,
msdt.mps_transaction_id transaction_id,
to_number(null) upload_row
from
mtl_parameters mp,
mrp_schedule_designators msd,
mrp_schedule_dates msdt,
mtl_system_items_vl msiv
where
1=1 and
msd.organization_id=mp.organization_id and
msd.organization_id=msdt.organization_id and
msd.schedule_designator=msdt.schedule_designator and
msdt.schedule_level=2 and
msdt.organization_id=msiv.organization_id and
msdt.inventory_item_id=msiv.inventory_item_id