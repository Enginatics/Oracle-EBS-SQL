/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: AR AutoAccounting Upload
-- Description: Creates and updates the Receivables AutoAccounting definitions - the Excel equivalent of the Automatic Accounting form (Setup > Transactions > AutoAccounting).
-- Each row is one segment of the chart of accounts of an AutoAccounting type, with the operating unit and type repeated on every row. Enter either a Table Name, from which AutoAccounting takes the segment value, or a Constant.
-- Each type is saved as a whole: after the upload, every enabled segment of the chart of accounts must have a table name or constant, and a dependent segment must use the table name of its parent segment or a constant valid for the parent constant. Otherwise none of the type's rows are saved. To define a new type, enter one row per segment. The type's descriptive flexfield values are taken from its first row.
-- Changing the balancing segment of the Revenue or Receivable type also changes the balancing segment of the Tax, Freight, Unbilled Receivable, Unearned Revenue and AutoInvoice Clearing types, as in the form.
-- Excel Example Output: https://www.enginatics.com/example/ar-autoaccounting-upload/
-- Library Link: https://www.enginatics.com/reports/ar-autoaccounting-upload/
-- Run Report: https://demo.enginatics.com/

select
null action_,
null status_,
null message_,
null modified_columns_,
hou.name operating_unit,
xxen_util.meaning(rad.type,'AUTOGL_TYPE',222) type,
xxen_util.display_flexfield_context(222,'RA_ACCOUNT_DEFAULTS',rad.attribute_category) type_attribute_category,
xxen_util.display_flexfield_value(222,'RA_ACCOUNT_DEFAULTS',rad.attribute_category,'ATTRIBUTE1',rad.rowid,rad.attribute1) type_attribute1,
xxen_util.display_flexfield_value(222,'RA_ACCOUNT_DEFAULTS',rad.attribute_category,'ATTRIBUTE2',rad.rowid,rad.attribute2) type_attribute2,
xxen_util.display_flexfield_value(222,'RA_ACCOUNT_DEFAULTS',rad.attribute_category,'ATTRIBUTE3',rad.rowid,rad.attribute3) type_attribute3,
xxen_util.display_flexfield_value(222,'RA_ACCOUNT_DEFAULTS',rad.attribute_category,'ATTRIBUTE4',rad.rowid,rad.attribute4) type_attribute4,
xxen_util.display_flexfield_value(222,'RA_ACCOUNT_DEFAULTS',rad.attribute_category,'ATTRIBUTE5',rad.rowid,rad.attribute5) type_attribute5,
xxen_util.display_flexfield_value(222,'RA_ACCOUNT_DEFAULTS',rad.attribute_category,'ATTRIBUTE6',rad.rowid,rad.attribute6) type_attribute6,
xxen_util.display_flexfield_value(222,'RA_ACCOUNT_DEFAULTS',rad.attribute_category,'ATTRIBUTE7',rad.rowid,rad.attribute7) type_attribute7,
xxen_util.display_flexfield_value(222,'RA_ACCOUNT_DEFAULTS',rad.attribute_category,'ATTRIBUTE8',rad.rowid,rad.attribute8) type_attribute8,
xxen_util.display_flexfield_value(222,'RA_ACCOUNT_DEFAULTS',rad.attribute_category,'ATTRIBUTE9',rad.rowid,rad.attribute9) type_attribute9,
xxen_util.display_flexfield_value(222,'RA_ACCOUNT_DEFAULTS',rad.attribute_category,'ATTRIBUTE10',rad.rowid,rad.attribute10) type_attribute10,
xxen_util.display_flexfield_value(222,'RA_ACCOUNT_DEFAULTS',rad.attribute_category,'ATTRIBUTE11',rad.rowid,rad.attribute11) type_attribute11,
xxen_util.display_flexfield_value(222,'RA_ACCOUNT_DEFAULTS',rad.attribute_category,'ATTRIBUTE12',rad.rowid,rad.attribute12) type_attribute12,
xxen_util.display_flexfield_value(222,'RA_ACCOUNT_DEFAULTS',rad.attribute_category,'ATTRIBUTE13',rad.rowid,rad.attribute13) type_attribute13,
xxen_util.display_flexfield_value(222,'RA_ACCOUNT_DEFAULTS',rad.attribute_category,'ATTRIBUTE14',rad.rowid,rad.attribute14) type_attribute14,
xxen_util.display_flexfield_value(222,'RA_ACCOUNT_DEFAULTS',rad.attribute_category,'ATTRIBUTE15',rad.rowid,rad.attribute15) type_attribute15,
fifsv.segment_name segment,
xxen_util.meaning(rads.table_name,'AUTOGL_TABLES',222) table_name,
rads.constant,
(select min(ffvv.description) from fnd_flex_values_vl ffvv where fifsv.flex_value_set_id=ffvv.flex_value_set_id and rads.constant=ffvv.flex_value) description,
xxen_util.display_flexfield_context(222,'RA_ACCOUNT_DEFAULT_SEGMENTS',rads.attribute_category) seg_attribute_category,
xxen_util.display_flexfield_value(222,'RA_ACCOUNT_DEFAULT_SEGMENTS',rads.attribute_category,'ATTRIBUTE1',rads.rowid,rads.attribute1) seg_attribute1,
xxen_util.display_flexfield_value(222,'RA_ACCOUNT_DEFAULT_SEGMENTS',rads.attribute_category,'ATTRIBUTE2',rads.rowid,rads.attribute2) seg_attribute2,
xxen_util.display_flexfield_value(222,'RA_ACCOUNT_DEFAULT_SEGMENTS',rads.attribute_category,'ATTRIBUTE3',rads.rowid,rads.attribute3) seg_attribute3,
xxen_util.display_flexfield_value(222,'RA_ACCOUNT_DEFAULT_SEGMENTS',rads.attribute_category,'ATTRIBUTE4',rads.rowid,rads.attribute4) seg_attribute4,
xxen_util.display_flexfield_value(222,'RA_ACCOUNT_DEFAULT_SEGMENTS',rads.attribute_category,'ATTRIBUTE5',rads.rowid,rads.attribute5) seg_attribute5,
xxen_util.display_flexfield_value(222,'RA_ACCOUNT_DEFAULT_SEGMENTS',rads.attribute_category,'ATTRIBUTE6',rads.rowid,rads.attribute6) seg_attribute6,
xxen_util.display_flexfield_value(222,'RA_ACCOUNT_DEFAULT_SEGMENTS',rads.attribute_category,'ATTRIBUTE7',rads.rowid,rads.attribute7) seg_attribute7,
xxen_util.display_flexfield_value(222,'RA_ACCOUNT_DEFAULT_SEGMENTS',rads.attribute_category,'ATTRIBUTE8',rads.rowid,rads.attribute8) seg_attribute8,
xxen_util.display_flexfield_value(222,'RA_ACCOUNT_DEFAULT_SEGMENTS',rads.attribute_category,'ATTRIBUTE9',rads.rowid,rads.attribute9) seg_attribute9,
xxen_util.display_flexfield_value(222,'RA_ACCOUNT_DEFAULT_SEGMENTS',rads.attribute_category,'ATTRIBUTE10',rads.rowid,rads.attribute10) seg_attribute10,
xxen_util.display_flexfield_value(222,'RA_ACCOUNT_DEFAULT_SEGMENTS',rads.attribute_category,'ATTRIBUTE11',rads.rowid,rads.attribute11) seg_attribute11,
xxen_util.display_flexfield_value(222,'RA_ACCOUNT_DEFAULT_SEGMENTS',rads.attribute_category,'ATTRIBUTE12',rads.rowid,rads.attribute12) seg_attribute12,
xxen_util.display_flexfield_value(222,'RA_ACCOUNT_DEFAULT_SEGMENTS',rads.attribute_category,'ATTRIBUTE13',rads.rowid,rads.attribute13) seg_attribute13,
xxen_util.display_flexfield_value(222,'RA_ACCOUNT_DEFAULT_SEGMENTS',rads.attribute_category,'ATTRIBUTE14',rads.rowid,rads.attribute14) seg_attribute14,
xxen_util.display_flexfield_value(222,'RA_ACCOUNT_DEFAULT_SEGMENTS',rads.attribute_category,'ATTRIBUTE15',rads.rowid,rads.attribute15) seg_attribute15,
rad.gl_default_id,
rads.segment_num,
null upload_row
from
ra_account_defaults_all rad,
hr_operating_units hou,
ar_system_parameters_all aspa,
gl_ledgers gl,
ra_account_default_segments rads,
fnd_id_flex_segments_vl fifsv
where
1=1 and
rad.org_id in (select mgoat.organization_id from mo_glob_org_access_tmp mgoat) and
rad.org_id=hou.organization_id and
rad.org_id=aspa.org_id and
aspa.set_of_books_id=gl.ledger_id and
rad.gl_default_id=rads.gl_default_id and
gl.chart_of_accounts_id=fifsv.id_flex_num and
fifsv.application_id=101 and
fifsv.id_flex_code='GL#' and
rads.segment=fifsv.application_column_name
