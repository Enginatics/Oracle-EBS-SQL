/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2023 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: GL Code Combinations
-- Description: Parameter 'Show Misclassified Accounts' can be used to identify code combinations, which have a different account type than their flexfield value setup.
There is an Oracle note explaining the implications of correcting these:
R12: Troubleshooting Misclassified Accounts in General Ledger (Doc ID 872162.1)
<a href="https://support.oracle.com/rs?type=doc&amp;id=872162.1" rel="nofollow" target="_blank">https://support.oracle.com/rs?type=doc&amp;id=872162.1</a>

-- Excel Examle Output: https://www.enginatics.com/example/gl-code-combinations/
-- Library Link: https://www.enginatics.com/reports/gl-code-combinations/
-- Run Report: https://demo.enginatics.com/

select
x.*
from
(
select
fifsv.id_flex_structure_name chart_of_accounts,
xxen_util.meaning(substr(ffv.compiled_value_attributes,5,1),'ACCOUNT_TYPE',0) flex_value_account_type,
nvl(xxen_util.meaning(gcck.gl_account_type,'ACCOUNT_TYPE',0),gcck.gl_account_type) code_combination_account_type,
gcck.*
from
(
select
decode(gcck.account_segment,
'SEGMENT1',gcck.segment1,
'SEGMENT2',gcck.segment2,
'SEGMENT3',gcck.segment3,
'SEGMENT4',gcck.segment4,
'SEGMENT5',gcck.segment5,
'SEGMENT6',gcck.segment6,
'SEGMENT7',gcck.segment7,
'SEGMENT8',gcck.segment8,
'SEGMENT9',gcck.segment9,
'SEGMENT10',gcck.segment10,
'SEGMENT11',gcck.segment11,
'SEGMENT12',gcck.segment12,
'SEGMENT13',gcck.segment13
) account_segment_value,
gcck.*
from
(
select
(
select
fsav.application_column_name
from
fnd_segment_attribute_values fsav
where
gcck.chart_of_accounts_id=fsav.id_flex_num and
fsav.application_id=101 and
fsav.id_flex_code='GL#' and
fsav.segment_attribute_type='GL_ACCOUNT' and
fsav.attribute_value='Y'
) account_segment,
gcck.*
from
gl_code_combinations_kfv gcck
) gcck
) gcck,
fnd_id_flex_structures_vl fifsv,
fnd_id_flex_segments fifs,
fnd_flex_values ffv
where
gcck.chart_of_accounts_id=fifsv.id_flex_num and
fifsv.id_flex_code='GL#' and
fifsv.application_id=101 and
gcck.chart_of_accounts_id=fifs.id_flex_num and
gcck.account_segment=fifs.application_column_name and
fifs.application_id=101 and
fifs.id_flex_code='GL#' and
fifs.flex_value_set_id=ffv.flex_value_set_id and
gcck.account_segment_value=ffv.flex_value and
ffv.parent_flex_value_low is null
) x
where
1=1
order by
x.chart_of_accounts,
x.concatenated_segments