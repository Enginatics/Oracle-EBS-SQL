/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: DIS Workbook Export Script
-- Description: https://youtu.be/17Au11IBE
-- Use this report to migrate Discoverer workbooks to Blitz Report.
-- The migration process is described in the following link: https://www.enginatics.com/blog/discoverer-replacement-with-blitz-report/
-- 1. Run this report 'DIS Workbook Export Script' to generate a list of commands to export xmls for all recently used Discoverer workbooks.
-- 2. Create a new folder on a windows machine having the Discoverer Admin executable dis51adm.exe installed (contact Enginatics if you need help with the installation).
-- 3. Open a Command Prompt window, cd to the new folder, and execute (copy and paste) the commands generated in step 1. This will start individual processes to export the workbooks as .eex files. Depending on your client capacity, you can run 100-200 export processes at the same time. In case of errors, delete all zero size .eex files and rerun the script.
-- 4. Zip together all generated (non-zero size) workbook.eex files. Do not include the generated .log files. Note that the .zip needs to be created with older Windows10 compression methods, as the latest Windows11 method cannot be processed by the Oracle 19c database yet.
-- 5. If you have more than one EUL, set the profile option 'Blitz Report Discoverer Default EUL' to the end user layer for which you run the migration
-- 6. Navigate to Setup>Tools>Import>XML Upload and upload the .zip file generated in step 4. You will see a message with the count of uploaded xml files.
-- 7. Run concurrent program 'Blitz Report Discoverer Import' from the System Administrator responsibility, and specify a report name prefix to easily distinguish the migrated reports.
-- 8. Verify the migration result by running reports:
-- 'Blitz Report Parameter Uniqueness Validation' and correct the nonunique parameter names.
-- 'Blitz Report LOV SQL Validation' and correct errors plus change slow 'distinct' style ones to fast SQLs
-- 'Blitz Report SQL Validation' and correct problems
-- 'Blitz Report Parameter Bind Variable Validation'
-- 'DIS Migration identify missing EulConditions'
-- 'Blitz Report Parameter Table Alias Validation'
-- 'Blitz Reports' for Discoverer check for column 'requiredparameters'
-- 'Blitz Report Parameter Default Values' for discoverer check for default value having partition
-- 'Blitz Report Templates' and search for Subtotals: Y in the description and train the users to switch compact pivot to tabular format
-- Workbooks without EUL usage statistics are not listed by default. Set 'Ignore Access History' to Yes to export those as well, optionally restricted by 'Workbook' or 'Workbook Id'.
-- 'Blitz Report Discoverer Import' converts the workbooks selected in the 'DIS Workbook Conversion Selection' upload regardless of access history.
-- In case you need to completely re-run the Discoverer import, for example with a different cut-off date parameter, you can use the following script to purge the previously imported data:
-- declare
-- leul varchar2(30):='eulus';
-- begin
-- --Delete staging tables
-- delete xxendiscovererworkbookxmls xdwx where xdwx.eul=leul;
-- delete from xxendiscovererfnduser xdfu where xdfu.eul=leul;
-- delete from xxendiscovererpivotfields xdpf where xdpf.eul=leul;
-- delete from xxendiscoverersheets xds where xds.eul=leul;
-- delete from xxendiscovererworkbooks xdw where xdw.eul=leul;
-- --Delete all reports from category 'Discoverer' and their related LOVs
-- for c in (select xrca.reportid from xxenreportcategoriesv xrcv, xxenreportcategoryassigns xrca where xrcv.category='Discoverer' and xrcv.categoryid=xrca.categoryid) loop
-- xxenapi.deletereport(c.reportid,'Y');
-- end loop;
-- for c in (select xrplv.lovid from xxenreportparameterlovsv xrplv where xrplv.description=upper(xrplv.description) and xrplv.lovid not in (select xrp.lovid from xxenreportparameters xrp where xrp.parametertype='LOV' and xrp.lovid is not null)) loop
-- xxenapi.deletelov(c.lovid);
-- end loop;
-- commit;
-- end;
-- Excel Example Output: https://www.enginatics.com/example/dis-workbook-export-script/
-- Library Link: https://www.enginatics.com/reports/dis-workbook-export-script/
-- Run Report: https://demo.enginatics.com/

select
'if not exist workbook_'||ed.doc_id||'.eex (start '||:executable_path||' /connect '||:eul||'/'||:eul_password||'@'||:db_service_name||' /export "workbook_'||ed.doc_id||'.eex" /workbook "'||xxen_util.dis_user_name(xxen_util.dis_user(ed.doc_eu_id,:eul),'N')||'.'||ed.doc_name||'" /xmlworkbook) else (echo workbook_'||ed.doc_id||'.eex exists)' text,
ed.doc_name workbook,
ed.doc_id workbook_id,
xxen_util.dis_user_name(ed.doc_eu_id,:eul) owner,
'workbook_'||ed.doc_id||'.eex' file_name
from
&eul.eul5_documents ed
where
1=1 and
(
1=2 &ignore_access_history or
(ed.doc_name, xxen_util.dis_user_name(ed.doc_eu_id,:eul,'N')) in (select eqs.qs_doc_name, upper(eqs.qs_doc_owner) qs_doc_owner from &eul.eul5_qpp_stats eqs where 2=2 &or_owner_restriction)
)
order by
ed.doc_id
