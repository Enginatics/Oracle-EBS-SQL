/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: DBA Trace File Contents
-- Description: V$DIAGTRACEFILECONTENTS contains trace data that is present in the trace files that are part of the current Automatic Diagnostic Repository (ADR).
-- Supported starting from Oracle Database 12.2.
-- Excel Example Output: https://www.enginatics.com/example/dba-trace-file-contents/
-- Library Link: https://www.enginatics.com/reports/dba-trace-file-contents/
-- Run Report: https://demo.enginatics.com/

select 
vdtfc.payload trace_contents
from
v$diag_trace_file_contents vdtfc
where
1=1
order by
vdtfc.line_number
