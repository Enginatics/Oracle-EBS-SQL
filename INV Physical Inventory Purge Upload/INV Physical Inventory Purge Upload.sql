/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: INV Physical Inventory Purge Upload
-- Description: This upload supports the purging of existing Physical Inventories. 

For each Physical Inventory to be purged the user can select to purge the tags only, or to purge the full Physical Inventory.

On upload, the upload process will submit the standard 'Purge physical inventory information' concurrent program for each Physical Inventory to be purged.

To improve performance of the upload process, the upload does not wait for completion of the purge concurrent requests before completing.

The ‘Create, Update’ upload mode can be used to first download the Physical Inventories to be purged for initial review and selection.

Alternatively, the ‘Create’ upload mode can be used to generate an empty upload excel into which the details of the Physical Inventories to be purged can be pasted. In this mode the only columns that need to be populated in the excel are the Organization Code, Physical Inventory Name, and the Purge Option. 

-- Excel Examle Output: https://www.enginatics.com/example/inv-physical-inventory-purge-upload/
-- Library Link: https://www.enginatics.com/reports/inv-physical-inventory-purge-upload/
-- Run Report: https://demo.enginatics.com/

select
case when :purge_option is not null then xxen_upload.action_meaning(xxen_upload.action_update) else null end action_,
case when :purge_option is not null then xxen_upload.status_meaning(xxen_upload.status_new) else null end status_,
case when :purge_option is not null then xxen_util.description('U_EXCEL_MSG_VALIDATION_PENDING','XXEN_REPORT_TRANSLATIONS',0) else null end message_,
null request_id_,
null modified_columns_,
to_number(null) upload_seq_,
mpiv.physical_inventory_id,
mp.organization_code,
mpiv.physical_inventory_name,
:purge_option purge_option,
mpiv.description,
mpiv.physical_inventory_date,
xxen_util.meaning(mpiv.snapshot_complete,'INV_YES_NO',3) snapshot_complete
from
mtl_physical_inventories_v mpiv,
mtl_parameters mp
where
1=1 and
mpiv.organization_id = mp.organization_id and
mpiv.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id)