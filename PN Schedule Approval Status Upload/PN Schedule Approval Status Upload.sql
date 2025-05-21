/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: PN Schedule Approval Status Upload
-- Description: Property Management - Schedule Approval Status Upload

This upload allows users to Approve (Approved status), Un-Approve (Draft status), or place On Hold Payment and Billing Schedules in Property Management. This upload offers the same functionality as the Oracle Authorize Payments and the Authorize Billings forms.

Upload Mode
=================
When run in “Create, Update” mode, the Payment/Billing Schedules matching the criteria specified in the report parameters will be downloaded into Excel where the user can review and amend the Payment/Billing Approval Status and, for approved schedules, the Approver and the Period.

When run in “Create” mode, an empty excel will be generated. This mode allows the user to paste Payment/Billing schedule data from another source. In this mode the upload will find the matching Payment/Billing Schedule based on the data in each excel row and apply the approval change. The upload will return an error message if the upload cannot find a matching schedule, or if it finds multiple matching schedules.

Approved Schedules
=================
- if the Approver is not specified in the upload excel, then the username of the user executing the upload is used.
- if the Period is not specified in the upload excel, then this will be derived during the upload based on the Schedule Date

Notes
=================
You cannot create new Payment/Billing schedules using this upload. It can only be used for updating the approval status of existing Payment/Billing Schedules.

-- Excel Examle Output: https://www.enginatics.com/example/pn-schedule-approval-status-upload/
-- Library Link: https://www.enginatics.com/reports/pn-schedule-approval-status-upload/
-- Run Report: https://demo.enginatics.com/

select
null action_,
null status_,
null message_,
null request_id_,
null modified_columns_,
ppsv.payment_schedule_id,
--
haouv.name operating_unit,
ppsv.lease_name,
ppsv.lease_number,
xxen_util.meaning(plv.status,'PN_LEASE_STATUS_TYPE',0) lease_approval_status,
xxen_util.meaning(ppsv.lease_class_code,'PN_LEASE_CLASS',0) lease_class,
xxen_util.user_name(plda.responsible_user,'N') responsible_user,
ppsv.schedule_date,
xxen_util.meaning(ppsv.payment_status_lookup_code,'PN_PAYMENT_STATUS_TYPE',0) payment_billing_status,
ppsv.user_approved_by approved_by,
ppsv.period_name period,
pnp_util_func.get_total_payment_item_amt
(ppsv.payment_status_lookup_code,
 :p_sob_currency,
 ppsv.payment_schedule_id,
 'PNTAUPMT'
) total_amount,
ppsv.user_transferred_by,
ppsv.approval_date,
ppsv.transfer_date,
--
xxen_util.meaning(ppsv.lease_status,'PN_LEASESTATUS_TYPE',0) lease_status,
ppsv.lease_id,
ppsv.lease_change_id,
:p_set_of_books_id set_of_books_id,
:p_sob_currency set_of_books_currency
from
pn_payment_schedules_v ppsv,
pn_leases_v plv,
pn_lease_details plda,
hr_all_organization_units_vl haouv
where
1=1 and
:p_upload_mode like '%' || xxen_upload.action_update || '%' and
:p_set_of_books_id=:p_set_of_books_id and
ppsv.lease_id = plv.lease_id and
ppsv.lease_id = plda.lease_id and
ppsv.org_id = haouv.organization_id and
(ppsv.status = 'F' or
 (ppsv.lease_status in ('LOF','SGN') and ppsv.status ='D')
)