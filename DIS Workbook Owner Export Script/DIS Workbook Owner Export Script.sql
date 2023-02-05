/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2023 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: DIS Workbook Owner Export Script
-- Description: If Enginatics helps you with the Discoverer migration, this report generates a script for the mapping between workbook owners and fnd_user ids, which is required when running the Discoverer migration of customer EUL data on Enginatics' servers.
-- Excel Examle Output: https://www.enginatics.com/example/dis-workbook-owner-export-script/
-- Library Link: https://www.enginatics.com/reports/dis-workbook-owner-export-script/
-- Run Report: https://demo.enginatics.com/

select
'insert into xxen_discoverer_fnd_user xdfu values ('''||:eul||''','||fu.user_id||','''||fu.user_name||''',xxen_util.user_id(''ENGINATICS''),sysdate,xxen_util.user_id(''ENGINATICS''),sysdate);' insert_sql
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
ed.doc_batch=0 and
ed.doc_eu_id=eeu.eu_id
)