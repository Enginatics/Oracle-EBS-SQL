/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: DBA Directories
-- Description: Database directory objects with their operating system path and the users granted read, write or execute access to them.
-- Excel Example Output: https://www.enginatics.com/example/dba-directories/
-- Library Link: https://www.enginatics.com/reports/dba-directories/
-- Run Report: https://demo.enginatics.com/

select
dd.directory_name,
dd.directory_path,
dd.owner,
(select listagg(dtp.grantee||' ('||lower(dtp.privilege)||')',', ') within group (order by dtp.grantee, dtp.privilege) from dba_tab_privs dtp where dd.owner=dtp.owner and dd.directory_name=dtp.table_name) grants
from
dba_directories dd
where
1=1
order by
dd.directory_name
