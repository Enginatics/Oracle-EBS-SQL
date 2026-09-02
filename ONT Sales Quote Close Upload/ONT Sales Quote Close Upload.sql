/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: ONT Sales Quote Close Upload
-- Description: Bulk closes open Oracle Order Management sales quotes (documents in the Negotiation transaction phase) - useful for cleaning up large volumes of old draft quotes.

Download the open quotes, keep the rows you want to close, set a Close Reason, and upload. Each quote is driven to the Lost terminal (status Lost, no longer open) through the standard negotiation workflow, and the reason is recorded against the quote.

Quotes are identified by Quote Number and Operating Unit, so you can also paste those two values from an external list instead of downloading. Only open quotes are closed - an order number or an already-closed quote is reported back and left untouched.

Cancelled and Closed are order (fulfillment) statuses and do not apply to a quote - Lost is the correct terminal for a quote you are no longer pursuing. To keep win/loss reporting clean, add a custom OFFER_LOST lookup value (for example Obsolete) and select it as the Close Reason, so data-cleanup closures are distinguishable from genuine competitive losses.

Use the Created Before parameter to target quotes older than a given date, and Quote Number to close a single quote.
-- Excel Examle Output: https://www.enginatics.com/example/ont-sales-quote-close-upload/
-- Library Link: https://www.enginatics.com/reports/ont-sales-quote-close-upload/
-- Run Report: https://demo.enginatics.com/

select
to_char(null) action_,
to_char(null) status_,
to_char(null) message_,
null modified_columns_,
haouv.name operating_unit,
ooha.order_number quote_number,
ottt.name order_type,
hp.party_name customer,
hca.account_number customer_number,
ooha.ordered_date,
ooha.transactional_curr_code currency,
xxen_util.meaning(ooha.flow_status_code,'FLOW_STATUS',660) quote_status,
ooha.creation_date,
null close_reason,
null close_comments,
null upload_row
from
hr_all_organization_units_vl haouv,
oe_order_headers_all ooha,
oe_transaction_types_tl ottt,
hz_cust_accounts hca,
hz_parties hp
where
1=1 and
haouv.organization_id=ooha.org_id and
nvl(ooha.transaction_phase_code,'F')='N' and
ooha.open_flag='Y' and
ooha.order_type_id=ottt.transaction_type_id(+) and
ottt.language(+)=userenv('lang') and
ooha.sold_to_org_id=hca.cust_account_id(+) and
hca.party_id=hp.party_id(+)