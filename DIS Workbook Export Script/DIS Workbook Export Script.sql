/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: DIS Workbook Export Script
-- Description: <a href="https://youtu.be/17_Au_11IBE" rel="nofollow" target="_blank">https://youtu.be/17_Au_11IBE</a>
Use this report to migrate Discoverer workbooks to Blitz Report through the following steps:

1. Run this report 'DIS Workbook Export Script' to generate a list of commands to export xmls for all recently used Discoverer workbooks.
2. Create a new folder on a windows machine having the Discoverer Admin executable dis51adm.exe installed (contact Enginatics, if you need help with the Discoverer Administrator installation).
3. Open a Command Prompt window, cd to the new folder, and execute (copy and paste) the commands generated in step 1. This will start individual processes to export the workbooks as .eex files. Depending on your client capacity, you can run between 100 and 200 export processes at the same time. In case of errors, delete all zero size .eex files and rerun the script.
4. Zip together all generated (non-zero size) workbook_*.eex files. Do not include the generated *.log files.
5. If you have more than one EUL, set the profile option 'Blitz Report Discoverer Default EUL' to the end user layer for which you run the migration
6. Navigate to Setup>Tools>Import>XML Upload and upload the .zip file generated in step 4. You will see a message with the count of uploaded xml files.
7. Run concurrent program 'Blitz Report Discoverer Import' from the System Administrator responsibility, and specify a report name prefix to easily distinguish the migrated reports.
8. Verify the migration result by running reports: Blitz Report SQL Validation, Blitz Report LOV SQL Validation, DIS Workbook Import Validation, DIS End User Layers. The migrated reports are assigned to a new Discoverer category.
-- Excel Examle Output: https://www.enginatics.com/example/dis-workbook-export-script/
-- Library Link: https://www.enginatics.com/reports/dis-workbook-export-script/
-- Run Report: https://demo.enginatics.com/

select
'if not exist workbook_'||ed.doc_id||'.eex (start '||:executable_path||' /connect '||:eul||'/'||:eul_password||'@'||:db_service_name||' /export "workbook_'||ed.doc_id||'.eex" /workbook "'||xxen_util.dis_user_name(xxen_util.dis_user(ed.doc_eu_id,:eul),'N')||'.'||ed.doc_name||'" /xmlworkbook'||chr(38)||' ping /n '||:delay_seconds||' localhost >NUL) else (echo workbook_'||ed.doc_id||'.eex exists)' text,
ed.doc_name workbook,
xxen_util.dis_user_name(ed.doc_eu_id,:eul) owner,
'workbook_'||ed.doc_id||'.eex' file_name
from
&eul.eul5_documents ed
where
1=1 and
(ed.doc_name, xxen_util.dis_user_name(ed.doc_eu_id,:eul,'N')) in (select eqs.qs_doc_name, upper(eqs.qs_doc_owner) qs_doc_owner from &eul.eul5_qpp_stats eqs where 2=2 &or_owner_restriction)
order by
ed.doc_id