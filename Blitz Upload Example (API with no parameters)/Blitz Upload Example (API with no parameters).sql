/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: Blitz Upload Example (API with no parameters)
-- Description: Example upload, which can be used as a template by copying (Tools>Copy Report) to create new uploads using an API with no parameters. This API will be called just once by the upload framework and all the uploaded records can be accessed within the API by selecting them from the Data View eg: select * from xxen_blitz_upload_examp_9718_u xu where xu.status_code_=xxen_upload.status_valid
-- Excel Examle Output: https://www.enginatics.com/example/blitz-upload-example-api-with-no-parameters/
-- Library Link: https://www.enginatics.com/reports/blitz-upload-example-api-with-no-parameters/
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