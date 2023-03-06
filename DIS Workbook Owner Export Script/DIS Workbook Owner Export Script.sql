/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2023 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: DIS Workbook Owner Export Script
-- Description: This export of workbook owners is required to remotely export workbook XMLs on the Enginatics environments for customers requiring support when migrating from Discoverer to Blitz Report.
-- Excel Examle Output: https://www.enginatics.com/example/dis-workbook-owner-export-script/
-- Library Link: https://www.enginatics.com/reports/dis-workbook-owner-export-script/
-- Run Report: https://demo.enginatics.com/

select
'insert into xxen_discoverer_fnd_user (eul,user_id,user_name) values ('''||:eul||''','||fu.user_id||','''||fu.user_name||''');' insert_sql
from
fnd_user fu
where
fu.user_id in
(
select distinct
case when eeu.eu_username like '#%' and eeu.eu_username not like '#%#%' then to_number(substr(eeu.eu_username,2)) end user_id
from
&eul.eul5_documents ed,
&eul.eul5_eul_users eeu
where
ed.doc_eu_id=eeu.eu_id
)
union all
select 'commit;' insert_sql from dual