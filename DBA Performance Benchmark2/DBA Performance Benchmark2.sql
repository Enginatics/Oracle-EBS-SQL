/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2023 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: DBA Performance Benchmark2
-- Description: Benchmark report to measure a database server's CPU speed, mainly for PLSQL processing.
This report generates an output file of 200000 records from dual.
As the query itself should complete in less than a second, most of the execution time is spend in PLSQL code to generate the Blitz Report output file.
To measure meaningful results, there should be enough SGA memory assigned to ensure that the execution time is entirely spent on CPU and not IO related wait events (to be confirmed using the DBA SGA Active Session History report).

example performance for different CPU types:
seconds	rows/s	CPU
8	25000	AMD Ryzen 9 5950X 16-Core Processor
11	18182
12	16667	AMD EPYC 7742 64-Core Processor
13	15385	Exadata CS X8M
18	11111	Intel(R) Xeon(R) Gold 6252 CPU @ 2.10GHz
20	10000	Intel(R) Xeon(R) CPU E5-2699 v4 @ 2.20GHz
18	11111	Intel(R) Xeon(R) CPU E5-2699 v3 @ 2.30GHz
24	8333	Intel(R) Xeon(R) CPU E5-2670 v2 @ 2.50GHz
22	9091	Intel(R) Xeon(R) CPU E5-2686 v4 @ 2.30GHz 
24	8333	Intel(R) Xeon(R) Platinum 8167M CPU @ 2.00GHz
21	9524	Intel(R) Xeon(R) Platinum 8167M CPU @ 2.00GHz
65	3077	SPARC-T5, chipid 1, clock 3600 MHz

-- Excel Examle Output: https://www.enginatics.com/example/dba-performance-benchmark2/
-- Library Link: https://www.enginatics.com/reports/dba-performance-benchmark2/
-- Run Report: https://demo.enginatics.com/

select
rownum||'SADSA' col1,
rownum||'9873265498743265' col2,
rownum||'fdsgerer' col3,
rownum num1,
sqrt(rownum) num2,
sysdate+mod(rownum,100) dat1,
sysdate+mod(rownum,100) dat2
from dual connect by level<=:row_number