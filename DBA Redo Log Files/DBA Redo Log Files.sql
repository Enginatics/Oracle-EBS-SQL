/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: DBA Redo Log Files
-- Description: None
-- Excel Examle Output: https://www.enginatics.com/example/dba-redo-log-files/
-- Library Link: https://www.enginatics.com/reports/dba-redo-log-files/
-- Run Report: https://demo.enginatics.com/

select
gl.inst_id,
gl.group#,
gl.members,
gl.status,
gl.first_time,
gl.next_time,
glf.member,
glf.type file_type,
glf.is_recovery_dest_file
from
gv$log gl,
gv$logfile glf
where
gl.inst_id=glf.inst_id and
gl.group#=glf.group#
order by
gl.inst_id,
gl.group#