/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: DBA Database Links
-- Description: Database links with their owner, remote user and connect string.
-- Excel Example Output: https://www.enginatics.com/example/dba-database-links/
-- Library Link: https://www.enginatics.com/reports/dba-database-links/
-- Run Report: https://demo.enginatics.com/

select
ddl.owner,
ddl.db_link,
ddl.username,
ddl.host,
ddl.created
from
dba_db_links ddl
where
1=1
order by
ddl.owner,
ddl.db_link
