/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2023 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: DBA Parameters
-- Description: To validate recommended settings validate following notes:
Database Initialization Parameters for Oracle E-Business Suite Release 12 (Doc ID 396009.1)
EBS Database Performance and Statistics Analyzer (Doc ID 2126712.1)
Get Proactive with Oracle E-Business Suite - Product Support Analyzer Index (Doc ID 1545562.1)
-- Excel Examle Output: https://www.enginatics.com/example/dba-parameters/
-- Library Link: https://www.enginatics.com/reports/dba-parameters/
-- Run Report: https://demo.enginatics.com/

select
x.*
from
(
select
gp.*,
count(distinct gp.value) over (partition by gp.name) dupl_count
from
gv$parameter gp
) x
where
1=1
order by
x.name,
x.inst_id