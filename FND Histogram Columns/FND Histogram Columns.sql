/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: FND Histogram Columns
-- Description: Data from table fndhistogramcols, which Oracle uses to identify columns which are expected to have highly skewed data, for example a status column having a large number of closed, but only a small number of open records.
-- The Gather Schema and Gather Table Statistics concurrent programs use this information to create additional histrogram statistics for these columns.
-- To add a column to this table, use the following API:
-- declare
-- ltablename varchar2(30):='APINVOICESALL';
-- lcolumnname varchar2(30):='ORGID';
-- begin
-- for c in (
-- select
-- fpi.applicationid
-- from
-- fndoracleuserid fou,
-- fndproductinstallations fpi
-- where
-- xxenutil.instring(xxenapi.objectownertype(ltablename),'.',1)=fou.oracleusername and
-- fou.oracleid=fpi.oracleid
-- ) loop
-- fndstats.loadhistogramcols(
-- action =>'INSERT',
-- applid =>c.applicationid,
-- tabname =>ltablename,
-- colname =>lcolumnname,
-- commitflag =>'Y');
-- end loop;
-- end;
-- Excel Example Output: https://www.enginatics.com/example/fnd-histogram-columns/
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
