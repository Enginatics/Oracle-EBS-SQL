/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2023 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: FND Lookup Upload
-- Description: This upload allows the user to
- download and update lookup codes against existing Lookup Types.
- add new lookup codes to existing Lookup Types.
- create new Lookup Types and upload the lookup codes against these new Lookup Types. 

The upload of FND Lookup Types and Lookup Codes is in the users current language.

Only User and Extensible Lookup Types can be maintained by this upload.
For Extensible Lookup Types, seeded Lookup Codes canot be updated.

For Creating/Updating Lookup Codes only against an existing Lookup Type, use template: 
Lookup Codes - Create/Update Lookup Codes only

For Creating New Lookup Types and/or updating Lookup Type level information, as well as the Lookup Codes, use  template:
Lookup Types - Create/Update Lookup Types and Codes
-- Excel Examle Output: https://www.enginatics.com/example/fnd-lookup-upload/
-- Library Link: https://www.enginatics.com/reports/fnd-lookup-upload/
-- Run Report: https://demo.enginatics.com/

select
null action_,
null status_,
null message_,
null request_id_,
to_char(null) mode_,
fltv.lookup_type,
fav1.application_name view_application,
fltv.meaning type_meaning,
fltv.description type_description,
fav2.application_name owning_application,
flvv.lookup_code,
flvv.meaning,
flvv.description,
flvv.tag,
xxen_util.meaning(flvv.enabled_flag,'YES_NO',0) enabled_flag,
to_char(flvv.start_date_active,'DD-Mon-YYYY') start_date_active,
to_char(flvv.end_date_active,'DD-Mon-YYYY') end_date_active,
flvv.attribute_category,
flvv.attribute1,
flvv.attribute2,
flvv.attribute3,
flvv.attribute4,
flvv.attribute5,
flvv.attribute6,
flvv.attribute7,
flvv.attribute8,
flvv.attribute9,
flvv.attribute10,
flvv.attribute11,
flvv.attribute12,
flvv.attribute13,
flvv.attribute14,
flvv.attribute15,
flvv.territory_code,
fsg.security_group_key security_group,
fav1.application_short_name || ':' || fltv.lookup_type old_lookup_type_key,
flvv.lookup_code old_lookup_code
from
  fnd_lookup_types_vl  fltv,
  fnd_lookup_values_vl flvv,
  fnd_application_vl   fav1,
  fnd_application_vl   fav2,
  fnd_security_groups  fsg
where
    :p_mode in ('Create and Update','Update')
and fav1.application_name=:p_view_appl
and 1=1
and fltv.view_application_id   = fav1.application_id
and fltv.application_id        = fav2.application_id
and fltv.security_group_id     = fsg.security_group_id
and fltv.customization_level  in ('U','E')
and fltv.security_group_id     = fnd_global.security_group_id
and fltv.lookup_type           = flvv.lookup_type
and fltv.view_application_id   = flvv.view_application_id
and fltv.security_group_id     = flvv.security_group_id
&not_use_first_block
&report_table_select &report_table_name &report_table_where_clause &success_records
&processed_run
order by
 lookup_type,
 lookup_code