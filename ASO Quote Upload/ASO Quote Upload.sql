/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: ASO Quote Upload
-- Description: Creates and updates Oracle Quoting quotes (Quoting form and Quoting HTML) with their lines through the Oracle quote api, which prices the quote and calculates tax as the Quoting form does when a quote is saved.
-- One row per quote line. The header values repeat on every row of a quote and are applied from the first row of each quote in the file. Rows are grouped into one quote by Operating Unit and Upload Quote Identifier: the quote number for an existing quote, any text such as new1 for a new quote. A row without an item creates or updates the quote header only.
-- Unit Selling Price overrides the calculated price with a manual adjustment. Unit % Adjustment sets the selling price as a percentage of the unit list price, negative for a discount. Delete Line removes a line from the quote.
-- The download lists the latest version of quotes in statuses that allow updates. Updates do not create a new quote version. The quote api checks the quote access of the uploading user, who must be set up as a resource on the quote's sales team when Quoting security is enabled.
-- Excel Example Output: https://www.enginatics.com/example/aso-quote-upload/
-- Library Link: https://www.enginatics.com/reports/aso-quote-upload/
-- Run Report: https://demo.enginatics.com/

select
null action_,
null status_,
null message_,
null modified_columns_,
haouv.name operating_unit,
to_char(aqha.quote_number) upload_quote_identifier,
aqha.quote_name,
aqha.quote_number,
aqha.quote_version,
hp.party_name customer,
hca.account_number,
aqsv.meaning quote_status,
aqha.quote_expiration_date expiration_date,
xxen_aso_upload.salesperson(aqha.resource_id,aqha.org_id) salesperson,
ottt.name order_type,
qlhv.name price_list,
aqha.currency_code currency,
xxen_util.display_flexfield_context(697,'ASO_HEADER_ATTRIBUTES',aqha.attribute_category) quote_attribute_category,
xxen_util.display_flexfield_value(697,'ASO_HEADER_ATTRIBUTES',aqha.attribute_category,'ATTRIBUTE1',aqha.rowid,aqha.attribute1) quote_attribute1,
xxen_util.display_flexfield_value(697,'ASO_HEADER_ATTRIBUTES',aqha.attribute_category,'ATTRIBUTE2',aqha.rowid,aqha.attribute2) quote_attribute2,
xxen_util.display_flexfield_value(697,'ASO_HEADER_ATTRIBUTES',aqha.attribute_category,'ATTRIBUTE3',aqha.rowid,aqha.attribute3) quote_attribute3,
xxen_util.display_flexfield_value(697,'ASO_HEADER_ATTRIBUTES',aqha.attribute_category,'ATTRIBUTE4',aqha.rowid,aqha.attribute4) quote_attribute4,
xxen_util.display_flexfield_value(697,'ASO_HEADER_ATTRIBUTES',aqha.attribute_category,'ATTRIBUTE5',aqha.rowid,aqha.attribute5) quote_attribute5,
xxen_util.display_flexfield_value(697,'ASO_HEADER_ATTRIBUTES',aqha.attribute_category,'ATTRIBUTE6',aqha.rowid,aqha.attribute6) quote_attribute6,
xxen_util.display_flexfield_value(697,'ASO_HEADER_ATTRIBUTES',aqha.attribute_category,'ATTRIBUTE7',aqha.rowid,aqha.attribute7) quote_attribute7,
xxen_util.display_flexfield_value(697,'ASO_HEADER_ATTRIBUTES',aqha.attribute_category,'ATTRIBUTE8',aqha.rowid,aqha.attribute8) quote_attribute8,
xxen_util.display_flexfield_value(697,'ASO_HEADER_ATTRIBUTES',aqha.attribute_category,'ATTRIBUTE9',aqha.rowid,aqha.attribute9) quote_attribute9,
xxen_util.display_flexfield_value(697,'ASO_HEADER_ATTRIBUTES',aqha.attribute_category,'ATTRIBUTE10',aqha.rowid,aqha.attribute10) quote_attribute10,
xxen_util.display_flexfield_value(697,'ASO_HEADER_ATTRIBUTES',aqha.attribute_category,'ATTRIBUTE11',aqha.rowid,aqha.attribute11) quote_attribute11,
xxen_util.display_flexfield_value(697,'ASO_HEADER_ATTRIBUTES',aqha.attribute_category,'ATTRIBUTE12',aqha.rowid,aqha.attribute12) quote_attribute12,
xxen_util.display_flexfield_value(697,'ASO_HEADER_ATTRIBUTES',aqha.attribute_category,'ATTRIBUTE13',aqha.rowid,aqha.attribute13) quote_attribute13,
xxen_util.display_flexfield_value(697,'ASO_HEADER_ATTRIBUTES',aqha.attribute_category,'ATTRIBUTE14',aqha.rowid,aqha.attribute14) quote_attribute14,
xxen_util.display_flexfield_value(697,'ASO_HEADER_ATTRIBUTES',aqha.attribute_category,'ATTRIBUTE15',aqha.rowid,aqha.attribute15) quote_attribute15,
case when aqla.quote_line_id is not null then dense_rank() over (partition by aqla.quote_header_id order by aqla.line_number) end line_number,
msiv.concatenated_segments item,
msiv.description item_description,
aqla.quantity,
aqla.uom_code uom,
aqla.line_list_price unit_list_price,
aqla.line_adjusted_amount unit_adjustment,
aqla.line_adjusted_percent unit_adjustment_percent,
aqla.line_quote_price unit_selling_price,
aqla.quantity*aqla.line_quote_price total_price,
null delete_line,
xxen_util.display_flexfield_context(697,'ASO_LINE_ATTRIBUTES',aqla.attribute_category) line_attribute_category,
xxen_util.display_flexfield_value(697,'ASO_LINE_ATTRIBUTES',aqla.attribute_category,'ATTRIBUTE1',aqla.rowid,aqla.attribute1) line_attribute1,
xxen_util.display_flexfield_value(697,'ASO_LINE_ATTRIBUTES',aqla.attribute_category,'ATTRIBUTE2',aqla.rowid,aqla.attribute2) line_attribute2,
xxen_util.display_flexfield_value(697,'ASO_LINE_ATTRIBUTES',aqla.attribute_category,'ATTRIBUTE3',aqla.rowid,aqla.attribute3) line_attribute3,
xxen_util.display_flexfield_value(697,'ASO_LINE_ATTRIBUTES',aqla.attribute_category,'ATTRIBUTE4',aqla.rowid,aqla.attribute4) line_attribute4,
xxen_util.display_flexfield_value(697,'ASO_LINE_ATTRIBUTES',aqla.attribute_category,'ATTRIBUTE5',aqla.rowid,aqla.attribute5) line_attribute5,
xxen_util.display_flexfield_value(697,'ASO_LINE_ATTRIBUTES',aqla.attribute_category,'ATTRIBUTE6',aqla.rowid,aqla.attribute6) line_attribute6,
xxen_util.display_flexfield_value(697,'ASO_LINE_ATTRIBUTES',aqla.attribute_category,'ATTRIBUTE7',aqla.rowid,aqla.attribute7) line_attribute7,
xxen_util.display_flexfield_value(697,'ASO_LINE_ATTRIBUTES',aqla.attribute_category,'ATTRIBUTE8',aqla.rowid,aqla.attribute8) line_attribute8,
xxen_util.display_flexfield_value(697,'ASO_LINE_ATTRIBUTES',aqla.attribute_category,'ATTRIBUTE9',aqla.rowid,aqla.attribute9) line_attribute9,
xxen_util.display_flexfield_value(697,'ASO_LINE_ATTRIBUTES',aqla.attribute_category,'ATTRIBUTE10',aqla.rowid,aqla.attribute10) line_attribute10,
xxen_util.display_flexfield_value(697,'ASO_LINE_ATTRIBUTES',aqla.attribute_category,'ATTRIBUTE11',aqla.rowid,aqla.attribute11) line_attribute11,
xxen_util.display_flexfield_value(697,'ASO_LINE_ATTRIBUTES',aqla.attribute_category,'ATTRIBUTE12',aqla.rowid,aqla.attribute12) line_attribute12,
xxen_util.display_flexfield_value(697,'ASO_LINE_ATTRIBUTES',aqla.attribute_category,'ATTRIBUTE13',aqla.rowid,aqla.attribute13) line_attribute13,
xxen_util.display_flexfield_value(697,'ASO_LINE_ATTRIBUTES',aqla.attribute_category,'ATTRIBUTE14',aqla.rowid,aqla.attribute14) line_attribute14,
xxen_util.display_flexfield_value(697,'ASO_LINE_ATTRIBUTES',aqla.attribute_category,'ATTRIBUTE15',aqla.rowid,aqla.attribute15) line_attribute15,
aqla.quote_line_id,
null upload_row
from
aso_quote_headers_all aqha,
hr_all_organization_units_vl haouv,
aso_quote_statuses_vl aqsv,
hz_cust_accounts hca,
hz_parties hp,
oe_transaction_types_tl ottt,
qp_list_headers_vl qlhv,
aso_quote_lines_all aqla,
mtl_system_items_vl msiv
where
1=1 and
aqha.max_version_flag='Y' and
aqha.org_id in (select mgoat.organization_id from mo_glob_org_access_tmp mgoat) and
aqha.org_id=haouv.organization_id and
aqha.quote_status_id=aqsv.quote_status_id and
aqsv.update_allowed_flag='Y' and
aqha.cust_account_id=hca.cust_account_id(+) and
aqha.cust_party_id=hp.party_id(+) and
aqha.order_type_id=ottt.transaction_type_id(+) and
ottt.language(+)=userenv('lang') and
aqha.price_list_id=qlhv.list_header_id(+) and
aqha.quote_header_id=aqla.quote_header_id(+) and
aqla.inventory_item_id=msiv.inventory_item_id(+) and
aqla.organization_id=msiv.organization_id(+)
