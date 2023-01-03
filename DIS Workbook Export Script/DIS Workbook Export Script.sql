/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2023 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: DIS Workbook Export Script
-- Description: Use this report to generate the commands to export your recently excuted workbooks as individual XML files (20 seconds delay between each export).
You can open several (e.g. 5) cmd windows in parallel and copy the commands from each sheet into the windows to run the export.

Discoverer admin might fail to export some of the workbooks or create them with zero size.
In such case, you should remove any zero size workbook xml files and rerun the whole script (already existing files are not re-exported)
-- Excel Examle Output: https://www.enginatics.com/example/dis-workbook-export-script/
-- Library Link: https://www.enginatics.com/reports/dis-workbook-export-script/
-- Run Report: https://demo.enginatics.com/

select
'if not exist workbook_'||ed.doc_id||'.eex (start '||:executable_path||' /connect '||:eul||'/'||:eul_password||'@'||:db_service_name||' /export "workbook_'||ed.doc_id||'.eex" /workbook "'||nvl(fu.user_name,eeu.eu_username)||'.'||ed.doc_name||'" /xmlworkbook'||chr(38)||' ping /n '||:delay_seconds||' localhost >NUL) else (echo workbook_'||ed.doc_id||'.eex exists)' text
from
&eul.eul5_documents ed,
&eul.eul5_eul_users eeu,
fnd_user fu
where
1=1 and
ed.doc_name in (select eqs.qs_doc_name from &eul.eul5_qpp_stats eqs where 2=2) and
ed.doc_eu_id=eeu.eu_id and
case when eeu.eu_username like '#%' then to_number(substr(eeu.eu_username,2)) end=fu.user_id(+)
order by
ed.doc_id