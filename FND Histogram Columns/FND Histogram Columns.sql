/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: FND Histogram Columns
-- Description: Data from table fnd_histogram_cols, which Oracle uses to identify columns which are expected to have highly skewed data, for example a status column having a large number of closed, but only a small number of open records.
The Gather Schema and Gather Table Statistics concurrent programs use this information to create additional histrogram statistics for these columns.

To add a column to this table, use the following API:
declare
l_table_name varchar2(30):='AP_INVOICES_ALL';
l_column_name varchar2(30):='ORG_ID';
begin
for c in (
  select
  fpi.application_id
  from
  fnd_oracle_userid fou,
  fnd_product_installations fpi
  where
  xxen_util.instring(xxen_api.object_owner_type(l_table_name),'.',1)=fou.oracle_username and
  fou.oracle_id=fpi.oracle_id
  ) loop
    fnd_stats.load_histogram_cols(
    action =>'INSERT',
    appl_id =>c.application_id,
    tabname =>l_table_name,
    colname =>l_column_name,
    commit_flag =>'Y');
  end loop;
end;
-- Excel Examle Output: https://www.enginatics.com/example/fnd-histogram-columns/
-- Library Link: https://www.enginatics.com/reports/fnd-histogram-columns/
-- Run Report: https://demo.enginatics.com/

select
fav.application_name application,
fou.oracle_username owner,
fhc.table_name,
fhc.column_name,
fhc.hsize,
fhc.application_id,
xxen_util.user_name(fhc.created_by) created_by,
xxen_util.client_time(fhc.creation_date) creation_date,
xxen_util.user_name(fhc.last_updated_by) last_updated_by,
xxen_util.client_time(fhc.last_update_date) last_update_date
from
fnd_histogram_cols fhc,
fnd_application_vl fav,
fnd_product_installations fpi,
fnd_oracle_userid fou
where
1=1 and
fhc.application_id=fav.application_id and
fhc.application_id=fpi.application_id and
fpi.oracle_id=fou.oracle_id
order by
fav.application_name,
fhc.table_name,
fhc.column_name