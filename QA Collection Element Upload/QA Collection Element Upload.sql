/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: QA Collection Element Upload
-- Description: Upload to create, update and delete user-defined Quality collection elements.
-- The upload maintains the element name, type, datatype, prompt, display length, mandatory and enabled flags, UOM, default value, data entry hint, SQL validation string and the sequence settings of Sequence elements. Predefined elements are not downloaded and cannot be changed.
-- Specification limits, values and actions are not maintained by this upload. Delete Record removes the element together with its values and actions, and is refused while the element is used in a collection plan.
-- The datatype cannot be changed after the element is created.
-- Excel Example Output: https://www.enginatics.com/example/qa-collection-element-upload/
-- Library Link: https://www.enginatics.com/reports/qa-collection-element-upload/
-- Run Report: https://demo.enginatics.com/

select
null action_,
null status_,
null message_,
null modified_columns_,
qc.name,
xxen_util.meaning(qc.char_type_code,'ELEMENT_TYPE',3) element_type,
xxen_util.meaning(qc.datatype,'QA_CHAR_DATATYPE',700) datatype,
qc.prompt,
qc.display_length,
qc.decimal_precision,
xxen_util.meaning(decode(qc.mandatory_flag,1,'Y','N'),'YES_NO',0) mandatory,
xxen_util.meaning(decode(qc.enabled_flag,1,'Y','N'),'YES_NO',0) enabled,
qc.uom_code,
muom.unit_of_measure,
qc.default_value,
qc.data_entry_hint,
qc.sql_validation_string,
qc.sequence_prefix,
qc.sequence_suffix,
qc.sequence_separator,
qc.sequence_start,
qc.sequence_increment,
qc.sequence_length number_segment_length,
xxen_util.meaning(decode(qc.sequence_zero_pad,1,'Y','N'),'YES_NO',0) zero_pad,
null delete_record,
qc.char_id,
to_number(null) upload_row
from
qa_chars qc,
mtl_units_of_measure muom
where
1=1 and
qc.char_context_flag=1 and
qc.uom_code=muom.uom_code(+)
