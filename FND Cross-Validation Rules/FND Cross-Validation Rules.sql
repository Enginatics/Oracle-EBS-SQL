/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: FND Cross-Validation Rules
-- Description: Cross-validation rules of key flexfield structures, one row per rule element (include or exclude range).
-- Show Violating Combinations lists the enabled accounting flexfield combinations that fail an enabled and currently active rule instead, one row per combination and violated element. A combination outside every include range of a rule is shown against element type Include with blank ranges, a combination inside an exclude range with that exclude range. Oracle validates a combination only when it is created, so combinations created before a rule was defined or tightened stay enabled although they violate it.
-- Segment values are compared with the ranges as text, which matches Oracle's validation for character value sets.
-- Excel Example Output: https://www.enginatics.com/example/fnd-cross-validation-rules/
-- Library Link: https://www.enginatics.com/reports/fnd-cross-validation-rules/
-- Run Report: https://demo.enginatics.com/

select
fav.application_name application,
fif.id_flex_name flexfield,
fifsv.id_flex_structure_name structure,
fvrv.flex_validation_rule_name rule_name,
fvrv.description rule_description,
xxen_util.yes(fvrv.enabled_flag) rule_enabled,
fvrv.start_date_active,
fvrv.end_date_active,
fvrv.error_message_text error_message,
(select fifsv2.segment_name from fnd_id_flex_segments_vl fifsv2 where fvrv.application_id=fifsv2.application_id and fvrv.id_flex_code=fifsv2.id_flex_code and fvrv.id_flex_num=fifsv2.id_flex_num and fvrv.error_segment_column_name=fifsv2.application_column_name) error_segment,
xxen_util.meaning(x.include_exclude_indicator,'INCLUDE_EXCLUDE',0) element_type,
xxen_util.yes(x.element_enabled) element_enabled,
x.segments_low,
x.segments_high,
x.element_description,
x.account,
xxen_util.user_name(fvrv.created_by) rule_created_by,
fvrv.creation_date rule_creation_date,
xxen_util.user_name(fvrv.last_updated_by) rule_last_updated_by,
fvrv.last_update_date rule_last_update_date
from
fnd_flex_vdation_rules_vl fvrv,
fnd_application_vl fav,
fnd_id_flexs fif,
fnd_id_flex_structures_vl fifsv,
(
select
fvrl.application_id,
fvrl.id_flex_code,
fvrl.id_flex_num,
fvrl.flex_validation_rule_name,
fvrl.include_exclude_indicator,
fvrl.enabled_flag element_enabled,
fvrl.concatenated_segments_low segments_low,
fvrl.concatenated_segments_high segments_high,
fvrl.description element_description,
null account,
fvrl.rule_line_id
from
fnd_flex_validation_rule_lines fvrl
where
:show_violating_combinations is null
union all
select
v.application_id,
v.id_flex_code,
v.id_flex_num,
v.flex_validation_rule_name,
v.include_exclude_indicator,
v.element_enabled,
v.segments_low,
v.segments_high,
v.element_description,
v.account,
v.rule_line_id
from
(
select
w.application_id,
w.id_flex_code,
w.id_flex_num,
w.flex_validation_rule_name,
nvl(lc.include_exclude_indicator,'I') include_exclude_indicator,
lc.enabled_flag element_enabled,
lc.concatenated_segments_low segments_low,
lc.concatenated_segments_high segments_high,
lc.description element_description,
w.account,
lc.rule_line_id,
max(decode(lc.include_exclude_indicator,'I',1)) over (partition by w.flex_validation_rule_name, w.id_flex_num, w.code_combination_id) include_matched
from
(
select
fvr.application_id,
fvr.id_flex_code,
fvr.id_flex_num,
fvr.flex_validation_rule_name,
gcck.code_combination_id,
gcck.concatenated_segments account,
gcck.segment1,
gcck.segment2,
gcck.segment3,
gcck.segment4,
gcck.segment5,
gcck.segment6,
gcck.segment7,
gcck.segment8,
gcck.segment9,
gcck.segment10,
gcck.segment11,
gcck.segment12,
gcck.segment13,
gcck.segment14,
gcck.segment15,
gcck.segment16,
gcck.segment17,
gcck.segment18,
gcck.segment19,
gcck.segment20,
gcck.segment21,
gcck.segment22,
gcck.segment23,
gcck.segment24,
gcck.segment25,
gcck.segment26,
gcck.segment27,
gcck.segment28,
gcck.segment29,
gcck.segment30
from
fnd_flex_validation_rules fvr,
gl_code_combinations_kfv gcck
where
:show_violating_combinations='Y' and
2=2 and
fvr.application_id=101 and
fvr.id_flex_code='GL#' and
fvr.enabled_flag='Y' and
trunc(sysdate) between nvl(fvr.start_date_active,trunc(sysdate)) and nvl(fvr.end_date_active,trunc(sysdate)) and
fvr.id_flex_num=gcck.chart_of_accounts_id and
gcck.enabled_flag='Y' and
gcck.summary_flag='N' and
trunc(sysdate) between nvl(gcck.start_date_active,trunc(sysdate)) and nvl(gcck.end_date_active,trunc(sysdate))
) w,
(
select
z.rule_line_id,
z.id_flex_num,
z.flex_validation_rule_name,
z.include_exclude_indicator,
z.enabled_flag,
z.concatenated_segments_low,
z.concatenated_segments_high,
z.description,
max(decode(z.application_column_name,'SEGMENT1',z.segment_low)) segment1_low,
max(decode(z.application_column_name,'SEGMENT1',z.segment_high)) segment1_high,
max(decode(z.application_column_name,'SEGMENT2',z.segment_low)) segment2_low,
max(decode(z.application_column_name,'SEGMENT2',z.segment_high)) segment2_high,
max(decode(z.application_column_name,'SEGMENT3',z.segment_low)) segment3_low,
max(decode(z.application_column_name,'SEGMENT3',z.segment_high)) segment3_high,
max(decode(z.application_column_name,'SEGMENT4',z.segment_low)) segment4_low,
max(decode(z.application_column_name,'SEGMENT4',z.segment_high)) segment4_high,
max(decode(z.application_column_name,'SEGMENT5',z.segment_low)) segment5_low,
max(decode(z.application_column_name,'SEGMENT5',z.segment_high)) segment5_high,
max(decode(z.application_column_name,'SEGMENT6',z.segment_low)) segment6_low,
max(decode(z.application_column_name,'SEGMENT6',z.segment_high)) segment6_high,
max(decode(z.application_column_name,'SEGMENT7',z.segment_low)) segment7_low,
max(decode(z.application_column_name,'SEGMENT7',z.segment_high)) segment7_high,
max(decode(z.application_column_name,'SEGMENT8',z.segment_low)) segment8_low,
max(decode(z.application_column_name,'SEGMENT8',z.segment_high)) segment8_high,
max(decode(z.application_column_name,'SEGMENT9',z.segment_low)) segment9_low,
max(decode(z.application_column_name,'SEGMENT9',z.segment_high)) segment9_high,
max(decode(z.application_column_name,'SEGMENT10',z.segment_low)) segment10_low,
max(decode(z.application_column_name,'SEGMENT10',z.segment_high)) segment10_high,
max(decode(z.application_column_name,'SEGMENT11',z.segment_low)) segment11_low,
max(decode(z.application_column_name,'SEGMENT11',z.segment_high)) segment11_high,
max(decode(z.application_column_name,'SEGMENT12',z.segment_low)) segment12_low,
max(decode(z.application_column_name,'SEGMENT12',z.segment_high)) segment12_high,
max(decode(z.application_column_name,'SEGMENT13',z.segment_low)) segment13_low,
max(decode(z.application_column_name,'SEGMENT13',z.segment_high)) segment13_high,
max(decode(z.application_column_name,'SEGMENT14',z.segment_low)) segment14_low,
max(decode(z.application_column_name,'SEGMENT14',z.segment_high)) segment14_high,
max(decode(z.application_column_name,'SEGMENT15',z.segment_low)) segment15_low,
max(decode(z.application_column_name,'SEGMENT15',z.segment_high)) segment15_high,
max(decode(z.application_column_name,'SEGMENT16',z.segment_low)) segment16_low,
max(decode(z.application_column_name,'SEGMENT16',z.segment_high)) segment16_high,
max(decode(z.application_column_name,'SEGMENT17',z.segment_low)) segment17_low,
max(decode(z.application_column_name,'SEGMENT17',z.segment_high)) segment17_high,
max(decode(z.application_column_name,'SEGMENT18',z.segment_low)) segment18_low,
max(decode(z.application_column_name,'SEGMENT18',z.segment_high)) segment18_high,
max(decode(z.application_column_name,'SEGMENT19',z.segment_low)) segment19_low,
max(decode(z.application_column_name,'SEGMENT19',z.segment_high)) segment19_high,
max(decode(z.application_column_name,'SEGMENT20',z.segment_low)) segment20_low,
max(decode(z.application_column_name,'SEGMENT20',z.segment_high)) segment20_high,
max(decode(z.application_column_name,'SEGMENT21',z.segment_low)) segment21_low,
max(decode(z.application_column_name,'SEGMENT21',z.segment_high)) segment21_high,
max(decode(z.application_column_name,'SEGMENT22',z.segment_low)) segment22_low,
max(decode(z.application_column_name,'SEGMENT22',z.segment_high)) segment22_high,
max(decode(z.application_column_name,'SEGMENT23',z.segment_low)) segment23_low,
max(decode(z.application_column_name,'SEGMENT23',z.segment_high)) segment23_high,
max(decode(z.application_column_name,'SEGMENT24',z.segment_low)) segment24_low,
max(decode(z.application_column_name,'SEGMENT24',z.segment_high)) segment24_high,
max(decode(z.application_column_name,'SEGMENT25',z.segment_low)) segment25_low,
max(decode(z.application_column_name,'SEGMENT25',z.segment_high)) segment25_high,
max(decode(z.application_column_name,'SEGMENT26',z.segment_low)) segment26_low,
max(decode(z.application_column_name,'SEGMENT26',z.segment_high)) segment26_high,
max(decode(z.application_column_name,'SEGMENT27',z.segment_low)) segment27_low,
max(decode(z.application_column_name,'SEGMENT27',z.segment_high)) segment27_high,
max(decode(z.application_column_name,'SEGMENT28',z.segment_low)) segment28_low,
max(decode(z.application_column_name,'SEGMENT28',z.segment_high)) segment28_high,
max(decode(z.application_column_name,'SEGMENT29',z.segment_low)) segment29_low,
max(decode(z.application_column_name,'SEGMENT29',z.segment_high)) segment29_high,
max(decode(z.application_column_name,'SEGMENT30',z.segment_low)) segment30_low,
max(decode(z.application_column_name,'SEGMENT30',z.segment_high)) segment30_high
from
(
select
y.rule_line_id,
y.id_flex_num,
y.flex_validation_rule_name,
y.include_exclude_indicator,
y.enabled_flag,
y.concatenated_segments_low,
y.concatenated_segments_high,
y.description,
fifs.application_column_name,
decode(fifs.segment_position,1,y.segment1_low,2,y.segment2_low,3,y.segment3_low,4,y.segment4_low,5,y.segment5_low,6,y.segment6_low,7,y.segment7_low,8,y.segment8_low,9,y.segment9_low,10,y.segment10_low,11,y.segment11_low,12,y.segment12_low,13,y.segment13_low,14,y.segment14_low,15,y.segment15_low,16,y.segment16_low,17,y.segment17_low,18,y.segment18_low,19,y.segment19_low,20,y.segment20_low,21,y.segment21_low,22,y.segment22_low,23,y.segment23_low,24,y.segment24_low,25,y.segment25_low,26,y.segment26_low,27,y.segment27_low,28,y.segment28_low,29,y.segment29_low,30,y.segment30_low) segment_low,
decode(fifs.segment_position,1,y.segment1_high,2,y.segment2_high,3,y.segment3_high,4,y.segment4_high,5,y.segment5_high,6,y.segment6_high,7,y.segment7_high,8,y.segment8_high,9,y.segment9_high,10,y.segment10_high,11,y.segment11_high,12,y.segment12_high,13,y.segment13_high,14,y.segment14_high,15,y.segment15_high,16,y.segment16_high,17,y.segment17_high,18,y.segment18_high,19,y.segment19_high,20,y.segment20_high,21,y.segment21_high,22,y.segment22_high,23,y.segment23_high,24,y.segment24_high,25,y.segment25_high,26,y.segment26_high,27,y.segment27_high,28,y.segment28_high,29,y.segment29_high,30,y.segment30_high) segment_high
from
(
select fvrl.*, firl.segment1_low, firl.segment1_high, firl.segment2_low, firl.segment2_high, firl.segment3_low, firl.segment3_high, firl.segment4_low, firl.segment4_high, firl.segment5_low, firl.segment5_high, firl.segment6_low, firl.segment6_high, firl.segment7_low, firl.segment7_high, firl.segment8_low, firl.segment8_high, firl.segment9_low, firl.segment9_high, firl.segment10_low, firl.segment10_high, firl.segment11_low, firl.segment11_high, firl.segment12_low, firl.segment12_high, firl.segment13_low, firl.segment13_high, firl.segment14_low, firl.segment14_high, firl.segment15_low, firl.segment15_high, firl.segment16_low, firl.segment16_high, firl.segment17_low, firl.segment17_high, firl.segment18_low, firl.segment18_high, firl.segment19_low, firl.segment19_high, firl.segment20_low, firl.segment20_high, firl.segment21_low, firl.segment21_high, firl.segment22_low, firl.segment22_high, firl.segment23_low, firl.segment23_high, firl.segment24_low, firl.segment24_high, firl.segment25_low, firl.segment25_high, firl.segment26_low, firl.segment26_high, firl.segment27_low, firl.segment27_high, firl.segment28_low, firl.segment28_high, firl.segment29_low, firl.segment29_high, firl.segment30_low, firl.segment30_high from fnd_flex_validation_rule_lines fvrl, fnd_flex_include_rule_lines firl where fvrl.rule_line_id=firl.rule_line_id and fvrl.include_exclude_indicator='I'
union all
select fvrl.*, ferl.segment1_low, ferl.segment1_high, ferl.segment2_low, ferl.segment2_high, ferl.segment3_low, ferl.segment3_high, ferl.segment4_low, ferl.segment4_high, ferl.segment5_low, ferl.segment5_high, ferl.segment6_low, ferl.segment6_high, ferl.segment7_low, ferl.segment7_high, ferl.segment8_low, ferl.segment8_high, ferl.segment9_low, ferl.segment9_high, ferl.segment10_low, ferl.segment10_high, ferl.segment11_low, ferl.segment11_high, ferl.segment12_low, ferl.segment12_high, ferl.segment13_low, ferl.segment13_high, ferl.segment14_low, ferl.segment14_high, ferl.segment15_low, ferl.segment15_high, ferl.segment16_low, ferl.segment16_high, ferl.segment17_low, ferl.segment17_high, ferl.segment18_low, ferl.segment18_high, ferl.segment19_low, ferl.segment19_high, ferl.segment20_low, ferl.segment20_high, ferl.segment21_low, ferl.segment21_high, ferl.segment22_low, ferl.segment22_high, ferl.segment23_low, ferl.segment23_high, ferl.segment24_low, ferl.segment24_high, ferl.segment25_low, ferl.segment25_high, ferl.segment26_low, ferl.segment26_high, ferl.segment27_low, ferl.segment27_high, ferl.segment28_low, ferl.segment28_high, ferl.segment29_low, ferl.segment29_high, ferl.segment30_low, ferl.segment30_high from fnd_flex_validation_rule_lines fvrl, fnd_flex_exclude_rule_lines ferl where fvrl.rule_line_id=ferl.rule_line_id and fvrl.include_exclude_indicator='E'
) y,
(
select
fifs.id_flex_num,
fifs.application_column_name,
row_number() over (partition by fifs.id_flex_num order by fifs.segment_num) segment_position
from
fnd_id_flex_segments fifs
where
fifs.application_id=101 and
fifs.id_flex_code='GL#' and
fifs.enabled_flag='Y'
) fifs
where
y.application_id=101 and
y.id_flex_code='GL#' and
y.enabled_flag='Y' and
y.id_flex_num=fifs.id_flex_num
) z
group by
z.rule_line_id,
z.id_flex_num,
z.flex_validation_rule_name,
z.include_exclude_indicator,
z.enabled_flag,
z.concatenated_segments_low,
z.concatenated_segments_high,
z.description
union all
select
to_number(null) rule_line_id,
fvr.id_flex_num,
fvr.flex_validation_rule_name,
null include_exclude_indicator,
null enabled_flag,
null concatenated_segments_low,
null concatenated_segments_high,
null description,
null segment1_low,
null segment1_high,
null segment2_low,
null segment2_high,
null segment3_low,
null segment3_high,
null segment4_low,
null segment4_high,
null segment5_low,
null segment5_high,
null segment6_low,
null segment6_high,
null segment7_low,
null segment7_high,
null segment8_low,
null segment8_high,
null segment9_low,
null segment9_high,
null segment10_low,
null segment10_high,
null segment11_low,
null segment11_high,
null segment12_low,
null segment12_high,
null segment13_low,
null segment13_high,
null segment14_low,
null segment14_high,
null segment15_low,
null segment15_high,
null segment16_low,
null segment16_high,
null segment17_low,
null segment17_high,
null segment18_low,
null segment18_high,
null segment19_low,
null segment19_high,
null segment20_low,
null segment20_high,
null segment21_low,
null segment21_high,
null segment22_low,
null segment22_high,
null segment23_low,
null segment23_high,
null segment24_low,
null segment24_high,
null segment25_low,
null segment25_high,
null segment26_low,
null segment26_high,
null segment27_low,
null segment27_high,
null segment28_low,
null segment28_high,
null segment29_low,
null segment29_high,
null segment30_low,
null segment30_high
from
fnd_flex_validation_rules fvr
where
fvr.application_id=101 and
fvr.id_flex_code='GL#'
) lc
where
w.id_flex_num=lc.id_flex_num and
w.flex_validation_rule_name=lc.flex_validation_rule_name and
(lc.segment1_low is null or w.segment1>=lc.segment1_low) and (lc.segment1_high is null or w.segment1<=lc.segment1_high) and
(lc.segment2_low is null or w.segment2>=lc.segment2_low) and (lc.segment2_high is null or w.segment2<=lc.segment2_high) and
(lc.segment3_low is null or w.segment3>=lc.segment3_low) and (lc.segment3_high is null or w.segment3<=lc.segment3_high) and
(lc.segment4_low is null or w.segment4>=lc.segment4_low) and (lc.segment4_high is null or w.segment4<=lc.segment4_high) and
(lc.segment5_low is null or w.segment5>=lc.segment5_low) and (lc.segment5_high is null or w.segment5<=lc.segment5_high) and
(lc.segment6_low is null or w.segment6>=lc.segment6_low) and (lc.segment6_high is null or w.segment6<=lc.segment6_high) and
(lc.segment7_low is null or w.segment7>=lc.segment7_low) and (lc.segment7_high is null or w.segment7<=lc.segment7_high) and
(lc.segment8_low is null or w.segment8>=lc.segment8_low) and (lc.segment8_high is null or w.segment8<=lc.segment8_high) and
(lc.segment9_low is null or w.segment9>=lc.segment9_low) and (lc.segment9_high is null or w.segment9<=lc.segment9_high) and
(lc.segment10_low is null or w.segment10>=lc.segment10_low) and (lc.segment10_high is null or w.segment10<=lc.segment10_high) and
(lc.segment11_low is null or w.segment11>=lc.segment11_low) and (lc.segment11_high is null or w.segment11<=lc.segment11_high) and
(lc.segment12_low is null or w.segment12>=lc.segment12_low) and (lc.segment12_high is null or w.segment12<=lc.segment12_high) and
(lc.segment13_low is null or w.segment13>=lc.segment13_low) and (lc.segment13_high is null or w.segment13<=lc.segment13_high) and
(lc.segment14_low is null or w.segment14>=lc.segment14_low) and (lc.segment14_high is null or w.segment14<=lc.segment14_high) and
(lc.segment15_low is null or w.segment15>=lc.segment15_low) and (lc.segment15_high is null or w.segment15<=lc.segment15_high) and
(lc.segment16_low is null or w.segment16>=lc.segment16_low) and (lc.segment16_high is null or w.segment16<=lc.segment16_high) and
(lc.segment17_low is null or w.segment17>=lc.segment17_low) and (lc.segment17_high is null or w.segment17<=lc.segment17_high) and
(lc.segment18_low is null or w.segment18>=lc.segment18_low) and (lc.segment18_high is null or w.segment18<=lc.segment18_high) and
(lc.segment19_low is null or w.segment19>=lc.segment19_low) and (lc.segment19_high is null or w.segment19<=lc.segment19_high) and
(lc.segment20_low is null or w.segment20>=lc.segment20_low) and (lc.segment20_high is null or w.segment20<=lc.segment20_high) and
(lc.segment21_low is null or w.segment21>=lc.segment21_low) and (lc.segment21_high is null or w.segment21<=lc.segment21_high) and
(lc.segment22_low is null or w.segment22>=lc.segment22_low) and (lc.segment22_high is null or w.segment22<=lc.segment22_high) and
(lc.segment23_low is null or w.segment23>=lc.segment23_low) and (lc.segment23_high is null or w.segment23<=lc.segment23_high) and
(lc.segment24_low is null or w.segment24>=lc.segment24_low) and (lc.segment24_high is null or w.segment24<=lc.segment24_high) and
(lc.segment25_low is null or w.segment25>=lc.segment25_low) and (lc.segment25_high is null or w.segment25<=lc.segment25_high) and
(lc.segment26_low is null or w.segment26>=lc.segment26_low) and (lc.segment26_high is null or w.segment26<=lc.segment26_high) and
(lc.segment27_low is null or w.segment27>=lc.segment27_low) and (lc.segment27_high is null or w.segment27<=lc.segment27_high) and
(lc.segment28_low is null or w.segment28>=lc.segment28_low) and (lc.segment28_high is null or w.segment28<=lc.segment28_high) and
(lc.segment29_low is null or w.segment29>=lc.segment29_low) and (lc.segment29_high is null or w.segment29<=lc.segment29_high) and
(lc.segment30_low is null or w.segment30>=lc.segment30_low) and (lc.segment30_high is null or w.segment30<=lc.segment30_high)
) v
where
v.include_exclude_indicator='E' or
v.rule_line_id is null and v.include_matched is null
) x
where
1=1 and
fvrv.application_id=fav.application_id and
fvrv.application_id=fif.application_id and
fvrv.id_flex_code=fif.id_flex_code and
fvrv.application_id=fifsv.application_id and
fvrv.id_flex_code=fifsv.id_flex_code and
fvrv.id_flex_num=fifsv.id_flex_num and
fvrv.application_id=x.application_id(+) and
fvrv.id_flex_code=x.id_flex_code(+) and
fvrv.id_flex_num=x.id_flex_num(+) and
fvrv.flex_validation_rule_name=x.flex_validation_rule_name(+) and
(:show_violating_combinations is null or x.account is not null)
order by
fav.application_name,
fif.id_flex_name,
fifsv.id_flex_structure_name,
fvrv.flex_validation_rule_name,
x.account,
x.include_exclude_indicator desc,
x.segments_low
