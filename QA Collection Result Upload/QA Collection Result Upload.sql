/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: QA Collection Result Upload
-- Description: Enters and updates quality results of any collection plan, as the Enter Quality Results and Update Quality Results forms do, through the Oracle Quality results API with its element validations.
-- The Plan parameter selects the collection plan. The plan's text and comment elements are shown in the columns Char1 to Char40, its number elements in Number1 to Number20 and its date elements in Date1 to Date10, each type in the plan's prompt sequence, with the column headings showing the element prompts. Columns without an element keep their generic heading and stay empty; hide them with a template per plan.
-- Create, Update mode downloads the plan's existing results. An updated row writes only the element values that were changed, and Oracle records each in the result update history.
-- Plans with actions, Sequence elements or Date and Time elements are not supported.
-- Excel Example Output: https://www.enginatics.com/example/qa-collection-result-upload/
-- Library Link: https://www.enginatics.com/reports/qa-collection-result-upload/
-- Run Report: https://demo.enginatics.com/

select
null action_,
null status_,
null message_,
null modified_columns_,
mp.organization_code,
qp.name plan_name,
xxen_qa_upload.result_char(qr.plan_id,qr.occurrence,qr.last_update_date,1) char1,
xxen_qa_upload.result_char(qr.plan_id,qr.occurrence,qr.last_update_date,2) char2,
xxen_qa_upload.result_char(qr.plan_id,qr.occurrence,qr.last_update_date,3) char3,
xxen_qa_upload.result_char(qr.plan_id,qr.occurrence,qr.last_update_date,4) char4,
xxen_qa_upload.result_char(qr.plan_id,qr.occurrence,qr.last_update_date,5) char5,
xxen_qa_upload.result_char(qr.plan_id,qr.occurrence,qr.last_update_date,6) char6,
xxen_qa_upload.result_char(qr.plan_id,qr.occurrence,qr.last_update_date,7) char7,
xxen_qa_upload.result_char(qr.plan_id,qr.occurrence,qr.last_update_date,8) char8,
xxen_qa_upload.result_char(qr.plan_id,qr.occurrence,qr.last_update_date,9) char9,
xxen_qa_upload.result_char(qr.plan_id,qr.occurrence,qr.last_update_date,10) char10,
xxen_qa_upload.result_char(qr.plan_id,qr.occurrence,qr.last_update_date,11) char11,
xxen_qa_upload.result_char(qr.plan_id,qr.occurrence,qr.last_update_date,12) char12,
xxen_qa_upload.result_char(qr.plan_id,qr.occurrence,qr.last_update_date,13) char13,
xxen_qa_upload.result_char(qr.plan_id,qr.occurrence,qr.last_update_date,14) char14,
xxen_qa_upload.result_char(qr.plan_id,qr.occurrence,qr.last_update_date,15) char15,
xxen_qa_upload.result_char(qr.plan_id,qr.occurrence,qr.last_update_date,16) char16,
xxen_qa_upload.result_char(qr.plan_id,qr.occurrence,qr.last_update_date,17) char17,
xxen_qa_upload.result_char(qr.plan_id,qr.occurrence,qr.last_update_date,18) char18,
xxen_qa_upload.result_char(qr.plan_id,qr.occurrence,qr.last_update_date,19) char19,
xxen_qa_upload.result_char(qr.plan_id,qr.occurrence,qr.last_update_date,20) char20,
xxen_qa_upload.result_char(qr.plan_id,qr.occurrence,qr.last_update_date,21) char21,
xxen_qa_upload.result_char(qr.plan_id,qr.occurrence,qr.last_update_date,22) char22,
xxen_qa_upload.result_char(qr.plan_id,qr.occurrence,qr.last_update_date,23) char23,
xxen_qa_upload.result_char(qr.plan_id,qr.occurrence,qr.last_update_date,24) char24,
xxen_qa_upload.result_char(qr.plan_id,qr.occurrence,qr.last_update_date,25) char25,
xxen_qa_upload.result_char(qr.plan_id,qr.occurrence,qr.last_update_date,26) char26,
xxen_qa_upload.result_char(qr.plan_id,qr.occurrence,qr.last_update_date,27) char27,
xxen_qa_upload.result_char(qr.plan_id,qr.occurrence,qr.last_update_date,28) char28,
xxen_qa_upload.result_char(qr.plan_id,qr.occurrence,qr.last_update_date,29) char29,
xxen_qa_upload.result_char(qr.plan_id,qr.occurrence,qr.last_update_date,30) char30,
xxen_qa_upload.result_char(qr.plan_id,qr.occurrence,qr.last_update_date,31) char31,
xxen_qa_upload.result_char(qr.plan_id,qr.occurrence,qr.last_update_date,32) char32,
xxen_qa_upload.result_char(qr.plan_id,qr.occurrence,qr.last_update_date,33) char33,
xxen_qa_upload.result_char(qr.plan_id,qr.occurrence,qr.last_update_date,34) char34,
xxen_qa_upload.result_char(qr.plan_id,qr.occurrence,qr.last_update_date,35) char35,
xxen_qa_upload.result_char(qr.plan_id,qr.occurrence,qr.last_update_date,36) char36,
xxen_qa_upload.result_char(qr.plan_id,qr.occurrence,qr.last_update_date,37) char37,
xxen_qa_upload.result_char(qr.plan_id,qr.occurrence,qr.last_update_date,38) char38,
xxen_qa_upload.result_char(qr.plan_id,qr.occurrence,qr.last_update_date,39) char39,
xxen_qa_upload.result_char(qr.plan_id,qr.occurrence,qr.last_update_date,40) char40,
xxen_qa_upload.result_number(qr.plan_id,qr.occurrence,qr.last_update_date,1) number1,
xxen_qa_upload.result_number(qr.plan_id,qr.occurrence,qr.last_update_date,2) number2,
xxen_qa_upload.result_number(qr.plan_id,qr.occurrence,qr.last_update_date,3) number3,
xxen_qa_upload.result_number(qr.plan_id,qr.occurrence,qr.last_update_date,4) number4,
xxen_qa_upload.result_number(qr.plan_id,qr.occurrence,qr.last_update_date,5) number5,
xxen_qa_upload.result_number(qr.plan_id,qr.occurrence,qr.last_update_date,6) number6,
xxen_qa_upload.result_number(qr.plan_id,qr.occurrence,qr.last_update_date,7) number7,
xxen_qa_upload.result_number(qr.plan_id,qr.occurrence,qr.last_update_date,8) number8,
xxen_qa_upload.result_number(qr.plan_id,qr.occurrence,qr.last_update_date,9) number9,
xxen_qa_upload.result_number(qr.plan_id,qr.occurrence,qr.last_update_date,10) number10,
xxen_qa_upload.result_number(qr.plan_id,qr.occurrence,qr.last_update_date,11) number11,
xxen_qa_upload.result_number(qr.plan_id,qr.occurrence,qr.last_update_date,12) number12,
xxen_qa_upload.result_number(qr.plan_id,qr.occurrence,qr.last_update_date,13) number13,
xxen_qa_upload.result_number(qr.plan_id,qr.occurrence,qr.last_update_date,14) number14,
xxen_qa_upload.result_number(qr.plan_id,qr.occurrence,qr.last_update_date,15) number15,
xxen_qa_upload.result_number(qr.plan_id,qr.occurrence,qr.last_update_date,16) number16,
xxen_qa_upload.result_number(qr.plan_id,qr.occurrence,qr.last_update_date,17) number17,
xxen_qa_upload.result_number(qr.plan_id,qr.occurrence,qr.last_update_date,18) number18,
xxen_qa_upload.result_number(qr.plan_id,qr.occurrence,qr.last_update_date,19) number19,
xxen_qa_upload.result_number(qr.plan_id,qr.occurrence,qr.last_update_date,20) number20,
xxen_qa_upload.result_date(qr.plan_id,qr.occurrence,qr.last_update_date,1) date1,
xxen_qa_upload.result_date(qr.plan_id,qr.occurrence,qr.last_update_date,2) date2,
xxen_qa_upload.result_date(qr.plan_id,qr.occurrence,qr.last_update_date,3) date3,
xxen_qa_upload.result_date(qr.plan_id,qr.occurrence,qr.last_update_date,4) date4,
xxen_qa_upload.result_date(qr.plan_id,qr.occurrence,qr.last_update_date,5) date5,
xxen_qa_upload.result_date(qr.plan_id,qr.occurrence,qr.last_update_date,6) date6,
xxen_qa_upload.result_date(qr.plan_id,qr.occurrence,qr.last_update_date,7) date7,
xxen_qa_upload.result_date(qr.plan_id,qr.occurrence,qr.last_update_date,8) date8,
xxen_qa_upload.result_date(qr.plan_id,qr.occurrence,qr.last_update_date,9) date9,
xxen_qa_upload.result_date(qr.plan_id,qr.occurrence,qr.last_update_date,10) date10,
qr.occurrence,
null upload_row
from
qa_plans qp,
mtl_parameters mp,
qa_results qr
where
1=1 and
qp.organization_id=:organization_id and
qp.plan_id=:plan_id and
qp.organization_id in (select xroa.id from xxen_report_org_access xroa where xroa.access_type='INV') and
qp.organization_id=mp.organization_id and
qp.plan_id=qr.plan_id and
(qr.status is null or qr.status=2)
