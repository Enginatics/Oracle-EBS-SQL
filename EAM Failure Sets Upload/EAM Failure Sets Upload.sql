/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: EAM Failure Sets Upload
-- Description: EAM Failure Sets Upload
=======================
Creates and updates Oracle EAM (Enterprise Asset Management) Failure Sets, along with their Asset-Group Item Associations and Failure/Cause/Resolution Combinations.

One Set Name can own many child rows (Associations and Combinations). A SET row defines the header explicitly. For Create rows, the upload also creates the missing failure set header automatically from the first ASSOCIATION or COMBINATION row for that Set Name.

Row Type
--------
- SET: Creates or updates the failure set header (set_name, description, effective_end_date).
- ASSOCIATION: Links the set to an asset-group / rebuildable item. The item must have EAM_ITEM_TYPE in (1,3) and exist in the master item organization. On Create, this row can also create the failure set header if it does not exist yet.
- COMBINATION: Adds a valid Failure / Cause / Resolution code triple to the set. The individual codes must already exist in EAM Failure Codes setup (use the EAM Failure Codes Upload). On Create, this row can also create the failure set header if it does not exist yet.

Upload Mode
===========
- Create: opens an empty template. Enter a SET row per new failure set, or enter the first ASSOCIATION / COMBINATION row directly; the upload will create the missing header before processing the child row.
- Create, Update: downloads existing sets / associations / combinations for review or update.

Delete
======
- SET rows cannot be deleted directly (Oracle API does not ship Delete_FailureSet). End-date the set instead by setting Set Effective End Date.
- ASSOCIATION and COMBINATION rows can be deleted by setting Delete to Yes.

Dates
=====
Blanking Effective End Date on an update reactivates the ended record.
-- Excel Examle Output: https://www.enginatics.com/example/eam-failure-sets-upload/
-- Library Link: https://www.enginatics.com/reports/eam-failure-sets-upload/
-- Run Report: https://demo.enginatics.com/

select
x.*,
rownum upload_row
from
(
select
null action_,
null status_,
null message_,
null modified_columns_,
efs.set_name,
efs.description set_description,
efs.effective_end_date set_effective_end_date,
'SET' row_type,
cast(null as varchar2(240)) inventory_item,
cast(null as varchar2(10)) failure_code_required,
cast(null as date) association_effective_end_date,
cast(null as varchar2(80)) failure_code,
cast(null as varchar2(80)) cause_code,
cast(null as varchar2(80)) resolution_code,
cast(null as date) combination_effective_end_date,
cast(null as varchar2(10)) delete_record
from
eam_failure_sets efs
where
2=2
union all
select
null action_,
null status_,
null message_,
null modified_columns_,
efs.set_name,
cast(null as varchar2(240)) set_description,
cast(null as date) set_effective_end_date,
'ASSOCIATION' row_type,
msibk.concatenated_segments inventory_item,
decode(efsa.failure_code_required,'Y',xxen_util.meaning('Y','YES_NO',0)) failure_code_required,
efsa.effective_end_date association_effective_end_date,
cast(null as varchar2(80)) failure_code,
cast(null as varchar2(80)) cause_code,
cast(null as varchar2(80)) resolution_code,
cast(null as date) combination_effective_end_date,
cast(null as varchar2(10)) delete_record
from
eam_failure_sets efs,
eam_failure_set_associations efsa,
mtl_system_items_b_kfv msibk,
mtl_parameters mp
where
efs.set_id=efsa.set_id and
efsa.inventory_item_id=msibk.inventory_item_id and
msibk.organization_id=mp.organization_id and
mp.master_organization_id=mp.organization_id and
2=2
union all
select
null action_,
null status_,
null message_,
null modified_columns_,
efs.set_name,
cast(null as varchar2(240)) set_description,
cast(null as date) set_effective_end_date,
'COMBINATION' row_type,
cast(null as varchar2(240)) inventory_item,
cast(null as varchar2(10)) failure_code_required,
cast(null as date) association_effective_end_date,
efc.failure_code,
efc.cause_code,
efc.resolution_code,
efc.effective_end_date combination_effective_end_date,
cast(null as varchar2(10)) delete_record
from
eam_failure_sets efs,
eam_failure_combinations efc
where
efs.set_id=efc.set_id and
2=2
) x