/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: GL Budget Account Range Upload
-- Description: Creates, updates and deletes the account ranges of GL budget organizations - the Excel equivalent of the Ranges region of the Define Budget Organization form (Budgets > Define > Organization).
-- Each row is one account range (line) of a budget organization. Account Low and Account High are entered with all segments, separated by the segment delimiter of the chart of accounts.
-- As in the form, the account range, Entry Type and Currency of an existing line cannot be changed: delete the line and create a new one. Deleting a line also removes its account assignments and budgetary control options.
-- After the upload, Assign Budget Account Ranges is submitted for every budget organization that has new lines. It assigns the accounts of the new ranges to the budget organization; its request is shown in the Assignment Request column.
-- Funds Check Level, Amount Type, Boundary and Funding Budget are the budgetary control options of a line, available for entered lines in the ledger currency of a ledger with budgetary control enabled. A line with several funding budgets takes one row per funding budget.
-- Excel Example Output: https://www.enginatics.com/example/gl-budget-account-range-upload/
-- Library Link: https://www.enginatics.com/reports/gl-budget-account-range-upload/
-- Run Report: https://demo.enginatics.com/

select
null action_,
null status_,
null message_,
null modified_columns_,
null request_id_,
gbar.range_id,
gbbo.funding_budget_version_id,
gl.name ledger,
gbe.name budget_organization,
gbar.sequence_number line,
xxen_gl_upload.budget_range_account(gbar.range_id,'N') account_low,
xxen_gl_upload.budget_range_account(gbar.range_id,'Y') account_high,
xxen_util.meaning(gbar.entry_code,'ENTRY_CODE',101) entry_type,
gbar.currency_code currency,
xxen_util.meaning(gbar.status,'GLBAAR_STATUSES',101) range_status,
xxen_util.meaning(gbbo.funds_check_level_code,'FUNDS_CHECK_LEVEL',101) funds_check_level,
xxen_util.meaning(gbbo.amount_type,'PTD_YTD',101) amount_type,
xxen_util.meaning(gbbo.boundary_code,'BOUNDARY_TYPE',101) boundary,
gbv.budget_name funding_budget,
xxen_util.display_flexfield_context(101,'GL_BUDGET_ASSIGNMENT_RANGES',gbar.context) range_context,
xxen_util.display_flexfield_value(101,'GL_BUDGET_ASSIGNMENT_RANGES',gbar.context,'ATTRIBUTE1',gbar.rowid,gbar.attribute1) range_attribute1,
xxen_util.display_flexfield_value(101,'GL_BUDGET_ASSIGNMENT_RANGES',gbar.context,'ATTRIBUTE2',gbar.rowid,gbar.attribute2) range_attribute2,
xxen_util.display_flexfield_value(101,'GL_BUDGET_ASSIGNMENT_RANGES',gbar.context,'ATTRIBUTE3',gbar.rowid,gbar.attribute3) range_attribute3,
xxen_util.display_flexfield_value(101,'GL_BUDGET_ASSIGNMENT_RANGES',gbar.context,'ATTRIBUTE4',gbar.rowid,gbar.attribute4) range_attribute4,
xxen_util.display_flexfield_value(101,'GL_BUDGET_ASSIGNMENT_RANGES',gbar.context,'ATTRIBUTE5',gbar.rowid,gbar.attribute5) range_attribute5,
xxen_util.display_flexfield_value(101,'GL_BUDGET_ASSIGNMENT_RANGES',gbar.context,'ATTRIBUTE6',gbar.rowid,gbar.attribute6) range_attribute6,
xxen_util.display_flexfield_value(101,'GL_BUDGET_ASSIGNMENT_RANGES',gbar.context,'ATTRIBUTE7',gbar.rowid,gbar.attribute7) range_attribute7,
xxen_util.display_flexfield_value(101,'GL_BUDGET_ASSIGNMENT_RANGES',gbar.context,'ATTRIBUTE8',gbar.rowid,gbar.attribute8) range_attribute8,
xxen_util.display_flexfield_value(101,'GL_BUDGET_ASSIGNMENT_RANGES',gbar.context,'ATTRIBUTE9',gbar.rowid,gbar.attribute9) range_attribute9,
xxen_util.display_flexfield_value(101,'GL_BUDGET_ASSIGNMENT_RANGES',gbar.context,'ATTRIBUTE10',gbar.rowid,gbar.attribute10) range_attribute10,
xxen_util.display_flexfield_value(101,'GL_BUDGET_ASSIGNMENT_RANGES',gbar.context,'ATTRIBUTE11',gbar.rowid,gbar.attribute11) range_attribute11,
xxen_util.display_flexfield_value(101,'GL_BUDGET_ASSIGNMENT_RANGES',gbar.context,'ATTRIBUTE12',gbar.rowid,gbar.attribute12) range_attribute12,
xxen_util.display_flexfield_value(101,'GL_BUDGET_ASSIGNMENT_RANGES',gbar.context,'ATTRIBUTE13',gbar.rowid,gbar.attribute13) range_attribute13,
xxen_util.display_flexfield_value(101,'GL_BUDGET_ASSIGNMENT_RANGES',gbar.context,'ATTRIBUTE14',gbar.rowid,gbar.attribute14) range_attribute14,
xxen_util.display_flexfield_value(101,'GL_BUDGET_ASSIGNMENT_RANGES',gbar.context,'ATTRIBUTE15',gbar.rowid,gbar.attribute15) range_attribute15,
null delete_range,
null delete_funding_budget,
null assignment_request,
null upload_row
from
gl_ledgers gl,
gl_budget_entities gbe,
gl_budget_assignment_ranges gbar,
gl_budorg_bc_options gbbo,
gl_budget_versions gbv
where
1=1 and
gl.ledger_id in (select xroa.id from xxen_report_org_access xroa where xroa.access_type='LEDGER') and
gl.ledger_id=gbe.ledger_id and
gbe.budget_entity_id=gbar.budget_entity_id and
gbar.range_id=gbbo.range_id(+) and
gbbo.funding_budget_version_id=gbv.budget_version_id(+)
