/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2020 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: DBA SGA Memory Allocation
-- Description: Current SGA memory usage in gigabytes, showing the split between buffer cache and shared pool
-- Excel Examle Output: https://www.enginatics.com/example/dba-sga-memory-allocation/
-- Library Link: https://www.enginatics.com/reports/dba-sga-memory-allocation/
-- Run Report: https://demo.enginatics.com/

select
gsi.inst_id,
gsi.name,
decode(gsi.name,'Maximum SGA Size',null,gsi.bytes)/sum(decode(gsi.name,'Maximum SGA Size',null,gsi.bytes)) over (partition by gsi.inst_id)*100 percentage,
gsi.bytes/1000000000 memory_size
from
gv$sgainfo gsi
order by
gsi.inst_id,
gsi.bytes desc