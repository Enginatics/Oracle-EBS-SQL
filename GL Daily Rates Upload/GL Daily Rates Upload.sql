/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
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
null action_,
null status_,
null message_,
null request_id_,
null modified_columns_,
null row_id,
gdr.from_currency,
gdr.to_currency,
gdct.user_conversion_type,
gdr.conversion_date from_conversion_date,
gdr.conversion_date to_conversion_date,
gdr.conversion_rate,
1/gdr.conversion_rate inverse_conversion_rate,
xxen_util.display_flexfield_context(101,'GL_DAILY_RATES',gdr.context) attribute_context,
xxen_util.display_flexfield_value(101,'GL_DAILY_RATES',gdr.context,'ATTRIBUTE1',gdr.rowid,gdr.attribute1) gl_daily_rate_attribute1,
xxen_util.display_flexfield_value(101,'GL_DAILY_RATES',gdr.context,'ATTRIBUTE2',gdr.rowid,gdr.attribute2) gl_daily_rate_attribute2,
xxen_util.display_flexfield_value(101,'GL_DAILY_RATES',gdr.context,'ATTRIBUTE3',gdr.rowid,gdr.attribute3) gl_daily_rate_attribute3,
xxen_util.display_flexfield_value(101,'GL_DAILY_RATES',gdr.context,'ATTRIBUTE4',gdr.rowid,gdr.attribute4) gl_daily_rate_attribute4,
xxen_util.display_flexfield_value(101,'GL_DAILY_RATES',gdr.context,'ATTRIBUTE5',gdr.rowid,gdr.attribute5) gl_daily_rate_attribute5,
xxen_util.display_flexfield_value(101,'GL_DAILY_RATES',gdr.context,'ATTRIBUTE6',gdr.rowid,gdr.attribute6) gl_daily_rate_attribute6,
xxen_util.display_flexfield_value(101,'GL_DAILY_RATES',gdr.context,'ATTRIBUTE7',gdr.rowid,gdr.attribute7) gl_daily_rate_attribute7,
xxen_util.display_flexfield_value(101,'GL_DAILY_RATES',gdr.context,'ATTRIBUTE8',gdr.rowid,gdr.attribute8) gl_daily_rate_attribute8,
xxen_util.display_flexfield_value(101,'GL_DAILY_RATES',gdr.context,'ATTRIBUTE9',gdr.rowid,gdr.attribute9) gl_daily_rate_attribute9,
xxen_util.display_flexfield_value(101,'GL_DAILY_RATES',gdr.context,'ATTRIBUTE10',gdr.rowid,gdr.attribute10) gl_daily_rate_attribute10,
xxen_util.display_flexfield_value(101,'GL_DAILY_RATES',gdr.context,'ATTRIBUTE11',gdr.rowid,gdr.attribute11) gl_daily_rate_attribute11,
xxen_util.display_flexfield_value(101,'GL_DAILY_RATES',gdr.context,'ATTRIBUTE12',gdr.rowid,gdr.attribute12) gl_daily_rate_attribute12,
xxen_util.display_flexfield_value(101,'GL_DAILY_RATES',gdr.context,'ATTRIBUTE13',gdr.rowid,gdr.attribute13) gl_daily_rate_attribute13,
xxen_util.display_flexfield_value(101,'GL_DAILY_RATES',gdr.context,'ATTRIBUTE14',gdr.rowid,gdr.attribute14) gl_daily_rate_attribute14,
xxen_util.display_flexfield_value(101,'GL_DAILY_RATES',gdr.context,'ATTRIBUTE15',gdr.rowid,gdr.attribute15) gl_daily_rate_attribute15,
fu.user_name created_by,
gdr.creation_date creation_date,
null batch_number,
xxen_util.meaning('I','GL_CRM_DR_MODE_FLAG',101) mode_flag,
xxen_util.meaning('N','YES_NO',0) launch_rate_change
from
gl_daily_rates gdr,
gl_daily_conversion_types gdct,
fnd_user fu
where
1=1 and
:p_upload_mode like '%' || xxen_upload.action_update and
nvl(:p_user_conv_type,'?') = nvl(:p_user_conv_type,'?') and
gdr.conversion_type = gdct.conversion_type and
gdr.created_by = fu.user_id (+)