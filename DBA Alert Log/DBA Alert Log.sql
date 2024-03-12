/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: DBA Alert Log
-- Description: V$DIAG_ALERT_EXT shows the contents of the XML-based alert log in the Automatic Diagnostic Repository (ADR) for the current container (PDB).
You could schedule it, for example, in incremental mode to send an email with errors that occured since the last scheduled report run.
-- Excel Examle Output: https://www.enginatics.com/example/dba-alert-log/
-- Library Link: https://www.enginatics.com/reports/dba-alert-log/
-- Run Report: https://demo.enginatics.com/

select
decode(vdae.message_type,1,'Unknown',2,'Incident_Error',3,'Error',4,'Warning',5,'Notification',6,'Trace',vdae.message_type) message_type_desc,
decode(vdae.message_level,1,'Critical',2,'Severe',8,'Important',16,'Normal',vdae.message_level) message_level_desc,
xxen_util.module_type(vdae.module_id) module_type,
xxen_util.module_name(vdae.module_id) module_name,
vdae.*
from
v$diag_alert_ext vdae
where
1=1
order by
vdae.record_id