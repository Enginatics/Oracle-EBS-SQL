/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: DBA Registry
-- Description: Database components installed, such as Oracle Text, JServer or XML Database, with their version and status.
-- A component with a status other than VALID can cause errors in the Oracle EBS functionality that depends on it and is usually fixed by running utlrp.sql or the component's validation procedure.
-- Excel Example Output: https://www.enginatics.com/example/dba-registry/
-- Library Link: https://www.enginatics.com/reports/dba-registry/
-- Run Report: https://demo.enginatics.com/

select
dr.comp_name,
dr.comp_id,
dr.version,
dr.status,
dr.modified,
dr.schema,
dr.other_schemas,
dr.control,
dr.namespace,
dr.procedure validation_procedure
from
dba_registry dr
where
1=1
order by
dr.comp_name
