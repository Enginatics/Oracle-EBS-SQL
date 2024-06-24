/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: DIS Migration identify missing EulConditions
-- Description: This report identifies the missing EUL conditions defined at the folder level.
-- Excel Examle Output: https://www.enginatics.com/example/dis-migration-identify-missing-eulconditions/
-- Library Link: https://www.enginatics.com/reports/dis-migration-identify-missing-eulconditions/
-- Run Report: https://demo.enginatics.com/

select distinct
xrtv.report_name,
document.documentid doc_id,
document.documentname doc_name,
sheet.sheetname sheet_name,
conditions.conditionsname condition
from
(select x.doc_id, x.xml from xxen_discoverer_workbook_xmls x where 1=1) t,
fnd_user fu,
xmltable('EndUserLayerExport/Document'
passing t.xml
columns
sheet xmltype path 'Workbook/Sheet',
documentname varchar2(100) path '@Name',
documentdk varchar2(240) path '@DeveloperKey',
documentid number path '@Id',
documentowner varchar2(64) path 'ElementRef[@Type="EulUser"]/UniqueIdent/@Username'
) document,
xmltable('Sheet'
passing document.sheet
columns
sheetname varchar2(240) path '@Name',
sheetdk varchar2(240) path '@DeveloperKey',
viewitem xmltype path 'View') sheet,
xmltable('View'
passing sheet.viewitem
columns
viewitemdk varchar2(240) path '@DeveloperKey',
viewitemtype varchar2(8) path '@Type',
viewdistinct varchar2(5) path '@Distinct',
backendqueryrequests xmltype path 'BackendQueryRequests') viewitem,
xmltable('BackendQueryRequests'
passing viewitem.backendqueryrequests
columns
backendqueryrequestsdk varchar2(240) path '@DeveloperKey',
query xmltype path 'Query') backendqueryrequests,
xmltable('Query'
passing backendqueryrequests.query
columns
querydk varchar2(240) path '@DeveloperKey',
isdistinct varchar2(5) path '@IsDistinct',
conditions xmltype path 'Conditions') query,
xmltable('Conditions'
passing query.conditions
columns
conditionstype varchar2(30) path 'ElementRef/@Type',
conditionsdk varchar2(240) path 'ElementRef/UniqueIdent[@ConstraintName="FIL1"]/@DeveloperKey',
conditionsname varchar2(240) path 'ElementRef/UniqueIdent[@ConstraintName="FIL2"]/@Name'
) conditions,
xxen_report_templates_v xrtv
where
document.documentid=t.doc_id and
conditions.conditionstype='EulCondition' and
xrtv.template_name=trim(substrb(document.documentname||case when sheet.sheetname not like 'Sheet %' then ': '||sheet.sheetname end,1,240))