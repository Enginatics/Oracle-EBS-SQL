/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: GL effective vs accounting vs period start and end date comparison
-- Description: For developers to understand the GL data: Shows the relationship between effective, accounting and period start and end dates by counting how many records exist where the effective date is before or after the accounting date.
-- Excel Examle Output: https://www.enginatics.com/example/gl-effective-vs-accounting-vs-period-start-and-end-date-comparison/
-- Library Link: https://www.enginatics.com/reports/gl-effective-vs-accounting-vs-period-start-and-end-date-comparison/
-- Run Report: https://demo.enginatics.com/

select
count(*) count,
--gp.start_date,
--gp.end_date,
--gjh.default_effective_date,
--gjl.effective_date,
--xal.accounting_date,
case
when gjh.default_effective_date>=gp.start_date and gjh.default_effective_date<gp.end_date+1 then 'within period'
when gjh.default_effective_date<gp.start_date then 'before'
else 'after'
end gjh_default_effective_date_check,
case
when gjl.effective_date>=gp.start_date and gjl.effective_date<gp.end_date+1 then 'within period'
when gjl.effective_date<gp.start_date then 'before'
else 'after'
end gjl_effective_date_check,
case
when xal.accounting_date>=gp.start_date and xal.accounting_date<gp.end_date+1 then 'within period'
when xal.accounting_date<gp.start_date then 'before'
else 'after'
end xal_accounting_date_check,
case
when trunc(gjl.effective_date)>trunc(xal.accounting_date) then 'gjl.effective_date after xal.accounting_date'
when trunc(gjl.effective_date)<trunc(xal.accounting_date) then 'gjl.effective_date before xal.accounting_date'
else 'same date'
end date_comparison
from
gl_ledgers gl,
gl_periods gp,
gl_je_headers gjh,
gl_je_lines gjl,
gl_import_references gir,
xla_ae_lines xal
where
1=1 and
gl.period_set_name=gp.period_set_name and
gl.accounted_period_type=gp.period_type and
gl.ledger_id=gjl.ledger_id and
gl.ledger_id=gjh.ledger_id and
gp.period_name=gjl.period_name and
gp.period_name=gjh.period_name and
gjh.je_header_id=gjl.je_header_id and
gjl.je_header_id=gir.je_header_id(+) and
gjl.je_line_num=gir.je_line_num(+) and
gir.gl_sl_link_id=xal.gl_sl_link_id(+) and
gir.gl_sl_link_table=xal.gl_sl_link_table
group by
case
when gjh.default_effective_date>=gp.start_date and gjh.default_effective_date<gp.end_date+1 then 'within period'
when gjh.default_effective_date<gp.start_date then 'before'
else 'after'
end,
case
when gjl.effective_date>=gp.start_date and gjl.effective_date<gp.end_date+1 then 'within period'
when gjl.effective_date<gp.start_date then 'before'
else 'after'
end,
case
when xal.accounting_date>=gp.start_date and xal.accounting_date<gp.end_date+1 then 'within period'
when xal.accounting_date<gp.start_date then 'before'
else 'after'
end,
case
when trunc(gjl.effective_date)>trunc(xal.accounting_date) then 'gjl.effective_date after xal.accounting_date'
when trunc(gjl.effective_date)<trunc(xal.accounting_date) then 'gjl.effective_date before xal.accounting_date'
else 'same date'
end
order by
count(*) desc