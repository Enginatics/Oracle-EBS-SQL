/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: GL Oracle FSG Converter
-- Description: The GL Oracle FSG Converter is used for migration of financial statement reports from Oracle Financial Statement Generator (FSG) into the GL Financial Statement and Drilldown (FSG) report. This converter simplifies the process of transferring the existing Oracle FSG reports, allowing users to leverage advanced reporting and drilldown capabilities with minimal setup.

This version supports DB versions above 12c. To apply the converter, the profile 'Blitz FSG Oracle to Blitz Report Converter' must be updated with the relevant report name based on the db version.

For a quick demonstration of GL Financial Statement and Drilldown (FSG), refer to our YouTube video.
<a href="https://youtu.be/dsRWXT2bem8?si=bA8cAxuXjfrMI-SI" rel="nofollow" target="_blank">https://youtu.be/dsRWXT2bem8?si=bA8cAxuXjfrMI-SI</a>
-- Excel Examle Output: https://www.enginatics.com/example/gl-oracle-fsg-converter/
-- Library Link: https://www.enginatics.com/reports/gl-oracle-fsg-converter/
-- Run Report: https://demo.enginatics.com/

select x.* from (
with merged_data as (
select distinct
listagg(y.sequence,'|')within group (order by y.sequence_) over (partition by 1) sequence,
listagg(y.description,'|')within group (order by y.sequence_) over (partition by 1) description,
replace(listagg(y.amount_type,'|')within group (order by y.sequence_) over (partition by 1),'~^') amount_type,
replace(listagg(y.period,'|')within group (order by y.sequence_) over (partition by 1),'~^') period,
replace(listagg(nvl(y.calculation,'~^'),'|')within group (order by y.sequence_) over (partition by 1),'~^') calculation,
y.report_title,
&column_segments
y.segment_override
from
(
select distinct
&column_segments_
x.*
from 
(
select distinct
rrv.report_title,
rrav.position,
rrv.segment_override,
rrav.sequence||':'||rrav.name sequence,
rrav.sequence sequence_,
rrav.description,
nvl(rrav.amount_type,'~^') amount_type,
case 
when rrav.period_offset=0 then '''=enter_period_name' 
when nvl(rrav.period_offset,0)<>0 then '''=br_period_offset(enter_period_name,"'||rrav.period_offset||'",,,)'
when rrav.amount_type is not null then '''=enter_period_name' 
else '~^'
end period,
nvl((select distinct
'''='||listagg(case when rrc.axis_seq_low=rrc.axis_seq_high then replace(rrc.operator||rrc.axis_seq_low,'ENTER') when rrc.axis_name_low=rrc.axis_name_high then replace(rrc.operator||rrc.axis_name_low,'ENTER') 
else 
case when rrc.operator='+' then  case when rrc.constant is null then nvl(to_char(rrc.axis_seq_high),rrc.axis_name_high)||'+'||nvl(to_char(rrc.axis_seq_low),rrc.axis_name_low) else '+'||rrc.constant end 
when rrc.operator='-' then case when rrc.constant is null then nvl(to_char(rrc.axis_seq_high),rrc.axis_name_high)||'-'||nvl(to_char(rrc.axis_seq_low),rrc.axis_name_low) else '-'||rrc.constant end 
when rrc.operator='*' then case when rrc.constant is null then nvl(to_char(rrc.axis_seq_high),rrc.axis_name_high)||'*'||nvl(to_char(rrc.axis_seq_low),rrc.axis_name_low) else '*'||rrc.constant end 
when rrc.operator='/' then case when rrc.constant is null then nvl(to_char(rrc.axis_seq_high),rrc.axis_name_high)||'/'||nvl(to_char(rrc.axis_seq_low),rrc.axis_name_low) else '/'||rrc.constant end 
when rrc.operator='ENTER' then  case 
when nvl(to_char(rrc.axis_seq_low),rrc.axis_name_low) is not null and nvl(to_char(rrc.axis_seq_high),rrc.axis_name_high) is not null then 'sum('||nvl(to_char(rrc.axis_seq_high),rrc.axis_name_high)||':'||nvl(to_char(rrc.axis_seq_low),rrc.axis_name_low)||')' 
when rrc.constant is null then '+'||nvl(nvl(to_char(rrc.axis_seq_high),rrc.axis_name_high),nvl(to_char(rrc.axis_seq_low),rrc.axis_name_low))
else '+'||rrc.constant 
end 
else nvl(to_char(rrc.axis_seq_high),rrc.axis_name_high)||'%'||nvl(to_char(rrc.axis_seq_low),rrc.axis_name_low) end
end,'') within group (order by rrc.calculation_seq) over (partition by rrc.axis_seq)
from
rg_report_calculations rrc
where 
rrav.axis_set_id=rrc.axis_set_id and
rrav.sequence=rrc.axis_seq ),'~^') calculation,
&column_segments_base
count(*) over (partition by rrav.sequence) cnt
from
rg_reports_v rrv,
rg_report_axes_v rrav,
rg_report_axis_contents rrac
where
1=1 and
rrav.axis_set_id=rrv.column_set_id and
rrav.axis_set_id=rrac.axis_set_id(+) and
rrav.sequence=rrac.axis_seq(+)
order by
rrav.position
) x
) y
)
select null multiply, null movement, &columnset_null_segments 'Ledger:' description, null sequence, null calculation, null line_format, :ledger column_value from merged_data
union all
select null multiply, null movement, &columnset_null_segments 'Report Title:' description, null sequence, null calculation, null line_format, report_title column_value from merged_data
union all
select null multiply, null movement, &columnset_null_segments 'Current Period:' description, null sequence, null calculation, null line_format, xxen_util.latest_open_period(:ledger) column_value from merged_data
union all
select null multiply, null movement, &columnset_null_segments 'Segment Override' description, null sequence, null calculation, null line_format, segment_override column_value from merged_data
union all
select null multiply, null movement, &columnset_null_segments 'Sequence' description, null sequence, null calculation, null line_format, sequence column_value from merged_data
union all
select null multiply, null movement, &columnset_null_segments 'Amount Type' description, null sequence, null calculation, null line_format, amount_type column_value from merged_data
union all
select null multiply, null movement, &columnset_null_segments 'Periods' description, null sequence, null calculation, null line_format, period column_value from merged_data
union all
select null multiply, null movement, &columnset_null_segments 'Column Calculations' description, null sequence, null calculation, null line_format, calculation column_value from merged_data
&column_segments_union
) x
union all
select distinct y.* from (
select distinct
case when x.sign = '+' then 1 when x.sign = '-' then -1 end multiply,
case when x.dr_cr_net_code='N' then 'Net' when x.dr_cr_net_code='D' then 'Dr' when x.dr_cr_net_code='C' then 'Cr' end movement,
&rowset_segments_case
x.description,
x.sequence||':'||x.axis_name sequence,
case when x.row_type='C' then
(select distinct
'''='||listagg(case when rrc.axis_seq_low=rrc.axis_seq_high then replace(rrc.operator||rrc.axis_seq_low,'ENTER') when rrc.axis_name_low=rrc.axis_name_high then replace(rrc.operator||rrc.axis_name_low,'ENTER') 
else 
case when rrc.operator='+' then  case when rrc.constant is null then nvl(to_char(rrc.axis_seq_high),rrc.axis_name_high)||'+'||nvl(to_char(rrc.axis_seq_low),rrc.axis_name_low) else '+'||rrc.constant end 
when rrc.operator='-' then case when rrc.constant is null then nvl(to_char(rrc.axis_seq_high),rrc.axis_name_high)||'-'||nvl(to_char(rrc.axis_seq_low),rrc.axis_name_low) else '-'||rrc.constant end 
when rrc.operator='*' then case when rrc.constant is null then nvl(to_char(rrc.axis_seq_high),rrc.axis_name_high)||'*'||nvl(to_char(rrc.axis_seq_low),rrc.axis_name_low) else '*'||rrc.constant end 
when rrc.operator='/' then case when rrc.constant is null then nvl(to_char(rrc.axis_seq_high),rrc.axis_name_high)||'/'||nvl(to_char(rrc.axis_seq_low),rrc.axis_name_low) else '/'||rrc.constant end 
when rrc.operator='ENTER' then  case 
when nvl(to_char(rrc.axis_seq_low),rrc.axis_name_low) is not null and nvl(to_char(rrc.axis_seq_high),rrc.axis_name_high) is not null then 'sum('||nvl(to_char(rrc.axis_seq_high),rrc.axis_name_high)||':'||nvl(to_char(rrc.axis_seq_low),rrc.axis_name_low)||')' 
when rrc.constant is null then '+'||nvl(nvl(to_char(rrc.axis_seq_high),rrc.axis_name_high),nvl(to_char(rrc.axis_seq_low),rrc.axis_name_low))
else '+'||rrc.constant 
end 
else nvl(to_char(rrc.axis_seq_high),rrc.axis_name_high)||'%'||nvl(to_char(rrc.axis_seq_low),rrc.axis_name_low) end
end,'') within group (order by rrc.calculation_seq) over (partition by rrc.axis_seq)
from
rg_report_calculations rrc
where
rrc.axis_set_id=x.axis_set_id and
rrc.axis_seq=x.sequence) end calculation,
x.line_format,
null column_value
from
(
select 
rrav.sequence,
count(*) over (partition by rrav.sequence) cnt,
rrac.range_mode,
rrac.sign,
rrac.dr_cr_net_code,
&rowset_segments
rrav.description,
case when rrc.calculation_seq is not null then 'C' when rrac.axis_set_id is not null then 'R' else 'T' end row_type,
rrav.before_axis_string||':'||rrav.after_axis_string||':'||rrav.number_lines_skipped_before||':'||rrav.number_lines_skipped_after line_format,
rrav.axis_set_id,
rrav.name axis_name
from
rg_reports_v rrv,
rg_report_axes_v rrav,
rg_report_axis_contents rrac,
rg_report_calculations rrc
where
1=1 and
rrav.axis_set_id=rrv.row_set_id and
rrav.display_flag='Y' and
rrav.axis_set_id=rrac.axis_set_id(+) and
rrav.sequence=rrac.axis_seq(+) and
rrav.axis_set_id=rrc.axis_set_id(+) and
rrav.sequence=rrc.axis_seq(+)
) x
order by
to_number(substr(sequence,1,instr(sequence,':')-1))
) y
union all
select y.* from(
select
null mutliply,
null movement,
&contentset_select_segments
'Content Set' description,
null sequence,
null calculation,
null line_format,
null column_value
from
(
select
&contentset_case_segments
rrco.override_seq
from
rg_reports_v rrv,
rg_report_content_overrides rrco
where
1=1 and
rrv.content_set_id=rrco.content_set_id
) x
order by
x.override_seq
) y