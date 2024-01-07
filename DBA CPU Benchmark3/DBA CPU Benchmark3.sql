/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: DBA CPU Benchmark3
-- Description: This Benchmark report measures a database server's CPU performance for arithmetic calculations by calculating about 40 million square roots.

example performance for different CPU types:
seconds	rows/s	CPU
7	285714	AMD Ryzen 9 5950X 16-Core Processor
13	153846	
12	166667	AMD EPYC 7742 64-Core Processor
31	64516	Exadata CS X8M
42	47619	Intel(R) Xeon(R) Gold 6252 CPU @ 2.10GHz
42	47619	Intel(R) Xeon(R) CPU E5-2699 v4 @ 2.20GHz
41	48780	Intel(R) Xeon(R) CPU E5-2699 v3 @ 2.30GHz
41	48780	Intel(R) Xeon(R) CPU E5-2670 v2 @ 2.50GHz
43	46512	Intel(R) Xeon(R) CPU E5-2686 v4 @ 2.30GHz 
49	40816	Intel(R) Xeon(R) Platinum 8167M CPU @ 2.00GHz
47	42553	Intel(R) Xeon(R) Platinum 8167M CPU @ 2.00GHz
115	17391	SPARC-T5, chipid 1, clock 3600 MHz
-- Excel Examle Output: https://www.enginatics.com/example/dba-cpu-benchmark3/
-- Library Link: https://www.enginatics.com/reports/dba-cpu-benchmark3/
-- Run Report: https://demo.enginatics.com/

select
avg(sqrt(rownum-0.243)+sqrt(rownum+0.873)) num1,
avg(sqrt(rownum-0.123)+sqrt(rownum+0.537)) num2,
avg(sqrt(rownum-0.211)+sqrt(rownum+0.764)) num3,
avg(sqrt(rownum-0.742)+sqrt(rownum+0.372)) num4,
avg(sqrt(rownum-0.850)+sqrt(rownum+0.683)) num5,
avg(sqrt(rownum-0.563)+sqrt(rownum+0.787)) num6,
avg(sqrt(rownum-0.333)+sqrt(rownum+0.543)) num7,
avg(sqrt(rownum-0.985)+sqrt(rownum+0.481)) num8,
avg(sqrt(rownum-0.122)+sqrt(rownum+0.250)) num9,
avg(sqrt(rownum-0.547)+sqrt(rownum+0.434)) num10
from
dual connect by level<=2000000