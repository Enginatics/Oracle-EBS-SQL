/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: DBA ASM Disk Groups
-- Description: Automatic Storage Management disk groups used by the database, with their redundancy, total and free space.
-- All sizes are shown in MB.
-- Usable File Mb is the space available for new files after mirroring. A negative value means that the disk group cannot restore full redundancy after a disk failure.
-- The report returns no rows when the database does not use ASM.
-- Excel Example Output: https://www.enginatics.com/example/dba-asm-disk-groups/
-- Library Link: https://www.enginatics.com/reports/dba-asm-disk-groups/
-- Run Report: https://demo.enginatics.com/

select
vad.name disk_group,
vad.state,
vad.type redundancy,
vad.total_mb,
vad.total_mb-vad.free_mb used_mb,
vad.free_mb,
(vad.total_mb-vad.free_mb)/xxen_util.zero_to_null(vad.total_mb)*100 used_percent,
vad.required_mirror_free_mb,
vad.usable_file_mb,
vad.offline_disks,
vad.allocation_unit_size/1048576 allocation_unit_mb,
vad.block_size,
vad.sector_size,
vad.compatibility,
vad.database_compatibility
from
v$asm_diskgroup vad
where
1=1
order by
vad.name
