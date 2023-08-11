/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2023 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: GL Daily Rates Upload
-- Description: GL Daily Rates Upload
==================
Use this upload to upload new or update existing GL Daily Exchange Rate Conversions.
If exchange rates do not already exist for the entered data, they will be created.
If exchange rates do already exist for the entered data, they will be updated.
-- Excel Examle Output: https://www.enginatics.com/example/gl-daily-rates-upload/
-- Library Link: https://www.enginatics.com/reports/gl-daily-rates-upload/
-- Run Report: https://demo.enginatics.com/

select
x.*
from
(
select
null action_,
null status_,
null message_,
null request_id_,
null row_id,
gdr.from_currency,
gdr.to_currency,
gdct.user_conversion_type,
to_char(gdr.conversion_date,'DD-Mon-YYYY') from_conversion_date,
to_char(gdr.conversion_date,'DD-Mon-YYYY') to_conversion_date,
gdr.conversion_rate,
1/gdr.conversion_rate inverse_conversion_rate,
gdr.context attribute_context,
gdr.attribute1,
gdr.attribute2,
gdr.attribute3,
gdr.attribute4,
gdr.attribute5,
gdr.attribute6,
gdr.attribute7,
gdr.attribute8,
gdr.attribute9,
gdr.attribute10,
gdr.attribute11,
gdr.attribute12,
gdr.attribute13,
gdr.attribute14,
gdr.attribute15,
fu.user_name created_by,
to_char(gdr.creation_date,'DD-Mon-YYYY') creation_date,
null batch_number,
xxen_util.meaning('I','GL_CRM_DR_MODE_FLAG',101) mode_flag,
'N' launch_rate_change
from
gl_daily_rates gdr,
gl_daily_conversion_types gdct,
fnd_user fu
where
:p_upload_mode is null and
:p_action = :p_action and
nvl(:p_user_conv_type,'?') = nvl(:p_user_conv_type,'?') and
1=1 and
gdr.conversion_type = gdct.conversion_type and
gdr.created_by = fu.user_id
&not_use_first_block
&report_table_select
&report_table_name
&report_table_where_clause
&success_query
&processed_run
) x
order by
x.from_currency,
x.to_currency,
x.user_conversion_type,
to_date(x.from_conversion_date,'DD-Mon-YYYY'),
to_date(x.to_conversion_date,'DD-Mon-YYYY')