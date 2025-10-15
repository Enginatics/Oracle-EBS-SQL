/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: DBA Editions
-- Description: Database editions, their type and status
-- Excel Examle Output: https://www.enginatics.com/example/dba-editions/
-- Library Link: https://www.enginatics.com/reports/dba-editions/
-- Run Report: https://demo.enginatics.com/

select 
de.edition_name,
de.parent_edition_name,
ad_zd.get_edition_type(de.edition_name) type,
de.usable,
xxen_util.yes(decode(de.edition_name,sys_context('userenv','current_edition_name'),'Y')) "Current"
from
dba_editions de