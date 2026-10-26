/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: CAC Interface Error Summary
-- Description: Use this report to view your transactions that are pending or have errors in the Oracle interface tables. Across both Financial and Supply Chain Applications. This includes interfaces that would prevent closing the inventory accounting period, as suggested by the report titles, Resolution Required and Resolution Recommended. Similar to the Inventory Account Periods Close form (checking open receipts, pending shipments, failed inventory, WIP, etc.).
-- Notes:
-- 1) Supply Chain queries check for the period close timezone of the legal entity, just like the Inventory Account Periods Close form and the Blitz INV Period Close Pending Transactions report. Period count queries sourced from procedure CSTAccountingPeriodPUB.GetPendingTcount (CSTPAPEB.pls 120.18.12020000.8)
-- 2) The Financial interfaces all show a priority of "Resolution Recommended", as having entries in these interface tables do not prevent you from closing your books. However, just like Supply Chain, best practice would be to process all unprocessed and/or erred out entries in these interfaces, before closing the accounting period.
-- Specific Functional Areas and Interface Reports include:
-- Accounts Payables
-- APInvoicesInterface
-- APInvoiceLinesInterface
-- Accounts Receivables
-- RAInterfaceLinesAll
-- RAInterfaceErrorsAll
-- Cash Management
-- CEHeaderInterfaceErrors
-- Cost Management
-- Uncosted Material - MTLMaterialTransactions
-- Uncosted - WSMSplitMergeTransactions
-- Pending WIP Costing - WIPCostTxnInterface Report
-- General Ledger
-- GLInterface
-- Inventory
-- Unprocessed Material - MTLMaterialTransactionsTemp
-- Unprocessed Locked Material - MTLMaterialTransactionsTemp
-- Pending Material - MTLTransactionsInterface
-- Oracle Landed Cost Management
-- Pending Landed Cost Management (INL) Interface - CSTLcAdjInterface Interface
-- Project
-- PATransactionInterfaceAll
-- Purchasing
-- PORequisitionsInterfaceAll
-- Purchasing (showing Receiving as the reported Functional Area)
-- Pending Expense Receiving - RCVTransactionsInterface
-- Pending Inventory and OSP Receiving - RCVTransactionsInterface
-- Pending Intransit Receiving - RCVTransactionsInterface
-- Pending RMA Receiving - RCVTransactionsInterface
-- Shipping
-- Shipping - WSHDeliveryDetails
-- Warehouse Management System (WSM)
-- Pending WSM Interface Transactions - WSMSplitMergeTxnInterface
-- Pending WSM Lot Interface Transactions - WSMLotSplitMergesInterface
-- Work in Process (Manufacturing)
-- Pending Shop Floor Move Transactions - WIPMoveTxnInterface
-- -- | Version Modified Modified by Description
-- -- | ======== ========= =============== ================================================
-- -- | 1.0 1995 Initial Design Originally based on sql from a project in 1995.
-- -- | 1.1 31-Jan-08 Douglas Volz Added Operating Unit column to summary queries.
-- -- | 1.42 15-Jul-25 Douglas Volz For Uncosted Transactions, checked for Process MFG
-- -- | and added Ledger Security Controls for GLInterface.
-- -- | 1.43 19-Jul-25 Douglas Volz Changed LCM query to use the LCM short name 'INL' instead of 'CST'.
-- -- | 1.44 24-Aug-25 Douglas Volz Changed Pending Material from Resolution Required to Recommended.
-- -- | 1.45 24 Oct 2026 Andy Haack Rebuilt to the Blitz Report SQL standards.
-- -- +=============================================================================+/
-- Excel Example Output: https://www.enginatics.com/example/cac-interface-error-summary/
-- Library Link: https://www.enginatics.com/reports/cac-interface-error-summary/
-- Run Report: https://demo.enginatics.com/

with o as (
select /*+ materialize*/
nvl(gl.short_name,gl.name) ledger,
haouv_ou.name operating_unit,
haouv_ou.organization_id operating_unit_id,
mp.organization_code,
mp.organization_id,
to_number(hoi.org_information2) legal_entity_id,
gl.period_set_name,
gl.accounted_period_type
from
mtl_parameters mp,
hr_organization_information hoi,
hr_all_organization_units_vl haouv,
hr_all_organization_units_vl haouv_ou,
gl_ledgers gl
where
1=1 and
2=2 and
3=3 and
mp.organization_id=hoi.organization_id and
hoi.org_information_context='Accounting Information' and
hoi.organization_id=haouv.organization_id and
sysdate<nvl(haouv.date_to,sysdate+1) and
to_number(hoi.org_information3)=haouv_ou.organization_id and
to_number(hoi.org_information1)=gl.ledger_id
),
u as (
select /*+ materialize*/
nvl(gl.short_name,gl.name) ledger,
haouv_ou.name operating_unit,
haouv_ou.organization_id operating_unit_id,
fspa.inventory_organization_id,
gl.period_set_name,
gl.accounted_period_type
from
hr_all_organization_units_vl haouv_ou,
hr_organization_information hoi,
financials_system_params_all fspa,
gl_ledgers gl
where
1=1 and
3=3 and
haouv_ou.organization_id=hoi.organization_id and
hoi.org_information_context||''='CLASS' and
hoi.org_information1='OPERATING_UNIT' and
hoi.org_information2='Y' and
haouv_ou.organization_id=fspa.org_id and
fspa.set_of_books_id=gl.ledger_id
),
t as (
select /*+ materialize*/
rownum id,
x.*
from
(
select
1 section,
'SQLAP' fav_app,
'SQLAP' fpi_app,
null area,
'AP_Invoices_Interface' report_interface,
'Number of A/P Invoices' report_title,
'3' priority_code,
'O' lvl,
to_number(null) organization_id,
nvl(aii.org_id,to_number(regexp_replace(aii.attribute_category,'[^0-9]+',''))) operating_unit_id,
to_number(null) ledger_id,
to_number(null) acct_period_id,
coalesce(aii.gl_date,aii.invoice_date,sysdate) txn_date,
(select xxen_util.meaning('AP_SUPPLIER','BUSINESS_ENTITY',0) from dual) column_type,
aps.vendor_name column_info,
aii.status status_code,
null message,
'Rows in the AP_INVOICES_INTERFACE table' interface_description
from
ap_invoices_interface aii,
ap_suppliers aps
where
nvl(aii.status,'N')<>'PROCESSED' and
aii.vendor_id=aps.vendor_id(+)
union all
select
2 section,
'SQLAP' fav_app,
'SQLAP' fpi_app,
null area,
'AP_Interface_Rejections' report_interface,
'Number of A/P Interface Rejections' report_title,
'3' priority_code,
'O' lvl,
to_number(null) organization_id,
nvl(aii.org_id,to_number(regexp_replace(aii.attribute_category,'[^0-9]+',''))) operating_unit_id,
to_number(null) ledger_id,
to_number(null) acct_period_id,
coalesce(aii.gl_date,aii.invoice_date,sysdate) txn_date,
(select xxen_util.meaning('AP_SUPPLIER','BUSINESS_ENTITY',0) from dual) column_type,
aps.vendor_name column_info,
aii.status status_code,
air.reject_lookup_code message,
'Errors in the AP_INTERFACE_REJECTIONS table - Invoice Issue' interface_description
from
ap_interface_rejections air,
ap_invoices_interface aii,
ap_suppliers aps
where
air.parent_table='AP_INVOICES_INTERFACE' and
air.parent_id=aii.invoice_id and
nvl(aii.status,'N')<>'PROCESSED' and
aii.vendor_id=aps.vendor_id(+)
union all
select
3 section,
'SQLAP' fav_app,
'SQLAP' fpi_app,
null area,
'AP_Interface_Rejections' report_interface,
'Number of A/P Interface Rejections' report_title,
'3' priority_code,
'O' lvl,
to_number(null) organization_id,
nvl(aii.org_id,to_number(regexp_replace(aii.attribute_category,'[^0-9]+',''))) operating_unit_id,
to_number(null) ledger_id,
to_number(null) acct_period_id,
coalesce(aii.gl_date,aii.invoice_date,sysdate) txn_date,
(select xxen_util.meaning('AP_SUPPLIER','BUSINESS_ENTITY',0) from dual) column_type,
aps.vendor_name column_info,
aii.status status_code,
air.reject_lookup_code message,
'Errors in the AP_INTERFACE_REJECTIONS table - Invoice Line Issue' interface_description
from
ap_interface_rejections air,
ap_invoice_lines_interface aili,
ap_invoices_interface aii,
ap_suppliers aps
where
air.parent_table='AP_INVOICE_LINES_INTERFACE' and
air.parent_id=aili.invoice_line_id and
aili.invoice_id=aii.invoice_id and
nvl(aii.status,'N')<>'PROCESSED' and
aii.vendor_id=aps.vendor_id(+)
union all
select
4 section,
'AR' fav_app,
'AR' fpi_app,
null area,
'RA_Interface_Lines_All' report_interface,
'Number of RA Invoice lines' report_title,
'3' priority_code,
'O' lvl,
to_number(null) organization_id,
rila.org_id operating_unit_id,
to_number(null) ledger_id,
to_number(null) acct_period_id,
coalesce(rila.rule_start_date,rila.gl_date,rila.trx_date,sysdate) txn_date,
(select xxen_util.meaning('MSCX_CUST_SHIP_DATE','MSC_PQ_CP_EXCP',0) from dual) column_type,
to_char(rila.ship_date_actual,'YYYY-MM-DD') column_info,
(select xxen_util.meaning(nvl2(riea.message_text,'COMPLETED W/ERRORS','UNPROCESSED'),'DEBRIEF_CONCURRENT_STATUS',0) from dual) status_code,
riea.message_text message,
'Rows in the RA_INTERFACE_LINES_ALL table' interface_description
from
ra_interface_lines_all rila,
ra_interface_errors_all riea
where
rila.interface_line_id=riea.interface_line_id(+)
union all
select
5 section,
'AR' fav_app,
'AR' fpi_app,
null area,
'RA_Interface_Errors_All' report_interface,
'Number of RA Invoice Errors' report_title,
'3' priority_code,
'O' lvl,
to_number(null) organization_id,
rila.org_id operating_unit_id,
to_number(null) ledger_id,
to_number(null) acct_period_id,
coalesce(rila.rule_start_date,rila.gl_date,rila.trx_date,sysdate) txn_date,
(select xxen_util.meaning('CUSTOMER_NAME','MSC_PQ_CP_EXCP',0) from dual) column_type,
(select hp.party_name from hz_cust_accounts hca, hz_parties hp where rila.orig_system_bill_customer_id=hca.cust_account_id and hca.party_id=hp.party_id) column_info,
(select xxen_util.meaning('COMPLETED W/ERRORS','DEBRIEF_CONCURRENT_STATUS',0) from dual) status_code,
riea.message_text message,
'Errors in the RA_INTERFACE_ERRORS_ALL table' interface_description
from
ra_interface_lines_all rila,
ra_interface_errors_all riea
where
rila.interface_line_id=riea.interface_line_id
union all
select
6 section,
'CE' fav_app,
'CE' fpi_app,
null area,
'CE_Header_Interface_Errors' report_interface,
'Number of Cash Mgmt Interface Records by Bank' report_title,
'3' priority_code,
'N' lvl,
to_number(null) organization_id,
to_number(null) operating_unit_id,
to_number(null) ledger_id,
to_number(null) acct_period_id,
chie.creation_date txn_date,
(select xxen_util.meaning('BANK_NAME','JA_CN_XML_TAGS',0) from dual) column_type,
(select max(hp.party_name) from ce_bank_accounts cba, hz_parties hp where chie.bank_account_num=cba.bank_account_num and cba.bank_id=hp.party_id) column_info,
(select xxen_util.meaning('E','LOG_TYPE_CODE',0) from dual) status_code,
chie.message_name message,
'Rows in the CE_HEADER_INTERFACE_ERRORS table' interface_description
from
ce_header_interface_errors chie
union all
select
7 section,
'SQLGL' fav_app,
'SQLGL' fpi_app,
null area,
'GL_Interface' report_interface,
'Number of G/L Lines by Ledger' report_title,
'3' priority_code,
'G' lvl,
to_number(null) organization_id,
to_number(null) operating_unit_id,
decode(gi.ledger_id,-1,gi.set_of_books_id,gi.ledger_id) ledger_id,
to_number(null) acct_period_id,
nvl(gi.accounting_date,gi.transaction_date) txn_date,
(select xxen_util.meaning('JE_SOURCE_NAME','JGSLAJNLTP_RPT_SORT_PARAMS',0) from dual) column_type,
gi.user_je_source_name column_info,
gi.status status_code,
null message,
'Rows in the GL_INTERFACE table' interface_description
from
gl_interface gi
union all
select
8 section,
'SQLGL' fav_app,
'SQLGL' fpi_app,
null area,
'GL_Interface' report_interface,
'Number of G/L Lines With No Ledger Id' report_title,
'3' priority_code,
'N' lvl,
to_number(null) organization_id,
to_number(null) operating_unit_id,
to_number(null) ledger_id,
to_number(null) acct_period_id,
nvl(gi.accounting_date,gi.transaction_date) txn_date,
(select xxen_util.meaning('JE_SOURCE_NAME','JGSLAJNLTP_RPT_SORT_PARAMS',0) from dual) column_type,
gi.user_je_source_name column_info,
gi.status status_code,
'Missing Ledger Id' message,
'Rows in the GL_INTERFACE table' interface_description
from
gl_interface gi
where
gi.ledger_id=-1 and
gi.set_of_books_id is null
union all
select
9 section,
'INV' fav_app,
'INV' fpi_app,
null area,
'MTL_Material_Transactions_Temp' report_interface,
'Unprocessed Material Errors' report_title,
'2' priority_code,
'IA' lvl,
mmtt.organization_id,
to_number(null) operating_unit_id,
to_number(null) ledger_id,
mmtt.acct_period_id,
mmtt.transaction_date txn_date,
(select xxen_util.meaning('3','INV_SRS_REG_BREAK',700) from dual) column_type,
(select mtt.transaction_type_name from mtl_transaction_types mtt where mmtt.transaction_type_id=mtt.transaction_type_id) column_info,
mmtt.process_flag status_code,
mmtt.error_code message,
'Rows have Errored in the Material Transactions Temp table' interface_description
from
mtl_material_transactions_temp mmtt
where
mmtt.process_flag='E'
union all
select
10 section,
'INV' fav_app,
'INV' fpi_app,
null area,
'MTL_Material_Transactions_Temp' report_interface,
'Unprocessed Material Transactions With Locked Records' report_title,
'2' priority_code,
'IA' lvl,
mmtt.organization_id,
to_number(null) operating_unit_id,
to_number(null) ledger_id,
mmtt.acct_period_id,
mmtt.transaction_date txn_date,
(select xxen_util.meaning('3','INV_SRS_REG_BREAK',700) from dual) column_type,
(select mtt.transaction_type_name from mtl_transaction_types mtt where mmtt.transaction_type_id=mtt.transaction_type_id) column_info,
mmtt.process_flag status_code,
mmtt.error_code message,
'Rows have their records locked in the MTL_MATERIAL_TRANSACTIONS_TEMP table' interface_description
from
mtl_material_transactions_temp mmtt
where
mmtt.lock_flag in ('Y','1')
union all
select
11 section,
'INV' fav_app,
'INV' fpi_app,
null area,
'MTL_Transactions_Interface' report_interface,
'Pending Material Transactions' report_title,
'3' priority_code,
'ID' lvl,
mti.organization_id,
to_number(null) operating_unit_id,
to_number(null) ledger_id,
to_number(null) acct_period_id,
nvl(mti.transaction_date,sysdate) txn_date,
(select xxen_util.meaning('3','INV_SRS_REG_BREAK',700) from dual) column_type,
(select mtt.transaction_type_name from mtl_transaction_types mtt where mti.transaction_type_id=mtt.transaction_type_id) column_info,
decode(mti.process_flag,1,'1 - Ready',2,'2 - Not Ready',3,'3 - Error') status_code,
mti.error_code message,
'Rows in the Material Transaction Interface' interface_description
from
mtl_transactions_interface mti
union all
select
12 section,
'INV' fav_app,
'INV' fpi_app,
null area,
'MTL_Transactions_Interface Errors' report_interface,
'Pending Material Transactions With Locked Records' report_title,
'2' priority_code,
'ID' lvl,
mti.organization_id,
to_number(null) operating_unit_id,
to_number(null) ledger_id,
to_number(null) acct_period_id,
nvl(mti.transaction_date,sysdate) txn_date,
(select xxen_util.meaning('3','INV_SRS_REG_BREAK',700) from dual) column_type,
(select mtt.transaction_type_name from mtl_transaction_types mtt where mti.transaction_type_id=mtt.transaction_type_id) column_info,
to_char(mti.process_flag) status_code,
mti.error_code message,
'Rows have their records locked' interface_description
from
mtl_transactions_interface mti
where
mti.lock_flag=1
union all
select
13 section,
'CST' fav_app,
'INV' fpi_app,
null area,
'MTL_Material_Transactions' report_interface,
'Uncosted Material Transactions' report_title,
'2' priority_code,
'IA' lvl,
mmt.organization_id,
to_number(null) operating_unit_id,
to_number(null) ledger_id,
mmt.acct_period_id,
mmt.transaction_date txn_date,
(select xxen_util.meaning('3','INV_SRS_REG_BREAK',700) from dual) column_type,
(select mtt.transaction_type_name from mtl_transaction_types mtt where mmt.transaction_type_id=mtt.transaction_type_id) column_info,
mmt.costed_flag status_code,
mmt.error_code message,
'Rows have not been costed, check the Cost Processor' interface_description
from
mtl_material_transactions mmt
where
mmt.costed_flag in ('N','E') and
mmt.organization_id not in (select mp.organization_id from mtl_parameters mp where mp.process_enabled_flag='Y')
union all
select
14 section,
'WSM' fav_app,
'WSM' fpi_app,
null area,
'WSM_Split_Merge_Transactions' report_interface,
'Uncosted WIP Split Merge Transactions' report_title,
'2' priority_code,
'ID' lvl,
wsmt.organization_id,
to_number(null) operating_unit_id,
to_number(null) ledger_id,
to_number(null) acct_period_id,
nvl(wsmt.transaction_date,sysdate) txn_date,
(select xxen_util.meaning('3','INV_SRS_REG_BREAK',700) from dual) column_type,
xxen_util.meaning(to_char(wsmt.transaction_type_id),'WSM_WIP_LOT_TXN_TYPE',700) column_info,
xxen_util.meaning(wsmt.status,'WIP_PROCESS_STATUS',700) status_code,
wsmt.error_message message,
'Rows have not been costed, check the Cost Processor' interface_description
from
wsm_split_merge_transactions wsmt
where
wsmt.costed<>4 and
wsmt.organization_id not in (select mp.organization_id from mtl_parameters mp where mp.process_enabled_flag='Y')
union all
select
15 section,
'INL' fav_app,
'INL' fpi_app,
null area,
'CST_Lc_Adj_Interface' report_interface,
'Pending LCM Interface' report_title,
'2' priority_code,
'ID' lvl,
clai.organization_id,
to_number(null) operating_unit_id,
to_number(null) ledger_id,
to_number(null) acct_period_id,
clai.transaction_date txn_date,
(select xxen_util.meaning('3','INV_SRS_REG_BREAK',700) from dual) column_type,
xxen_util.meaning(rt.transaction_type,'RCV TRANSACTION TYPE',201) column_info,
xxen_util.meaning(clai.process_status,'LANDED_COST_ADJ_PROCESS_STATUS',700) status_code,
claie.error_message message,
'Rows in the CST_LC_ADJ_INTERFACE table' interface_description
from
cst_lc_adj_interface clai,
cst_lc_adj_interface_errors claie,
rcv_transactions rt
where
clai.organization_id in (select mp.organization_id from mtl_parameters mp where mp.lcm_enabled_flag='Y') and
clai.transaction_id=claie.transaction_id(+) and
clai.rcv_transaction_id=rt.transaction_id
union all
select
16 section,
'WIP' fav_app,
'WIP' fpi_app,
null area,
'WIP_Move_Txn_Interface' report_interface,
'Pending Shop Floor Move Transactions' report_title,
'3' priority_code,
'ID' lvl,
wmti.organization_id,
to_number(null) operating_unit_id,
to_number(null) ledger_id,
to_number(null) acct_period_id,
nvl(wmti.transaction_date,sysdate) txn_date,
(select xxen_util.meaning('3','INV_SRS_REG_BREAK',700) from dual) column_type,
xxen_util.meaning(to_char(wmti.transaction_type),'WIP_MOVE_TRANSACTION_TYPE',700) column_info,
xxen_util.meaning(to_char(wmti.process_status),'WIP_PROCESS_STATUS',700) status_code,
wtie.error_message message,
'Rows in the WIP_MOVE_TXN_INTERFACE table' interface_description
from
wip_move_txn_interface wmti,
wip_txn_interface_errors wtie
where
wmti.transaction_id=wtie.transaction_id(+)
union all
select
17 section,
'WSM' fav_app,
'WSM' fpi_app,
null area,
'WSM_Split_Merge_Txn_Interface' report_interface,
'Pending WIP WSM Split Merge Transactions' report_title,
'2' priority_code,
'ID' lvl,
wsmti.organization_id,
to_number(null) operating_unit_id,
to_number(null) ledger_id,
to_number(null) acct_period_id,
nvl(wsmti.transaction_date,sysdate) txn_date,
(select xxen_util.meaning('3','INV_SRS_REG_BREAK',700) from dual) column_type,
xxen_util.meaning(to_char(wsmti.transaction_type_id),'WSM_WIP_LOT_TXN_TYPE',700) column_info,
xxen_util.meaning(wsmti.process_status,'WIP_PROCESS_STATUS',700) status_code,
wsmti.error_message message,
'Rows in the WSM_SPLIT_MERGE_TXN_INTERFACE table' interface_description
from
wsm_split_merge_txn_interface wsmti
where
wsmti.process_status<>4
union all
select
18 section,
'WSM' fav_app,
'WSM' fpi_app,
null area,
'WSM_Lot_Split_Merges_Interface' report_interface,
'Pending WIP WSM Lot Split Merge Transactions' report_title,
'2' priority_code,
'ID' lvl,
wlsmi.organization_id,
to_number(null) operating_unit_id,
to_number(null) ledger_id,
to_number(null) acct_period_id,
nvl(wlsmi.transaction_date,sysdate) txn_date,
(select xxen_util.meaning('3','INV_SRS_REG_BREAK',700) from dual) column_type,
xxen_util.meaning(to_char(wlsmi.transaction_type_id),'WSM_WIP_LOT_TXN_TYPE',700) column_info,
xxen_util.meaning(wlsmi.process_status,'WIP_PROCESS_STATUS',700) status_code,
wlsmi.error_message message,
'Rows in the WSM_LOT_SPLIT_MERGES_INTERFACE table' interface_description
from
wsm_lot_split_merges_interface wlsmi
where
wlsmi.process_status<>4
union all
select
19 section,
'CST' fav_app,
'WIP' fpi_app,
null area,
'WIP_Cost_Txn_Interface' report_interface,
'Pending WIP Transactions' report_title,
'2' priority_code,
'IA' lvl,
wcti.organization_id,
to_number(null) operating_unit_id,
to_number(null) ledger_id,
wcti.acct_period_id,
nvl(wcti.transaction_date,sysdate) txn_date,
(select xxen_util.meaning('3','INV_SRS_REG_BREAK',700) from dual) column_type,
xxen_util.meaning(to_char(wcti.transaction_type),'WIP_TRANSACTION_TYPE',700) column_info,
xxen_util.meaning(wcti.process_status,'WIP_PROCESS_STATUS',700) status_code,
wtie.error_message message,
'Rows in the WIP_COST_TXN_INTERFACE table' interface_description
from
wip_cost_txn_interface wcti,
wip_txn_interface_errors wtie
where
wcti.organization_id not in (select mp.organization_id from mtl_parameters mp where mp.process_enabled_flag='Y') and
wcti.transaction_id=wtie.transaction_id(+)
union all
select
20 section,
'PA' fav_app,
'PA' fpi_app,
null area,
'PA_Transaction_Interface_All' report_interface,
'Pending Project Transactions' report_title,
'3' priority_code,
'O' lvl,
to_number(null) organization_id,
ptia.org_id operating_unit_id,
to_number(null) ledger_id,
to_number(null) acct_period_id,
ptia.expenditure_item_date txn_date,
(select xxen_util.meaning('TRX','FC_VIEW_BY',260) from dual) column_type,
ptia.transaction_source column_info,
ptia.transaction_status_code status_code,
xxen_util.meaning(ptia.transaction_rejection_code,'TRANSACTION REJECTION REASON',275) message,
'Rows in the PA_Transaction_Interface_All table' interface_description
from
pa_transaction_interface_all ptia
where
ptia.transaction_status_code<>'P'
union all
select
21 section,
'PO' fav_app,
'PO' fpi_app,
null area,
'PO_Requisitions_Interface_All' report_interface,
'Number of PO Requisitions' report_title,
'3' priority_code,
'O' lvl,
pria.destination_organization_id organization_id,
pria.org_id operating_unit_id,
to_number(null) ledger_id,
to_number(null) acct_period_id,
nvl(pria.need_by_date,pria.creation_date) txn_date,
'Interface Source' column_type,
pria.interface_source_code column_info,
pria.process_flag status_code,
pie.error_message message,
'Rows in the PO_REQUISITIONS_INTERFACE_ALL table' interface_description
from
po_requisitions_interface_all pria,
po_interface_errors pie
where
pria.transaction_id=pie.interface_transaction_id(+) and
pie.table_name(+)='PO_REQUISITIONS_INTERFACE'
union all
select
decode(k.destination_type,'EXPENSE',nvl2(rti.to_organization_id,22,23),24) section,
'PO' fav_app,
'PO' fpi_app,
(select xxen_util.meaning('RECEIVING','RCV DESTINATION TYPE',201) from dual) area,
'RCV_Transactions_Interface' report_interface,
decode(k.destination_type,'EXPENSE','Pending Expense Receiving Transactions','Pending Inventory and OSP Receiving Transactions') report_title,
'3' priority_code,
nvl2(rti.to_organization_id,'ID','O') lvl,
rti.to_organization_id organization_id,
rti.org_id operating_unit_id,
to_number(null) ledger_id,
to_number(null) acct_period_id,
rti.transaction_date txn_date,
(select xxen_util.meaning('3','INV_SRS_REG_BREAK',700) from dual) column_type,
rti.transaction_type column_info,
rti.processing_status_code status_code,
rti.transaction_status_code message,
'Rows in the RCV_TRANSACTIONS_INTERFACE table' interface_description
from
rcv_transactions_interface rti,
(select 'EXPENSE' destination_type from dual union all select 'INVENTORY' from dual) k
where
(k.destination_type='EXPENSE' or rti.to_organization_id is not null) and
(
decode(rti.destination_type_code,'SHOP FLOOR','INVENTORY',rti.destination_type_code)=k.destination_type or
nvl(rti.destination_type_code,'NONE') not in ('EXPENSE','INVENTORY','SHOP FLOOR') and
(
rti.po_distribution_id in (select pda.po_distribution_id from po_distributions_all pda where decode(pda.destination_type_code,'SHOP FLOOR','INVENTORY',pda.destination_type_code)=k.destination_type) or
rti.po_distribution_id is null and rti.po_line_id in (select pda.po_line_id from po_distributions_all pda where decode(pda.destination_type_code,'SHOP FLOOR','INVENTORY',pda.destination_type_code)=k.destination_type) or
rti.po_header_id is null and (rti.document_num,rti.document_line_num) in (select pha.segment1,pla.line_num from po_headers_all pha, po_lines_all pla, po_distributions_all pda where pha.po_header_id=pla.po_header_id and pla.po_line_id=pda.po_line_id and decode(pda.destination_type_code,'SHOP FLOOR','INVENTORY',pda.destination_type_code)=k.destination_type)
)
)
union all
select
25 section,
'INV' fav_app,
'INV' fpi_app,
null area,
'WSH_Delivery_Details' report_interface,
'Unprocessed Sales Order Shipping Transactions' report_title,
'2' priority_code,
'ID' lvl,
wnd.organization_id,
to_number(null) operating_unit_id,
to_number(null) ledger_id,
to_number(null) acct_period_id,
nvl(wts.actual_departure_date,sysdate) txn_date,
(select xxen_util.meaning('MSCX_CUST_SHIP_DATE','MSC_PQ_CP_EXCP',0) from dual) column_type,
to_char(wts.actual_departure_date,'YYYY-MM-DD') column_info,
decode(wdd.inv_interfaced_flag,'P','P - Delivery is pending interface to Inventory','N','N - Delivery not interfaced to Inventory') status_code,
wev.message,
'Rows in the WSH_DELIVERY_DETAILS table' interface_description
from
wsh_delivery_details wdd,
wsh_delivery_assignments wda,
wsh_new_deliveries wnd,
wsh_delivery_legs wdl,
wsh_trip_stops wts,
wsh_exceptions_v wev
where
wdd.source_code='OE' and
wdd.released_status='C' and
wdd.inv_interfaced_flag in ('N','P') and
wdd.delivery_detail_id=wda.delivery_detail_id and
wda.delivery_id=wnd.delivery_id and
wnd.status_code in ('CL','IT') and
wnd.delivery_id=wdl.delivery_id and
wdl.pick_up_stop_id=wts.stop_id and
wts.pending_interface_flag in ('Y','P') and
wts.stop_id=wev.trip_stop_id(+)
union all
select
decode(prla.destination_type_code,'EXPENSE',26,27) section,
'INV' fav_app,
'INV' fpi_app,
null area,
'WSH_Delivery_Details' report_interface,
decode(prla.destination_type_code,'EXPENSE','Unprocessed Expense Requisition Shipping Transactions','Unprocessed Inventory Requisition Shipping Transactions') report_title,
'2' priority_code,
'ID' lvl,
prla.destination_organization_id organization_id,
to_number(null) operating_unit_id,
to_number(null) ledger_id,
to_number(null) acct_period_id,
nvl(wts.actual_departure_date,sysdate) txn_date,
(select xxen_util.meaning('MSCX_CUST_SHIP_DATE','MSC_PQ_CP_EXCP',0) from dual) column_type,
to_char(wts.actual_departure_date,'YYYY-MM-DD') column_info,
decode(wdd.inv_interfaced_flag,'P','P - Delivery is pending interface to Inventory','N','N - Delivery not interfaced to Inventory') status_code,
wev.message,
'Rows in the WSH_DELIVERY_DETAILS table' interface_description
from
wsh_delivery_details wdd,
wsh_delivery_assignments wda,
wsh_new_deliveries wnd,
wsh_delivery_legs wdl,
wsh_trip_stops wts,
wsh_exceptions_v wev,
oe_order_lines_all oola,
po_requisition_lines_all prla
where
wdd.source_code='OE' and
wdd.released_status='C' and
wdd.inv_interfaced_flag in ('N','P') and
wdd.delivery_detail_id=wda.delivery_detail_id and
wda.delivery_id=wnd.delivery_id and
wnd.status_code in ('CL','IT') and
wnd.delivery_id=wdl.delivery_id and
wdl.pick_up_stop_id=wts.stop_id and
wts.pending_interface_flag in ('Y','P') and
wts.stop_id=wev.trip_stop_id(+) and
wdd.source_document_type_id=10 and
wts.stop_location_id=wnd.initial_pickup_location_id and
wdd.source_line_id=oola.line_id and
oola.source_document_line_id=prla.requisition_line_id and
prla.destination_organization_id<>prla.source_organization_id and
(prla.destination_type_code='EXPENSE' or (prla.source_organization_id,prla.destination_organization_id) in (select mip.from_organization_id,mip.to_organization_id from mtl_interorg_parameters mip where mip.intransit_type=1))
) x
),
r as (
select
t.id,
gp.period_year,
gp.period_num period_number,
gp.period_name,
o.ledger,
o.operating_unit,
o.operating_unit_id,
o.organization_code org_code,
o.organization_id inv_organization_id
from
t,
o,
org_acct_periods oap,
gl_periods gp
where
4=4 and
6=6 and
t.lvl='IA' and
t.organization_id=o.organization_id and
t.acct_period_id=oap.acct_period_id and
oap.period_set_name=gp.period_set_name and
oap.period_name=gp.period_name and
o.accounted_period_type=gp.period_type and
gp.adjustment_period_flag='N'
union all
select
x.id,
gp.period_year,
gp.period_num period_number,
gp.period_name,
x.ledger,
x.operating_unit,
x.operating_unit_id,
x.organization_code org_code,
x.organization_id inv_organization_id
from
(
select
t.id,
o.*,
trunc(inv_le_timezone_pub.get_le_day_for_server(t.txn_date,o.legal_entity_id)) le_day
from
t,
o
where
t.lvl='ID' and
t.organization_id=o.organization_id
) x,
gl_periods gp
where
4=4 and
6=6 and
x.period_set_name=gp.period_set_name and
x.accounted_period_type=gp.period_type and
gp.adjustment_period_flag='N' and
x.le_day between gp.start_date and gp.end_date
union all
select
t.id,
gp.period_year,
gp.period_num period_number,
gp.period_name,
u.ledger,
u.operating_unit,
u.operating_unit_id,
mp.organization_code org_code,
mp.organization_id inv_organization_id
from
t,
u,
mtl_parameters mp,
gl_periods gp
where
2=2 and
4=4 and
6=6 and
t.lvl='O' and
t.operating_unit_id=u.operating_unit_id and
nvl(t.organization_id,u.inventory_organization_id)=mp.organization_id(+) and
u.period_set_name=gp.period_set_name and
u.accounted_period_type=gp.period_type and
gp.adjustment_period_flag='N' and
trunc(t.txn_date) between gp.start_date and gp.end_date
union all
select
t.id,
gp.period_year,
gp.period_num period_number,
gp.period_name,
nvl(gl.short_name,gl.name) ledger,
null operating_unit,
to_number(null) operating_unit_id,
null org_code,
to_number(null) inv_organization_id
from
t,
gl_ledgers gl,
gl_periods gp
where
1=1 and
4=4 and
6=6 and
t.lvl='G' and
t.ledger_id=gl.ledger_id and
gl.period_set_name=gp.period_set_name and
gl.accounted_period_type=gp.period_type and
gp.adjustment_period_flag='N' and
trunc(t.txn_date) between gp.start_date and gp.end_date
union all
select
t.id,
extract(year from t.txn_date) period_year,
to_number(null) period_number,
to_char(t.txn_date,'MON-YY') period_name,
null ledger,
null operating_unit,
to_number(null) operating_unit_id,
null org_code,
to_number(null) inv_organization_id
from
t
where
7=7 and
t.lvl='N'
)
select
nvl(t.area,fav.application_name) functional_area,
t.report_interface,
t.report_title,
xxen_util.meaning(t.priority_code,'CST_SRS_RESOLUTION_TYPES',700) priority,
count(*) count,
r.period_year,
r.period_number,
r.period_name,
r.ledger,
r.operating_unit,
r.operating_unit_id,
r.org_code,
r.inv_organization_id,
t.column_type,
t.column_info,
t.status_code,
t.message reject_code_or_error_message,
t.interface_description
from
t,
r,
fnd_application_vl fav
where
5=5 and
t.id=r.id and
t.fav_app=fav.application_short_name and
t.fpi_app in (select fa.application_short_name from fnd_application fa, fnd_product_installations fpi where fa.application_id=fpi.application_id and fpi.status<>'N')
group by
t.section,
nvl(t.area,fav.application_name),
t.report_interface,
t.report_title,
t.priority_code,
r.period_year,
r.period_number,
r.period_name,
r.ledger,
r.operating_unit,
r.operating_unit_id,
r.org_code,
r.inv_organization_id,
t.column_type,
t.column_info,
t.status_code,
t.message,
t.interface_description
order by
functional_area,
report_interface,
report_title,
priority,
period_year,
period_number,
period_name,
ledger,
operating_unit,
operating_unit_id
