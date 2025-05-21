/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: Blitz Upload Example (API)
-- Description: Example upload, which can be used as a template by copying (Tools>Copy Report) to create new uploads using an API.
-- Excel Examle Output: https://www.enginatics.com/example/blitz-upload-example-api/
-- Library Link: https://www.enginatics.com/reports/blitz-upload-example-api/
-- Run Report: https://demo.enginatics.com/

select
null action_,
null status_,
null message_,
null modified_columns_,
xue.id,
xue.name,
xue.date_of_birth
from
xxen_upload_example xue
where
1=1