/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: DBA Database Parameter Validation
-- Description: Replicates the database initialization-parameter validation performed by Oracle's EBS Database Performance and Statistics Analyzer (My Oracle Support Doc 2126712.1 / KB627702), so DBAs no longer need to download, install and run that analyzer to check EBS parameter compliance.
-- Reference: https://support.oracle.com/rs?type=doc&id=2126712.1
-- It compares the current instance settings in v$systemparameter2 against Oracle's required values for the running RDBMS version (11.1 / 11.2 / 12.1 / 19c) and EBS release, per My Oracle Support Doc 396009.1 / KA1002 ("Database Initialization Parameters for Oracle E-Business Suite").
-- https://support.oracle.com/support/?kmContentId=11158187
-- Three sections:
-- 1. Mandatory Database Parameters - current vs required value, with a Check of OK / NOT FOUND:OK / ERROR.
-- 2. Database Parameters to be Removed - parameters (and events) that are explicitly set but should be removed for the running RDBMS version.
-- 3. Database Additional Parameters - other non-default parameters set on the instance, flagging hidden (underscore) parameters that should not be set.
-- By default the "Only show errors" parameter is Yes, so only actionable rows are shown (Check = ERROR, parameters to be removed, and hidden parameters that should not be set). Clear the parameter to list every checked parameter. Memory sizes are shown in M / G (e.g. 600M, 2G).
-- Prerequisite: APPS requires SELECT on v$systemparameter2 (v$systemparameter2). On most EBS instances this grant already exists; if not, as SYSDBA run:
-- create or replace public synonym V$SYSTEMPARAMETER2 for SYS.V$SYSTEMPARAMETER2;
-- grant select on sys.V$SYSTEMPARAMETER2 to apps;
-- Excel Example Output: https://www.enginatics.com/example/dba-database-parameter-validation/
-- Library Link: https://www.enginatics.com/reports/dba-database-parameter-validation/
-- Run Report: https://demo.enginatics.com/

with
function fmt_size(p_value varchar2) return varchar2 is
l_n number;
begin
  if regexp_like(p_value,'^\d+$') then
    l_n:=to_number(p_value);
    if l_n>=1073741824 then
      return rtrim(rtrim(to_char(round(l_n/1073741824,2),'fm999999990.99'),'0'),'.')||'G';
    elsif l_n>=1048576 then
      return rtrim(rtrim(to_char(round(l_n/1048576,2),'fm999999990.99'),'0'),'.')||'M';
    end if;
  end if;
  return p_value;
end;
ref0 as (
select 'db_block_size' param,'MANDATORY' category,'ALL' stmt,'ALL' apps,'8192' db_default,'8192' req from dual union all
select '_system_trig_enabled' param,'MANDATORY' category,'ALL' stmt,'ALL' apps,'TRUE' db_default,'TRUE' req from dual union all
select 'nls_date_format' param,'MANDATORY' category,'ALL' stmt,'ALL' apps,'DERIVED' db_default,'DD-MON-RR' req from dual union all
select 'nls_sort' param,'MANDATORY' category,'ALL' stmt,'ALL' apps,'DERIVED' db_default,'BINARY' req from dual union all
select 'nls_comp' param,'MANDATORY' category,'ALL' stmt,'ALL' apps,'DERIVED' db_default,'BINARY' req from dual union all
select 'nls_length_semantics' param,'MANDATORY' category,'ALL' stmt,'ALL' apps,'DERIVED' db_default,'BYTE' req from dual union all
select 'cursor_sharing' param,'MANDATORY' category,'ALL' stmt,'ALL' apps,'EXACT' db_default,'EXACT' req from dual union all
select '_like_with_bind_as_equality' param,'MANDATORY' category,'ALL' stmt,'ALL' apps,'HIDDEN' db_default,'TRUE' req from dual union all
select '_sort_elimination_cost_ratio' param,'MANDATORY' category,'ALL' stmt,'ALL' apps,'HIDDEN' db_default,'5' req from dual union all
select '_fast_full_scan_enabled' param,'MANDATORY' category,'ALL' stmt,'ALL' apps,'HIDDEN' db_default,'FALSE' req from dual union all
select '_b_tree_bitmap_plans' param,'MANDATORY' category,'ALL' stmt,'ALL' apps,'HIDDEN' db_default,'FALSE' req from dual union all
select 'optimizer_secure_view_merging' param,'MANDATORY' category,'ALL' stmt,'ALL' apps,'TRUE' db_default,'FALSE' req from dual union all
select 'workarea_size_policy' param,'MANDATORY' category,'ALL' stmt,'ALL' apps,'AUTO' db_default,'AUTO' req from dual union all
select 'undo_management' param,'MANDATORY' category,'ALL' stmt,'ALL' apps,'AUTO' db_default,'AUTO' req from dual union all
select '_optimizer_autostats_job' param,'MANDATORY' category,'ALL' stmt,'ALL' apps,'TRUE' db_default,'FALSE' req from dual union all
select 'compatible' param,'MANDATORY' category,'ALL' stmt,'ALL' apps,(select substr(version,1,6) from v$instance) db_default,(select substr(version,1,6) from v$instance) req from dual union all
select 'parallel_force_local' param,'MANDATORY' category,'ALL' stmt,'ALL' apps,'FALSE' db_default,'TRUE' req from dual union all
select 'parallel_degree_policy' param,'MANDATORY' category,'ALL' stmt,'ALL' apps,'MANUAL' db_default,'MANUAL' req from dual union all
select '_disable_actualization_for_grant' param,'MANDATORY' category,'ALL' stmt,'ALL' apps,'FALSE' db_default,'TRUE' req from dual union all
select 'db_name' param,'OTHERS' category,'ALL' stmt,'ALL' apps,'NODEFAULT' db_default,'PROD' req from dual union all
select 'control_files' param,'OTHERS' category,'ALL' stmt,'ALL' apps,'OS_DEPENDENT' db_default,'three copies of control file' req from dual union all
select 'filesystemio_options' param,'OTHERS' category,'ALL' stmt,'ALL' apps,'OS_DEPENDENT' db_default,'SETALL' req from dual union all
select 'nls_territory' param,'OTHERS' category,'ALL' stmt,'ALL' apps,'DERIVED' db_default,'AMERICA' req from dual union all
select 'nls_numeric_characters' param,'OTHERS' category,'ALL' stmt,'ALL' apps,'DERIVED' db_default,'.,' req from dual union all
select 'diagnostic_dest' param,'OTHERS' category,'ALL' stmt,'ALL' apps,'DERIVED' db_default,'?/prod12' req from dual union all
select 'max_dump_file_size' param,'OTHERS' category,'ALL' stmt,'ALL' apps,'UNLIMITED' db_default,'20480' req from dual union all
select '_trace_files_public' param,'OTHERS' category,'ALL' stmt,'ALL' apps,'FALSE' db_default,'FALSE' req from dual union all
select 'processes' param,'SIZING' category,'ALL' stmt,'ALL' apps,'DERIVED' db_default,'200' req from dual union all
select 'sessions' param,'SIZING' category,'ALL' stmt,'ALL' apps,'DERIVED' db_default,'400' req from dual union all
select 'db_files' param,'SIZING' category,'ALL' stmt,'ALL' apps,'200' db_default,'512' req from dual union all
select 'dml_locks' param,'SIZING' category,'ALL' stmt,'ALL' apps,'DERIVED' db_default,'10000' req from dual union all
select 'open_cursors' param,'SIZING' category,'ALL' stmt,'ALL' apps,'50' db_default,'600' req from dual union all
select 'session_cached_cursors' param,'SIZING' category,'ALL' stmt,'ALL' apps,'50' db_default,'500' req from dual union all
select 'db_block_checking' param,'OTHERS' category,'ALL' stmt,'ALL' apps,'FALSE' db_default,'FALSE' req from dual union all
select 'db_block_checksum' param,'OTHERS' category,'ALL' stmt,'ALL' apps,'TYPICAL' db_default,'TRUE' req from dual union all
select 'log_checkpoint_timeout' param,'SIZING' category,'ALL' stmt,'ALL' apps,'1800' db_default,'1200' req from dual union all
select 'log_checkpoint_interval' param,'SIZING' category,'ALL' stmt,'ALL' apps,'0' db_default,'100000' req from dual union all
select 'log_buffer' param,'SIZING' category,'ALL' stmt,'ALL' apps,'5242880' db_default,'10485760' req from dual union all
select 'log_checkpoints_to_alert' param,'SIZING' category,'ALL' stmt,'ALL' apps,'FALSE' db_default,'TRUE' req from dual union all
select 'shared_pool_size' param,'SIZING' category,'ALL' stmt,'ALL' apps,'DERIVED' db_default,'629145600' req from dual union all
select 'shared_pool_reserved_size' param,'SIZING' category,'ALL' stmt,'ALL' apps,'DERIVED' db_default,'60M' req from dual union all
select 'utl_file_dir' param,'OTHERS' category,'ALL' stmt,'ALL' apps,'DERIVED' db_default,'/ebiz/prodr12/utl_file_dir' req from dual union all
select 'aq_tm_processes' param,'SIZING' category,'ALL' stmt,'ALL' apps,'10485760' db_default,'1' req from dual union all
select 'job_queue_processes' param,'SIZING' category,'ALL' stmt,'ALL' apps,'1000' db_default,'2' req from dual union all
select 'log_archive_dest_1' param,'OTHERS' category,'ALL' stmt,'ALL' apps,'DERIVED' db_default,'LOCATION=/DISC1/ARC' req from dual union all
select 'log_archive_dest_2' param,'OTHERS' category,'ALL' stmt,'ALL' apps,'DERIVED' db_default,'SERVICE=STANDBY1' req from dual union all
select 'pga_aggregate_target' param,'SIZING' category,'ALL' stmt,'ALL' apps,'DERIVED' db_default,'1G' req from dual union all
select 'sga_target' param,'SIZING' category,'ALL' stmt,'ALL' apps,'0' db_default,'2G' req from dual union all
select 'parallel_max_servers' param,'SIZING' category,'ALL' stmt,'ALL' apps,'DERIVED' db_default,to_char(2*(select to_number(value) from v$system_parameter where name='cpu_count')) req from dual union all
select 'parallel_min_servers' param,'SIZING' category,'ALL' stmt,'ALL' apps,'DERIVED' db_default,'0' req from dual union all
select 'sec_case_sensitive_logon' param,'SIZING' category,'ALL' stmt,'ALL' apps,'Note 1581584.1' db_default,'FALSE' req from dual union all
select '_sqlexec_progression_cost' param,'MANDATORY' category,'11.1.0' stmt,'ALL' apps,'HIDDEN' db_default,'2147483647' req from dual union all
select 'O7_DICTIONARY_ACCESSIBILITY' param,'MANDATORY' category,'11.1.0' stmt,'ALL' apps,'TRUE' db_default,'FALSE' req from dual union all
select '_always_anti_join' param,'REMOVE' category,'11.1.0' stmt,'ALL' apps,null db_default,null req from dual union all
select '_always_semi_join' param,'REMOVE' category,'11.1.0' stmt,'ALL' apps,null db_default,null req from dual union all
select '_complex_view_merging' param,'REMOVE' category,'11.1.0' stmt,'ALL' apps,null db_default,null req from dual union all
select '_index_join_enabled' param,'REMOVE' category,'11.1.0' stmt,'ALL' apps,null db_default,null req from dual union all
select '_kks_use_mutex_pin' param,'REMOVE' category,'11.1.0' stmt,'ALL' apps,null db_default,null req from dual union all
select '_new_initial_join_orders' param,'REMOVE' category,'11.1.0' stmt,'ALL' apps,null db_default,null req from dual union all
select '_optimizer_cost_based_transformation' param,'REMOVE' category,'11.1.0' stmt,'ALL' apps,null db_default,null req from dual union all
select '_optimizer_cost_model' param,'REMOVE' category,'11.1.0' stmt,'ALL' apps,null db_default,null req from dual union all
select '_optimizer_mode_force' param,'REMOVE' category,'11.1.0' stmt,'ALL' apps,null db_default,null req from dual union all
select '_optimizer_undo_changes' param,'REMOVE' category,'11.1.0' stmt,'ALL' apps,null db_default,null req from dual union all
select '_or_expand_nvl_predicate' param,'REMOVE' category,'11.1.0' stmt,'ALL' apps,null db_default,null req from dual union all
select '_ordered_nested_loop' param,'REMOVE' category,'11.1.0' stmt,'ALL' apps,null db_default,null req from dual union all
select '_push_join_predicate' param,'REMOVE' category,'11.1.0' stmt,'ALL' apps,null db_default,null req from dual union all
select '_shared_pool_reserved_min_alloc' param,'REMOVE' category,'11.1.0' stmt,'ALL' apps,null db_default,null req from dual union all
select '_sortmerge_inequality_join_off' param,'REMOVE' category,'11.1.0' stmt,'ALL' apps,null db_default,null req from dual union all
select '_table_scan_cost_plus_one' param,'REMOVE' category,'11.1.0' stmt,'ALL' apps,null db_default,null req from dual union all
select '_unnest_subquery' param,'REMOVE' category,'11.1.0' stmt,'ALL' apps,null db_default,null req from dual union all
select '_use_column_stats_for_function' param,'REMOVE' category,'11.1.0' stmt,'ALL' apps,null db_default,null req from dual union all
select 'always_anti_join' param,'REMOVE' category,'11.1.0' stmt,'ALL' apps,null db_default,null req from dual union all
select 'always_semi_join' param,'REMOVE' category,'11.1.0' stmt,'ALL' apps,null db_default,null req from dual union all
select 'background_dump_dest' param,'REMOVE' category,'11.1.0' stmt,'ALL' apps,null db_default,null req from dual union all
select 'core_dump_dest' param,'REMOVE' category,'11.1.0' stmt,'ALL' apps,null db_default,null req from dual union all
select 'db_block_buffers' param,'REMOVE' category,'11.1.0' stmt,'ALL' apps,null db_default,null req from dual union all
select 'db_cache_size' param,'REMOVE' category,'11.1.0' stmt,'ALL' apps,null db_default,null req from dual union all
select 'db_file_multiblock_read_count' param,'REMOVE' category,'11.1.0' stmt,'ALL' apps,null db_default,null req from dual union all
select 'enqueue_resources' param,'REMOVE' category,'11.1.0' stmt,'ALL' apps,null db_default,null req from dual union all
select 'event' param,'REMOVE' category,'11.1.0' stmt,'ALL' apps,null db_default,'10932 trace name context level 32768' req from dual union all
select 'event' param,'REMOVE' category,'11.1.0' stmt,'ALL' apps,null db_default,'10933 trace name context level 512' req from dual union all
select 'event' param,'REMOVE' category,'11.1.0' stmt,'ALL' apps,null db_default,'10943 trace name context forever, level 2' req from dual union all
select 'event' param,'REMOVE' category,'11.1.0' stmt,'ALL' apps,null db_default,'10943 trace name context level 16384' req from dual union all
select 'event' param,'REMOVE' category,'11.1.0' stmt,'ALL' apps,null db_default,'38004 trace name context forever, level 1' req from dual union all
select 'hash_area_size' param,'REMOVE' category,'11.1.0' stmt,'ALL' apps,null db_default,null req from dual union all
select 'java_pool_size' param,'REMOVE' category,'11.1.0' stmt,'ALL' apps,null db_default,null req from dual union all
select 'large_pool_size' param,'REMOVE' category,'11.1.0' stmt,'ALL' apps,null db_default,null req from dual union all
select 'max_enabled_roles' param,'REMOVE' category,'11.1.0' stmt,'ALL' apps,null db_default,null req from dual union all
select 'nls_language' param,'REMOVE' category,'11.1.0' stmt,'ALL' apps,null db_default,null req from dual union all
select 'optimizer_dynamic_sampling' param,'REMOVE' category,'11.1.0' stmt,'ALL' apps,null db_default,null req from dual union all
select 'optimizer_features_enable' param,'REMOVE' category,'11.1.0' stmt,'ALL' apps,null db_default,null req from dual union all
select 'optimizer_index_caching' param,'REMOVE' category,'11.1.0' stmt,'ALL' apps,null db_default,null req from dual union all
select 'optimizer_index_cost_adj' param,'REMOVE' category,'11.1.0' stmt,'ALL' apps,null db_default,null req from dual union all
select 'optimizer_max_permutations' param,'REMOVE' category,'11.1.0' stmt,'ALL' apps,null db_default,null req from dual union all
select 'optimizer_percent_parallel' param,'REMOVE' category,'11.1.0' stmt,'ALL' apps,null db_default,null req from dual union all
select 'plsql_compiler_flags' param,'REMOVE' category,'11.1.0' stmt,'ALL' apps,null db_default,null req from dual union all
select 'plsql_native_library_dir' param,'REMOVE' category,'11.1.0' stmt,'ALL' apps,null db_default,null req from dual union all
select 'plsql_native_library_subdir_count' param,'REMOVE' category,'11.1.0' stmt,'ALL' apps,null db_default,null req from dual union all
select 'plsql_optimize_level' param,'REMOVE' category,'11.1.0' stmt,'ALL' apps,null db_default,null req from dual union all
select 'query_rewrite_enabled' param,'REMOVE' category,'11.1.0' stmt,'ALL' apps,null db_default,null req from dual union all
select 'rollback_segments' param,'REMOVE' category,'11.1.0' stmt,'ALL' apps,null db_default,null req from dual union all
select 'row_locking' param,'REMOVE' category,'11.1.0' stmt,'ALL' apps,null db_default,null req from dual union all
select 'sort_area_size' param,'REMOVE' category,'11.1.0' stmt,'ALL' apps,null db_default,null req from dual union all
select 'sql_trace' param,'REMOVE' category,'11.1.0' stmt,'ALL' apps,null db_default,null req from dual union all
select 'timed_statistics' param,'REMOVE' category,'11.1.0' stmt,'ALL' apps,null db_default,null req from dual union all
select 'undo_retention' param,'REMOVE' category,'11.1.0' stmt,'ALL' apps,null db_default,null req from dual union all
select 'undo_suppress_errors' param,'REMOVE' category,'11.1.0' stmt,'ALL' apps,null db_default,null req from dual union all
select 'user_dump_dest' param,'REMOVE' category,'11.1.0' stmt,'ALL' apps,null db_default,null req from dual union all
select 'olap_page_pool_size' param,'SIZING' category,'11.2.0' stmt,'ALL' apps,'0' db_default,'4194304' req from dual union all
select 'O7_DICTIONARY_ACCESSIBILITY' param,'MANDATORY' category,'11.2.0' stmt,'ALL' apps,'TRUE' db_default,'FALSE' req from dual union all
select '_always_anti_join' param,'REMOVE' category,'11.2.0' stmt,'ALL' apps,null db_default,null req from dual union all
select '_always_semi_join' param,'REMOVE' category,'11.2.0' stmt,'ALL' apps,null db_default,null req from dual union all
select '_complex_view_merging' param,'REMOVE' category,'11.2.0' stmt,'ALL' apps,null db_default,null req from dual union all
select '_index_join_enabled' param,'REMOVE' category,'11.2.0' stmt,'ALL' apps,null db_default,null req from dual union all
select '_kks_use_mutex_pin' param,'REMOVE' category,'11.2.0' stmt,'ALL' apps,null db_default,null req from dual union all
select '_new_initial_join_orders' param,'REMOVE' category,'11.2.0' stmt,'ALL' apps,null db_default,null req from dual union all
select '_optimizer_cost_based_transformation' param,'REMOVE' category,'11.2.0' stmt,'ALL' apps,null db_default,null req from dual union all
select '_optimizer_cost_model' param,'REMOVE' category,'11.2.0' stmt,'ALL' apps,null db_default,null req from dual union all
select '_optimizer_mode_force' param,'REMOVE' category,'11.2.0' stmt,'ALL' apps,null db_default,null req from dual union all
select '_optimizer_undo_changes' param,'REMOVE' category,'11.2.0' stmt,'ALL' apps,null db_default,null req from dual union all
select '_or_expand_nvl_predicate' param,'REMOVE' category,'11.2.0' stmt,'ALL' apps,null db_default,null req from dual union all
select '_ordered_nested_loop' param,'REMOVE' category,'11.2.0' stmt,'ALL' apps,null db_default,null req from dual union all
select '_push_join_predicate' param,'REMOVE' category,'11.2.0' stmt,'ALL' apps,null db_default,null req from dual union all
select '_push_join_union_view' param,'REMOVE' category,'11.2.0' stmt,'ALL' apps,null db_default,null req from dual union all
select '_shared_pool_reserved_min_alloc' param,'REMOVE' category,'11.2.0' stmt,'ALL' apps,null db_default,null req from dual union all
select '_sortmerge_inequality_join_off' param,'REMOVE' category,'11.2.0' stmt,'ALL' apps,null db_default,null req from dual union all
select '_sqlexec_progression_cost' param,'REMOVE' category,'11.2.0' stmt,'ALL' apps,null db_default,null req from dual union all
select '_table_scan_cost_plus_one' param,'REMOVE' category,'11.2.0' stmt,'ALL' apps,null db_default,null req from dual union all
select '_unnest_subquery' param,'REMOVE' category,'11.2.0' stmt,'ALL' apps,null db_default,null req from dual union all
select '_use_column_stats_for_function' param,'REMOVE' category,'11.2.0' stmt,'ALL' apps,null db_default,null req from dual union all
select 'always_anti_join' param,'REMOVE' category,'11.2.0' stmt,'ALL' apps,null db_default,null req from dual union all
select 'always_semi_join' param,'REMOVE' category,'11.2.0' stmt,'ALL' apps,null db_default,null req from dual union all
select 'background_dump_dest' param,'REMOVE' category,'11.2.0' stmt,'ALL' apps,null db_default,null req from dual union all
select 'core_dump_dest' param,'REMOVE' category,'11.2.0' stmt,'ALL' apps,null db_default,null req from dual union all
select 'db_block_buffers' param,'REMOVE' category,'11.2.0' stmt,'ALL' apps,null db_default,null req from dual union all
select 'db_cache_size' param,'REMOVE' category,'11.2.0' stmt,'ALL' apps,null db_default,null req from dual union all
select 'db_file_multiblock_read_count' param,'REMOVE' category,'11.2.0' stmt,'ALL' apps,null db_default,null req from dual union all
select 'drs_start' param,'REMOVE' category,'11.2.0' stmt,'ALL' apps,null db_default,null req from dual union all
select 'enqueue_resources' param,'REMOVE' category,'11.2.0' stmt,'ALL' apps,null db_default,null req from dual union all
select 'event' param,'REMOVE' category,'11.2.0' stmt,'ALL' apps,null db_default,'10932 trace name context level 32768' req from dual union all
select 'event' param,'REMOVE' category,'11.2.0' stmt,'ALL' apps,null db_default,'10933 trace name context level 512' req from dual union all
select 'event' param,'REMOVE' category,'11.2.0' stmt,'ALL' apps,null db_default,'10943 trace name context forever, level 2' req from dual union all
select 'event' param,'REMOVE' category,'11.2.0' stmt,'ALL' apps,null db_default,'10943 trace name context level 16384' req from dual union all
select 'event' param,'REMOVE' category,'11.2.0' stmt,'ALL' apps,null db_default,'38004 trace name context forever, level 1' req from dual union all
select 'hash_area_size' param,'REMOVE' category,'11.2.0' stmt,'ALL' apps,null db_default,null req from dual union all
select 'java_pool_size' param,'REMOVE' category,'11.2.0' stmt,'ALL' apps,null db_default,null req from dual union all
select 'job_queue_interval' param,'REMOVE' category,'11.2.0' stmt,'ALL' apps,null db_default,null req from dual union all
select 'large_pool_size' param,'REMOVE' category,'11.2.0' stmt,'ALL' apps,null db_default,null req from dual union all
select 'max_enabled_roles' param,'REMOVE' category,'11.2.0' stmt,'ALL' apps,null db_default,null req from dual union all
select 'nls_language' param,'REMOVE' category,'11.2.0' stmt,'ALL' apps,null db_default,null req from dual union all
select 'optimizer_dynamic_sampling' param,'REMOVE' category,'11.2.0' stmt,'ALL' apps,null db_default,null req from dual union all
select 'optimizer_features_enable' param,'REMOVE' category,'11.2.0' stmt,'ALL' apps,null db_default,null req from dual union all
select 'optimizer_index_caching' param,'REMOVE' category,'11.2.0' stmt,'ALL' apps,null db_default,null req from dual union all
select 'optimizer_index_cost_adj' param,'REMOVE' category,'11.2.0' stmt,'ALL' apps,null db_default,null req from dual union all
select 'optimizer_max_permutations' param,'REMOVE' category,'11.2.0' stmt,'ALL' apps,null db_default,null req from dual union all
select 'optimizer_mode' param,'REMOVE' category,'11.2.0' stmt,'ALL' apps,null db_default,null req from dual union all
select 'optimizer_percent_parallel' param,'REMOVE' category,'11.2.0' stmt,'ALL' apps,null db_default,null req from dual union all
select ' parallel_instance_group' param,'REMOVE' category,'11.2.0' stmt,'ALL' apps,null db_default,null req from dual union all
select 'instance_groups' param,'REMOVE' category,'11.2.0' stmt,'ALL' apps,null db_default,null req from dual union all
select 'plsql_compiler_flags' param,'REMOVE' category,'11.2.0' stmt,'ALL' apps,null db_default,null req from dual union all
select 'plsql_native_library_dir' param,'REMOVE' category,'11.2.0' stmt,'ALL' apps,null db_default,null req from dual union all
select 'plsql_native_library_subdir_count' param,'REMOVE' category,'11.2.0' stmt,'ALL' apps,null db_default,null req from dual union all
select 'plsql_optimize_level' param,'REMOVE' category,'11.2.0' stmt,'ALL' apps,null db_default,null req from dual union all
select 'query_rewrite_enabled' param,'REMOVE' category,'11.2.0' stmt,'ALL' apps,null db_default,null req from dual union all
select 'rollback_segments' param,'REMOVE' category,'11.2.0' stmt,'ALL' apps,null db_default,null req from dual union all
select 'row_locking' param,'REMOVE' category,'11.2.0' stmt,'ALL' apps,null db_default,null req from dual union all
select 'sort_area_size' param,'REMOVE' category,'11.2.0' stmt,'ALL' apps,null db_default,null req from dual union all
select 'sql_trace' param,'REMOVE' category,'11.2.0' stmt,'ALL' apps,null db_default,null req from dual union all
select 'sql_version' param,'REMOVE' category,'11.2.0' stmt,'ALL' apps,null db_default,null req from dual union all
select 'timed_statistics' param,'REMOVE' category,'11.2.0' stmt,'ALL' apps,null db_default,null req from dual union all
select 'undo_retention' param,'REMOVE' category,'11.2.0' stmt,'ALL' apps,null db_default,null req from dual union all
select 'undo_suppress_errors' param,'REMOVE' category,'11.2.0' stmt,'ALL' apps,null db_default,null req from dual union all
select 'user_dump_dest' param,'REMOVE' category,'11.2.0' stmt,'ALL' apps,null db_default,null req from dual union all
select 'O7_DICTIONARY_ACCESSIBILITY' param,'MANDATORY' category,'12.1.0' stmt,'ALL' apps,'TRUE' db_default,'FALSE' req from dual union all
select 'optimizer_adaptive_features' param,'MANDATORY' category,'12.1.0' stmt,'ALL' apps,'TRUE' db_default,'FALSE' req from dual union all
select 'olap_page_pool_size' param,'SIZING' category,'12.1.0' stmt,'ALL' apps,'0' db_default,'4194304' req from dual union all
select 'temp_undo_enabled' param,'SIZING' category,'12.1.0' stmt,'ALL' apps,'FALSE' db_default,'FALSE' req from dual union all
select 'pga_aggregate_limit' param,'MANDATORY' category,'12.1.0' stmt,'ALL' apps,'DERIVED' db_default,'0' req from dual union all
select '_always_anti_join' param,'REMOVE' category,'12.1.0' stmt,'ALL' apps,null db_default,null req from dual union all
select '_always_semi_join' param,'REMOVE' category,'12.1.0' stmt,'ALL' apps,null db_default,null req from dual union all
select '_complex_view_merging' param,'REMOVE' category,'12.1.0' stmt,'ALL' apps,null db_default,null req from dual union all
select '_index_join_enabled' param,'REMOVE' category,'12.1.0' stmt,'ALL' apps,null db_default,null req from dual union all
select '_kks_use_mutex_pin' param,'REMOVE' category,'12.1.0' stmt,'ALL' apps,null db_default,null req from dual union all
select '_new_initial_join_orders' param,'REMOVE' category,'12.1.0' stmt,'ALL' apps,null db_default,null req from dual union all
select '_optimizer_cost_based_transformation' param,'REMOVE' category,'12.1.0' stmt,'ALL' apps,null db_default,null req from dual union all
select '_optimizer_cost_model' param,'REMOVE' category,'12.1.0' stmt,'ALL' apps,null db_default,null req from dual union all
select '_optimizer_mode_force' param,'REMOVE' category,'12.1.0' stmt,'ALL' apps,null db_default,null req from dual union all
select '_optimizer_undo_changes' param,'REMOVE' category,'12.1.0' stmt,'ALL' apps,null db_default,null req from dual union all
select '_or_expand_nvl_predicate' param,'REMOVE' category,'12.1.0' stmt,'ALL' apps,null db_default,null req from dual union all
select '_ordered_nested_loop' param,'REMOVE' category,'12.1.0' stmt,'ALL' apps,null db_default,null req from dual union all
select '_push_join_predicate' param,'REMOVE' category,'12.1.0' stmt,'ALL' apps,null db_default,null req from dual union all
select '_push_join_union_view' param,'REMOVE' category,'12.1.0' stmt,'ALL' apps,null db_default,null req from dual union all
select '_shared_pool_reserved_min_alloc' param,'REMOVE' category,'12.1.0' stmt,'ALL' apps,null db_default,null req from dual union all
select '_sortmerge_inequality_join_off' param,'REMOVE' category,'12.1.0' stmt,'ALL' apps,null db_default,null req from dual union all
select '_sqlexec_progression_cost' param,'REMOVE' category,'12.1.0' stmt,'ALL' apps,null db_default,null req from dual union all
select '_table_scan_cost_plus_one' param,'REMOVE' category,'12.1.0' stmt,'ALL' apps,null db_default,null req from dual union all
select '_unnest_subquery' param,'REMOVE' category,'12.1.0' stmt,'ALL' apps,null db_default,null req from dual union all
select '_use_column_stats_for_function' param,'REMOVE' category,'12.1.0' stmt,'ALL' apps,null db_default,null req from dual union all
select 'always_anti_join' param,'REMOVE' category,'12.1.0' stmt,'ALL' apps,null db_default,null req from dual union all
select 'always_semi_join' param,'REMOVE' category,'12.1.0' stmt,'ALL' apps,null db_default,null req from dual union all
select 'background_dump_dest' param,'REMOVE' category,'12.1.0' stmt,'ALL' apps,null db_default,null req from dual union all
select 'core_dump_dest' param,'REMOVE' category,'12.1.0' stmt,'ALL' apps,null db_default,null req from dual union all
select 'db_block_buffers' param,'REMOVE' category,'12.1.0' stmt,'ALL' apps,null db_default,null req from dual union all
select 'db_cache_size' param,'REMOVE' category,'12.1.0' stmt,'ALL' apps,null db_default,null req from dual union all
select 'db_file_multiblock_read_count' param,'REMOVE' category,'12.1.0' stmt,'ALL' apps,null db_default,null req from dual union all
select 'drs_start' param,'REMOVE' category,'12.1.0' stmt,'ALL' apps,null db_default,null req from dual union all
select 'enqueue_resources' param,'REMOVE' category,'12.1.0' stmt,'ALL' apps,null db_default,null req from dual union all
select 'event' param,'REMOVE' category,'12.1.0' stmt,'ALL' apps,null db_default,'10932 trace name context level 32768' req from dual union all
select 'event' param,'REMOVE' category,'12.1.0' stmt,'ALL' apps,null db_default,'10933 trace name context level 512' req from dual union all
select 'event' param,'REMOVE' category,'12.1.0' stmt,'ALL' apps,null db_default,'10943 trace name context forever, level 2' req from dual union all
select 'event' param,'REMOVE' category,'12.1.0' stmt,'ALL' apps,null db_default,'10943 trace name context level 16384' req from dual union all
select 'event' param,'REMOVE' category,'12.1.0' stmt,'ALL' apps,null db_default,'38004 trace name context forever, level 1' req from dual union all
select 'hash_area_size' param,'REMOVE' category,'12.1.0' stmt,'ALL' apps,null db_default,null req from dual union all
select 'java_pool_size' param,'REMOVE' category,'12.1.0' stmt,'ALL' apps,null db_default,null req from dual union all
select 'job_queue_interval' param,'REMOVE' category,'12.1.0' stmt,'ALL' apps,null db_default,null req from dual union all
select 'large_pool_size' param,'REMOVE' category,'12.1.0' stmt,'ALL' apps,null db_default,null req from dual union all
select 'max_enabled_roles' param,'REMOVE' category,'12.1.0' stmt,'ALL' apps,null db_default,null req from dual union all
select 'nls_language' param,'REMOVE' category,'12.1.0' stmt,'ALL' apps,null db_default,null req from dual union all
select 'optimizer_dynamic_sampling' param,'REMOVE' category,'12.1.0' stmt,'ALL' apps,null db_default,null req from dual union all
select 'optimizer_features_enable' param,'REMOVE' category,'12.1.0' stmt,'ALL' apps,null db_default,null req from dual union all
select 'optimizer_index_caching' param,'REMOVE' category,'12.1.0' stmt,'ALL' apps,null db_default,null req from dual union all
select 'optimizer_index_cost_adj' param,'REMOVE' category,'12.1.0' stmt,'ALL' apps,null db_default,null req from dual union all
select 'optimizer_max_permutations' param,'REMOVE' category,'12.1.0' stmt,'ALL' apps,null db_default,null req from dual union all
select 'optimizer_mode' param,'REMOVE' category,'12.1.0' stmt,'ALL' apps,null db_default,null req from dual union all
select 'optimizer_percent_parallel' param,'REMOVE' category,'12.1.0' stmt,'ALL' apps,null db_default,null req from dual union all
select ' parallel_instance_group' param,'REMOVE' category,'12.1.0' stmt,'ALL' apps,null db_default,null req from dual union all
select 'instance_groups' param,'REMOVE' category,'12.1.0' stmt,'ALL' apps,null db_default,null req from dual union all
select 'plsql_compiler_flags' param,'REMOVE' category,'12.1.0' stmt,'ALL' apps,null db_default,null req from dual union all
select 'plsql_native_library_dir' param,'REMOVE' category,'12.1.0' stmt,'ALL' apps,null db_default,null req from dual union all
select 'plsql_native_library_subdir_count' param,'REMOVE' category,'12.1.0' stmt,'ALL' apps,null db_default,null req from dual union all
select 'plsql_optimize_level' param,'REMOVE' category,'12.1.0' stmt,'ALL' apps,null db_default,null req from dual union all
select 'query_rewrite_enabled' param,'REMOVE' category,'12.1.0' stmt,'ALL' apps,null db_default,null req from dual union all
select 'rollback_segments' param,'REMOVE' category,'12.1.0' stmt,'ALL' apps,null db_default,null req from dual union all
select 'row_locking' param,'REMOVE' category,'12.1.0' stmt,'ALL' apps,null db_default,null req from dual union all
select 'sort_area_size' param,'REMOVE' category,'12.1.0' stmt,'ALL' apps,null db_default,null req from dual union all
select 'sql_trace' param,'REMOVE' category,'12.1.0' stmt,'ALL' apps,null db_default,null req from dual union all
select 'sql_version' param,'REMOVE' category,'12.1.0' stmt,'ALL' apps,null db_default,null req from dual union all
select 'timed_statistics' param,'REMOVE' category,'12.1.0' stmt,'ALL' apps,null db_default,null req from dual union all
select 'undo_retention' param,'REMOVE' category,'12.1.0' stmt,'ALL' apps,null db_default,null req from dual union all
select 'undo_suppress_errors' param,'REMOVE' category,'12.1.0' stmt,'ALL' apps,null db_default,null req from dual union all
select 'user_dump_dest' param,'REMOVE' category,'12.1.0' stmt,'ALL' apps,null db_default,null req from dual union all
select 'recyclebin' param,'MANDATORY' category,'11.2.0' stmt,'12.2' apps,'ON' db_default,'OFF' req from dual union all
select 'recyclebin' param,'MANDATORY' category,'12.1.0' stmt,'12.2' apps,'ON' db_default,'OFF' req from dual union all
select 'result_cache_max_size' param,'MANDATORY' category,'11.2.0' stmt,'12.2' apps,null db_default,'629145600' req from dual union all
select 'result_cache_max_size' param,'MANDATORY' category,'12.1.0' stmt,'12.2' apps,null db_default,'629145600' req from dual union all
select 'result_cache_max_size' param,'MANDATORY' category,'19.0.0' stmt,'12.2' apps,null db_default,'629145600' req from dual union all
select 'local_listener' param,'MANDATORY' category,'11.2.0' stmt,'12.2' apps,'(ADDRESS = (PROTOCOL=TCP)(HOST=hostname)(PORT=1521))' db_default,(select instance_name from v$instance) || '_LOCAL' req from dual union all
select 'local_listener' param,'MANDATORY' category,'12.1.0' stmt,'12.2' apps,'(ADDRESS = (PROTOCOL=TCP)(HOST=hostname)(PORT=1521))' db_default,(select instance_name from v$instance) || '_LOCAL' req from dual union all
select 'service_names' param,'OTHERS' category,'11.2.0' stmt,'12.2' apps,(select value from v$system_parameter where name='db_unique_name') db_default,(select instance_name from v$instance) || ',' || (select instance_name from v$instance)||'_EBS_PATCH' req from dual union all
select 'service_names' param,'OTHERS' category,'12.1.0' stmt,'12.2' apps,(select value from v$system_parameter where name='db_unique_name') db_default,(select instance_name from v$instance) || ',' || (select instance_name from v$instance)||'_EBS_PATCH' req from dual union all
select 'recyclebin' param,'MANDATORY' category,'19.0.0' stmt,'ALL' apps,'ON' db_default,'OFF' req from dual union all
select 'optimizer_adaptive_plans' param,'MANDATORY' category,'19.0.0' stmt,'ALL' apps,'TRUE' db_default,'TRUE' req from dual union all
select 'optimizer_adaptive_statistics' param,'MANDATORY' category,'19.0.0' stmt,'ALL' apps,'FALSE' db_default,'FALSE' req from dual union all
select 'pga_aggregate_limit' param,'MANDATORY' category,'19.0.0' stmt,'ALL' apps,'DERIVED' db_default,'0' req from dual union all
select 'temp_undo_enabled' param,'SIZING' category,'19.0.0' stmt,'ALL' apps,'FALSE' db_default,'FALSE' req from dual union all
select '_pdb_name_case_sensitive' param,'MANDATORY' category,'19.0.0' stmt,'ALL' apps,'FALSE' db_default,'TRUE' req from dual union all
select 'event' param,'MANDATORY' category,'19.0.0' stmt,'ALL' apps,null db_default,'10946 trace name context forever, level 8454144' req from dual union all
select 'service_names' param,'OTHERS' category,'19.0.0' stmt,'ALL' apps,null db_default,(select value from v$system_parameter where name='db_unique_name') || '(no other values)' req from dual union all
select '_kks_use_mutex_pin' param,'REMOVE' category,'19.0.0' stmt,'ALL' apps,null db_default,null req from dual union all
select '_shared_pool_reserved_min_alloc' param,'REMOVE' category,'19.0.0' stmt,'ALL' apps,null db_default,null req from dual union all
select '_sqlexec_progression_cost' param,'REMOVE' category,'19.0.0' stmt,'ALL' apps,null db_default,null req from dual union all
select 'exafusion_enabled' param,'REMOVE' category,'19.0.0' stmt,'ALL' apps,null db_default,null req from dual union all
select 'exclude_seed_cdb_view' param,'REMOVE' category,'19.0.0' stmt,'ALL' apps,null db_default,null req from dual union all
select 'global_context_pool_size' param,'REMOVE' category,'19.0.0' stmt,'ALL' apps,null db_default,null req from dual union all
select 'max_enabled_roles' param,'REMOVE' category,'19.0.0' stmt,'ALL' apps,null db_default,null req from dual union all
select 'O7_DICTIONARY_ACCESSIBILITY' param,'REMOVE' category,'19.0.0' stmt,'ALL' apps,null db_default,null req from dual union all
select 'olap_page_pool_size' param,'REMOVE' category,'19.0.0' stmt,'ALL' apps,null db_default,null req from dual union all
select 'optimizer_adaptive_features' param,'REMOVE' category,'19.0.0' stmt,'ALL' apps,null db_default,null req from dual union all
select 'parallel_automatic_tuning' param,'REMOVE' category,'19.0.0' stmt,'ALL' apps,null db_default,null req from dual union all
select 'parallel_degree_level' param,'REMOVE' category,'19.0.0' stmt,'ALL' apps,null db_default,null req from dual union all
select 'parallel_io_cap_enabled' param,'REMOVE' category,'19.0.0' stmt,'ALL' apps,null db_default,null req from dual union all
select 'parallel_server' param,'REMOVE' category,'19.0.0' stmt,'ALL' apps,null db_default,null req from dual union all
select 'parallel_server_instances' param,'REMOVE' category,'19.0.0' stmt,'ALL' apps,null db_default,null req from dual union all
select 'plsql_compiler_flags' param,'REMOVE' category,'19.0.0' stmt,'ALL' apps,null db_default,null req from dual union all
select 'plsql_native_library_dir' param,'REMOVE' category,'19.0.0' stmt,'ALL' apps,null db_default,null req from dual union all
select 'plsql_native_library_subdir_count' param,'REMOVE' category,'19.0.0' stmt,'ALL' apps,null db_default,null req from dual union all
select 'plsql_optimize_level' param,'REMOVE' category,'19.0.0' stmt,'ALL' apps,null db_default,null req from dual union all
select 'standby_archive_dest' param,'REMOVE' category,'19.0.0' stmt,'ALL' apps,null db_default,null req from dual union all
select 'timed_statistics' param,'REMOVE' category,'19.0.0' stmt,'ALL' apps,null db_default,null req from dual union all
select 'use_indirect_data_buffers' param,'REMOVE' category,'19.0.0' stmt,'ALL' apps,null db_default,null req from dual
),
ctx as (
select substr(i.version,1,6) dbv, substr(fpg.release_name,1,4) appsv from v$instance i, fnd_product_groups fpg
),
ref as (
select r.param, r.category, r.db_default, r.req
from ref0 r, ctx
where (r.stmt='ALL' or r.stmt=ctx.dbv) and (r.apps='ALL' or r.apps=ctx.appsv)
)
select
x.section "Section",
x.parameter_name "Parameter Name",
fmt_size(x.current_value) "Current Value",
fmt_size(x.required_value) "Required Value",
x.db_default "DB Default",
x.check_result "Check",
x.description "Description",
x.session_modifiable "Session Modifiable",
x.system_modifiable "System Modifiable"
from
(
select '1. Mandatory Database Parameters' section, ref.param parameter_name, nvl(sp.value,'(not set)') current_value, ref.req required_value, ref.db_default,
case ref.req when upper(sp.value) then 'OK' when nvl(sp.value,ref.db_default) then 'NOT FOUND:OK' else 'ERROR' end check_result,
sp.description, cast(null as varchar2(1)) session_modifiable, cast(null as varchar2(9)) system_modifiable
from ref, v$system_parameter2 sp
where ref.category='MANDATORY' and ref.param=sp.name(+) union all
select '2. Database Parameters to be Removed', ref.param, nvl(sp.value,'(not set)'), to_char(null), to_char(null),
case nvl(sp.isdefault,'TRUE') when 'TRUE' then 'OK' else 'ERROR' end,
sp.description, to_char(null), to_char(null)
from ref, v$system_parameter2 sp
where ref.category='REMOVE' and ref.param<>'event' and ref.param=sp.name(+) union all
select '2. Database Parameters to be Removed', ref.param||'='||ref.req, nvl(sp.value,'(not set)'), to_char(null), to_char(null),
case nvl(sp.value,'TRUE') when 'TRUE' then 'OK' else 'ERROR' end,
sp.description, to_char(null), to_char(null)
from ref, v$system_parameter2 sp
where ref.category='REMOVE' and ref.param='event' and ref.param=sp.name(+) and ref.req=sp.value(+) union all
select '3. Database Additional Parameters', sp.name, sp.value,
case substr(sp.name,1,1) when '_' then 'Do not set hidden parameters' else 'No Recommendation' end, to_char(null),
'EXTRA', sp.description, sp.isses_modifiable, sp.issys_modifiable
from v$system_parameter2 sp
where sp.isdefault='FALSE' and sp.name not in (select ref.param from ref) union all
select '3. Database Additional Parameters', ref.param, nvl(sp.value,'(not set)'), ref.req, ref.db_default,
case ref.req when upper(sp.value) then 'OK' when nvl(sp.value,ref.db_default) then 'NOT FOUND:OK' else ref.category end,
sp.description, sp.isses_modifiable, sp.issys_modifiable
from ref, v$system_parameter2 sp
where ref.category not in ('MANDATORY','REMOVE') and ref.param=sp.name(+)
) x
where 1=1
order by x.section, x.check_result, x.parameter_name
