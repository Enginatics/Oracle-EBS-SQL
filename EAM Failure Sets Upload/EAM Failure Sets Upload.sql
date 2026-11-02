/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: EAM Failure Sets Upload
-- Description: Create and update EAM failure sets with their asset group and rebuildable item associations and their failure, cause and resolution code combinations. One row is one SET, ASSOCIATION or COMBINATION, and the rows of a set share its Set Name.
-- A new ASSOCIATION or COMBINATION row creates its failure set when no set of that name exists, from the row's Set Description and Set Effective End Date.
-- The associated item is an asset group or rebuildable item of a master organization. The codes of a combination must exist (EAM Failure Codes Upload).
-- A failure set cannot be deleted; end-date it with Set Effective End Date, and clear the date to reactivate it. Delete Record ends an association or deletes a combination.
-- Excel Example Output: https://www.enginatics.com/example/eam-failure-sets-upload/
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
(select msibk.concatenated_segments from mtl_system_items_b_kfv msibk where efsa.inventory_item_id=msibk.inventory_item_id and rownum=1) inventory_item,
decode(efsa.failure_code_required,'Y',xxen_util.meaning('Y','YES_NO',0)) failure_code_required,
efsa.effective_end_date association_effective_end_date,
cast(null as varchar2(80)) failure_code,
cast(null as varchar2(80)) cause_code,
cast(null as varchar2(80)) resolution_code,
cast(null as date) combination_effective_end_date,
cast(null as varchar2(10)) delete_record
from
eam_failure_sets efs,
eam_failure_set_associations efsa
where
efs.set_id=efsa.set_id and
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
where
1=1
