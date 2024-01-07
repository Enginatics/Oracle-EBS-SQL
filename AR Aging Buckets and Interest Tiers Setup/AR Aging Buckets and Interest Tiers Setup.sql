/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: AR Aging Buckets and Interest Tiers Setup
-- Description: AR Aging Buckets and Interest Tiers Setup
-- Excel Examle Output: https://www.enginatics.com/example/ar-aging-buckets-and-interest-tiers-setup/
-- Library Link: https://www.enginatics.com/reports/ar-aging-buckets-and-interest-tiers-setup/
-- Run Report: https://demo.enginatics.com/

select
  aab.bucket_name
, aab.aging_bucket_id bucket_id
, xxen_util.meaning(nvl(aab.status,'A'),'ACTIVE_INACTIVE',3) bucket_status
, xxen_util.meaning(aab.aging_type,'AGING_BUCKETS_TYPE',222) bucket_type
, aab.description bucket_description
, aabl.bucket_sequence_num bucket_line_sequence
, xxen_util.meaning(aabl.type,'AGING_BUCKET_LINE_TYPE',222) bucket_line_type
, aabl.days_start
, aabl.days_to
, aabl.report_heading1
, aabl.report_heading2
, aab.creation_date bucket_creation_date
, xxen_util.user_name(aab.created_by) bucket_created_by
, aab.last_update_date bucket_last_updated
, xxen_util.user_name(aab.last_updated_by) bucket_last_updated_by
, aabl.creation_date bucket_line_creation_date
, xxen_util.user_name(aabl.created_by) bucket_line_created_by
, aabl.last_update_date bucket_line_last_updated
, xxen_util.user_name(aabl.last_updated_by) bucket_line_last_updated_by
from
  ar_aging_bucket_lines aabl
, ar_aging_buckets      aab
where
    1=1
and aabl.aging_bucket_id = aab.aging_bucket_id
order by
  aab.bucket_name
, aabl.bucket_sequence_num