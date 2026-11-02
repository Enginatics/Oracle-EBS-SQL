/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: Blitz Upload Example (API without parameters)
-- Description: Example upload to copy (Tools>Copy Report) when creating an upload whose API processes all uploaded rows in one call, without parameters.
-- The upload framework calls the API once. The API reads the valid rows from the upload's data view, shown in the Data View field of the setup window, and writes each row's status and message back to it. For this upload: select from xxenblitzuploadexamp9718u xu where xu.statuscode=xxenupload.statusvalid
-- A copied upload has its own data view, so replace the view name in the copied API.
-- Excel Example Output: https://www.enginatics.com/example/blitz-upload-example-api-without-parameters/
-- Library Link: https://www.enginatics.com/reports/blitz-upload-example-api-without-parameters/
-- Run Report: https://demo.enginatics.com/

select
null action_,
null status_,
null message_,
null modified_columns_,
xue.id,
xue.name,
xue.date_of_birth,
to_number(null) upload_row
from
xxen_upload_example xue
where
1=1
