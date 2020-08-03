/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2020 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: GL Header Categories Summary
-- Description: Master data report showing ledger, category and source definitions across multiple ledgers.
-- Excel Examle Output: https://www.enginatics.com/example/gl-header-categories-summary/
-- Library Link: https://www.enginatics.com/reports/gl-header-categories-summary/
-- Run Report: https://demo.enginatics.com/

select /*+ parallel*/ distinct
gl.name ledger,
gjh.je_category category,
gjcv.description category_desc,
&columns1
count(*) over (partition by gl.name, gjh.je_category &partition_by) header_count,
count(distinct gjb.name) over (partition by gl.name &partition_by) batch_name_count,
count(distinct gjh.period_name) over (partition by gl.name, gjh.je_category &partition_by) period_count,
min(distinct gps.start_date) over (partition by gl.name, gjh.je_category &partition_by) min_period_start_date,
max(distinct gps.end_date) over (partition by gl.name, gjh.je_category &partition_by) max_period_end_date,
count(*) over (partition by gl.name, gjh.je_category) total_count
from
gl_ledgers gl,
gl_period_statuses gps,
gl_je_batches gjb,
gl_je_headers gjh,
gl_je_categories_vl gjcv
where
gl.ledger_id=gjh.ledger_id and
gps.application_id=101 and
gps.period_name=gjh.period_name and
gps.ledger_id=gjh.ledger_id and
gjh.status='P' and
gjh.actual_flag='A' and
gjh.je_batch_id=gjb.je_batch_id and
gjh.je_category=gjcv.je_category_key(+)
order by
gl.name,
total_count desc,
gjh.je_category,
header_count desc