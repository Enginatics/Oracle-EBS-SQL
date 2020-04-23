/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2020 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: DBA SGA Target Advice
-- Description: Orace's SGA target advice view.
It shows an estimation of how an SGA resize would affect overall database time and IO.
-- Excel Examle Output: https://www.enginatics.com/example/dba-sga-target-advice
-- Library Link: https://www.enginatics.com/reports/dba-sga-target-advice
-- Run Report: https://demo.enginatics.com/


select
gsta.inst_id,
gsta.sga_size_factor,
gsta.sga_size/1024 sga_size,
gsta.estd_db_time_factor*100 estd_db_time_percent,
gsta.estd_physical_reads_factor*100 estd_physical_reads_percent
from
(
select
gsta.*,
gsta.estd_physical_reads/max(decode(gsta.sga_size_factor,1,gsta.estd_physical_reads)) over (partition by gsta.inst_id) estd_physical_reads_factor
from
gv$sga_target_advice gsta
) gsta