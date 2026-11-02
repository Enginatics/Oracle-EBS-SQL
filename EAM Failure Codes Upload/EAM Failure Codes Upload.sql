/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: EAM Failure Codes Upload
-- Description: Create, update and delete EAM failure codes, cause codes and resolution codes. Codes are global, not specific to an organization, and a code is unique within its Code Type.
-- Effective End Date end-dates a code. Clearing it reactivates an end-dated code.
-- Delete Record deletes an existing code.
-- Excel Example Output: https://www.enginatics.com/example/eam-failure-codes-upload/
-- Library Link: https://www.enginatics.com/reports/eam-failure-codes-upload/
-- Run Report: https://demo.enginatics.com/

select
null action_,
null status_,
null message_,
null modified_columns_,
xxen_util.meaning(x.code_type,'EAM_FAILURE_CODE_TYPE',700) code_type,
x.code,
x.description,
x.effective_end_date,
to_char(null) delete_record,
x.upload_row
from
(
select
'10' code_type,
efc.failure_code code,
efc.description,
efc.effective_end_date,
rownum upload_row
from
eam_failure_codes efc
where
1=1 and
:p_upload_mode like '%' || xxen_upload.action_update and
(:p_code_type is null or :p_code_type='10')
union all
select
'20' code_type,
ecc.cause_code,
ecc.description,
ecc.effective_end_date,
rownum upload_row
from
eam_cause_codes ecc
where
1=1 and
:p_upload_mode like '%' || xxen_upload.action_update and
(:p_code_type is null or :p_code_type='20')
union all
select
'30' code_type,
erc.resolution_code,
erc.description,
erc.effective_end_date,
rownum upload_row
from
eam_resolution_codes erc
where
1=1 and
:p_upload_mode like '%' || xxen_upload.action_update and
(:p_code_type is null or :p_code_type='30')
) x
