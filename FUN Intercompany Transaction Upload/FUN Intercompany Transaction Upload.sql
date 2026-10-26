/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: FUN Intercompany Transaction Upload
-- Description: FUN Intercompany Transaction Upload
-- ==================================
-- Creates, updates and submits Advanced Global Intercompany System (AGIS) intercompany batches as entered on the Intercompany Super User > Transactions > Outbound pages: the batch with its initiator, the transactions to each recipient, and their initiator and recipient distributions.
-- Each row is one initiator distribution and/or one recipient distribution of a transaction. Batch columns repeat on every row of the batch and transaction columns on every row of the transaction. Rows are grouped into a batch by Initiator and Batch Number. With automatic batch numbering (Intercompany System Options) the entered Batch Number only groups the rows and the batch receives the next number, which the result file shows.
-- Rows are loaded into the intercompany open interface and imported by Oracle's Intercompany Import Program, which applies the same validations as the Outbound pages. A batch is imported completely or not at all, and the rows of a rejected batch show the import's rejection reasons.
-- Submit = Yes imports the batch as sent, which starts the intercompany approval workflow, as the Submit button does.
-- Upload Mode
-- ===========
-- Create
-- ------
-- Opens an empty spreadsheet to enter new batches.
-- Create, Update
-- --------------
-- Additionally downloads existing batches. Only batches with status New can be changed or submitted. An updated batch is imported again as a whole, including its transactions and distributions not present in the upload, and replaces the existing batch once the import has accepted it. It keeps its batch number but gets a new batch id. Distributions cannot be deleted.
-- Only batches of initiators the user is an intercompany contact for are listed, and the user must be assigned to an employee.
-- Excel Example Output: https://www.enginatics.com/example/fun-intercompany-transaction-upload/
-- Library Link: https://www.enginatics.com/reports/fun-intercompany-transaction-upload/
-- Run Report: https://demo.enginatics.com/

select
null action_,
null status_,
null message_,
null request_id_,
null modified_columns_,
x.*
from
(
select
hp_i.party_name initiator,
ftb.batch_number,
fttv.trx_type_name batch_type,
ftb.currency_code currency,
gdct.user_conversion_type exchange_rate_type,
ftb.batch_date,
ftb.gl_date,
ftb.control_total,
ftb.description batch_description,
ftb.note,
xxen_util.meaning(ftb.status,'FUN_BATCH_STATUS',435) batch_status,
null submit,
hp_r.party_name recipient,
fth.trx_number transaction_number,
fth.init_amount_dr transaction_debit,
fth.init_amount_cr transaction_credit,
fth.description transaction_description,
xxen_util.meaning(fth.status,'FUN_TRX_STATUS',435) transaction_status,
gcck_i.concatenated_segments initiator_account,
d.init_amount_dr initiator_debit,
d.init_amount_cr initiator_credit,
d.init_description initiator_dist_description,
gcck_r.concatenated_segments recipient_account,
d.reci_amount_dr recipient_debit,
d.reci_amount_cr recipient_credit,
d.reci_description recipient_dist_description,
to_char(ftb.batch_id) batch_id,
to_char(fth.trx_id) trx_id,
to_char(d.init_dist_id) init_dist_id,
to_char(d.reci_dist_id) reci_dist_id,
null interface_batch_id,
null interface_trx_id,
null init_interface_dist_id,
null reci_interface_dist_id,
row_number() over (order by hp_i.party_name,ftb.batch_number,fth.trx_number,d.rn) upload_row
from
fun_trx_batches ftb,
hz_parties hp_i,
fun_trx_types_vl fttv,
gl_daily_conversion_types gdct,
fun_trx_headers fth,
hz_parties hp_r,
(
select
y.trx_id,
y.rn,
max(decode(y.party_type_flag,'I',y.dist_id)) init_dist_id,
max(decode(y.party_type_flag,'I',y.ccid)) init_ccid,
max(decode(y.party_type_flag,'I',y.amount_dr)) init_amount_dr,
max(decode(y.party_type_flag,'I',y.amount_cr)) init_amount_cr,
max(decode(y.party_type_flag,'I',y.description)) init_description,
max(decode(y.party_type_flag,'R',y.dist_id)) reci_dist_id,
max(decode(y.party_type_flag,'R',y.ccid)) reci_ccid,
max(decode(y.party_type_flag,'R',y.amount_dr)) reci_amount_dr,
max(decode(y.party_type_flag,'R',y.amount_cr)) reci_amount_cr,
max(decode(y.party_type_flag,'R',y.description)) reci_description
from
(
select
fdl.trx_id,
fdl.party_type_flag,
fdl.dist_id,
fdl.ccid,
fdl.amount_dr,
fdl.amount_cr,
fdl.description,
row_number() over (partition by fdl.trx_id,fdl.party_type_flag order by fdl.dist_id) rn
from
fun_dist_lines fdl
where
fdl.dist_type_flag='L'
) y
group by
y.trx_id,
y.rn
) d,
gl_code_combinations_kfv gcck_i,
gl_code_combinations_kfv gcck_r
where
1=1 and
xxen_fun_upload.initiator_access(ftb.initiator_id)='Y' and
ftb.initiator_id=hp_i.party_id and
ftb.trx_type_id=fttv.trx_type_id and
ftb.exchange_rate_type=gdct.conversion_type(+) and
ftb.batch_id=fth.batch_id and
fth.recipient_id=hp_r.party_id and
fth.trx_id=d.trx_id(+) and
d.init_ccid=gcck_i.code_combination_id(+) and
d.reci_ccid=gcck_r.code_combination_id(+)
) x
