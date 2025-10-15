/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: DBA Editioned Object Summary
-- Description: Summary of editioned objects per edition from ADZDSHOWOBJS.sql
There is a good blog: <a href="https://www.pythian.com/blog/technical-track/adop-edition-cleanup" rel="nofollow" target="_blank">https://www.pythian.com/blog/technical-track/adop-edition-cleanup</a>
-- Excel Examle Output: https://www.enginatics.com/example/dba-editioned-object-summary/
-- Library Link: https://www.enginatics.com/reports/dba-editioned-object-summary/
-- Run Report: https://demo.enginatics.com/

select
eusr.edition_name edition_name,
count(decode(obj.type#,88,null,decode(obj.status,1,1,null))) actual_valid,
count(decode(obj.type#,88,null,decode(obj.status,1,null,1))) actual_invalid,
count(decode(obj.type#,88,null,1)) actual_total,
count(decode(obj.type#,88,decode(obj.status,1,1,null),null)) stub_valid,
count(decode(obj.type#,88,decode(obj.status,1,null,1),null)) stub_invalid,
count(decode(obj.type#,88,1,null)) stub_total,
count(1) total
from
sys.obj$ obj,
sys.obj$ bobj,
(
select
xusr.user#,
xusr.ext_username user_name,
ed.name edition_name
from
(select * from sys.user$ where type#=2) xusr,
(select * from sys.obj$ where owner#=0 and type#=57) ed
where
xusr.spare2=ed.obj#
union
select
busr.user#,
busr.name user_name,
ed.name edition_name
from
(select * from sys.user$ where type#=1 or user#=1) busr,
(select * from sys.obj$ where owner#=0 and type#=57) ed
where ed.name='ORA$BASE'
) eusr
where
(obj.type# in (4,5,7,8,9,11,12,13,14,22,87) or obj.type#=88 and bobj.type#<>10) and
obj.remoteowner is null and
obj.owner#=eusr.user# and
eusr.user_name in (select du.username from dba_users du where du.editions_enabled='Y') and
obj.dataobj#=bobj.obj#(+)
group by
eusr.edition_name
order by 1, 2