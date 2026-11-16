/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: DBA Trace File Contents
-- Description: GV$DIAGTRACEFILECONTENTS contains trace data that is present in the trace files that are part of the Automatic Diagnostic Repository (ADR) of all RAC instances.
-- Supported starting from Oracle Database 12.2.
-- Excel Example Output: https://www.enginatics.com/example/dba-trace-file-contents/
-- Library Link: https://www.enginatics.com/reports/dba-trace-file-contents/
-- Run Report: https://demo.enginatics.com/

select 
gvdtfc.payload trace_contents
from
gv$diag_trace_file_contents gvdtfc
where
1=1
order by
gvdtfc.line_number
