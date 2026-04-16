/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: JA India Third Party Registration Upload
-- Description: JA India Third Party Registration Upload
=========================================
Use this upload to create or update India Localization Third Party Registrations for customers and suppliers, including tax/registration identifiers such as PAN, TAN, TIN, GST, Service Tax, and other India-specific registration numbers.

This upload also supports Reporting Codes linked to Third Party Registrations.

NOTE: If you are creating new records for a third party, enter and upload all Registration records first, and then enter and upload the Reporting Code records.

Available columns:
1.Record Type: Select either Registration or Reporting Code. This determines whether you are creating/updating a registration record or a reporting code record.
2.Operating Unit: Select the Operating Unit to retrieve the list of party sites for that OU, or leave blank if you are entering a registration without a site (null site registration).
3.Party Type: Select Supplier or Customer. The available Party Numbers depend on this selection.
4.Party Number: Enter the Supplier Number or Customer Number. You can use the list of values (LOV); entering a few starting characters/numbers helps narrow the list.
5.Party Name: Auto-populates after you enter the Party Number. You can also use the LOV to search by Supplier/Customer name; the LOV displays the Party Number as well.
6.Party Site Name: Select the Party Site based on the Operating Unit. Leave blank for a null site registration.
7.Registration Regime Code, Registration Type, Registration Number, Secondary Registration Type, Secondary Registration Number: Enter these fields to create/update a party registration. These fields are available only when Record Type = Registration.
8.Assessable Price List: Enter an Assessable Price List when the selected Regime Code is a Non-TDS Regime. Available only when Record Type = Registration.
9.Default TDS Section: Enter a Default TDS Section code when the selected Regime Code is a TDS Regime. Available only when Record Type = Registration.
10.Registration Start Date, Registration End Date: Enter the effective dates for the registration. The Start Date defaults to 01-Jul-2017 (GST implementation date in India), but you can change it as needed.
11.Reporting Code Regime Code, Reporting Code Type, Reporting Code: Enter these fields to create/update a reporting code for the registration. These fields are available only when Record Type = Reporting Code.
12.Reporting Code Start Date, Reporting Code End Date: Enter the effective dates for the reporting code. The Start Date defaults to 01-Jul-2017, but you can change it as needed.

-- Excel Examle Output: https://www.enginatics.com/example/ja-india-third-party-registration-upload/
-- Library Link: https://www.enginatics.com/reports/ja-india-third-party-registration-upload/
-- Run Report: https://demo.enginatics.com/

select
null action_,
null status_,
null message_,
null modified_columns_,
'Registration' record_type,
jprv.party_reg_id,
jprlv.party_reg_line_id,
to_number(null) reporting_association_id,
jprv.operating_unit,
jprv.party_class_name party_type,
jprv.party_number,
jprv.party_name,
jprv.party_site_name,
jprlv.regime_code registration_regime_code,
jprlv.registration_type_name registration_type,
jprlv.registration_number,
jprlv.sec_registration_type_name secondary_registration_type,
jprlv.secondary_registration_number,
jprlv.assessable_price_list_name assessable_price_list,
jprlv.default_section_name default_tds_section,
jprlv.effective_from registration_start_date,
jprlv.effective_to registration_end_date,
to_char(null) reporting_code_regime_code,
to_char(null) reporting_code_type,
to_char(null) reporting_code,
to_date(null) reporting_code_start_date,
to_date(null) reporting_code_end_date
from
jai_party_regs_v jprv,
jai_party_reg_lines_v jprlv
where
1=1 and
jprv.reg_class_code='THIRD_PARTY' and
jprv.party_reg_id=jprlv.party_reg_id
union all
select
null action_,
null status_,
null message_,
null modified_columns_,
'Reporting Code' record_type,
jprv.party_reg_id,
to_number(null) party_reg_line_id,
jrav.reporting_association_id,
jprv.operating_unit,
jprv.party_class_name party_type,
jprv.party_number,
jprv.party_name,
jprv.party_site_name,
to_char(null) registration_regime_code,
to_char(null) registration_type,
to_char(null) registration_number,
to_char(null) secondary_registration_type,
to_char(null) secondary_registration_number,
to_char(null) assessable_price_list,
to_char(null) default_tds_section,
to_date(null) registration_start_date,
to_date(null) registration_end_date,
jrav.regime_code reporting_code_regime_code,
jrav.reporting_type_name reporting_code_type,
jrav.reporting_code,
jrav.effective_from reporting_code_start_date,
jrav.effective_to reporting_code_end_date
from
jai_party_regs_v jprv,
jai_reporting_associations_v jrav
where
1=1 and
jprv.reg_class_code='THIRD_PARTY' and
jprv.party_reg_id=jrav.entity_id and
jrav.entity_code='THIRD_PARTY'
order by
party_type,
party_number,
record_type,
party_reg_id,
party_reg_line_id nulls last,
reporting_association_id