/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: FND Nodes
-- Description: FND_NODES stores information about the nodes that are used to
install and run Oracle Application at your site. Each row includes
the name of the node and the platform code. The column name
NODE_NAME is the given name used to refer to the machine or node
at the site. The column PLATFORM_CODE specifies the make of the
machine or node (e.g. DEC VMS, Sequent Ptx, etc.). This
information is used to associate a concurrent manager with a
specific node to support distributed processing.

-- Excel Examle Output: https://www.enginatics.com/example/fnd-nodes/
-- Library Link: https://www.enginatics.com/reports/fnd-nodes/
-- Run Report: https://demo.enginatics.com/

select
fn.node_name,
xxen_util.yes(fn.support_db) database,
xxen_util.yes(fn.support_cp) concurrent,
xxen_util.yes(fn.support_forms) forms,
xxen_util.yes(fn.support_web) web,
xxen_util.yes(fn.support_admin) admin,
xxen_util.yes(fn.status) status,
fn.description,
fn.ping_response,
xxen_util.meaning(fn.platform_code,'PLATFORM',0) platform,
fn.server_address ip_address,
fn.host,
fn.domain,
fn.webhost,
fn.virtual_ip,
fn.server_id,
fn.appltop_id,
fn.node_mode,
xxen_util.user_name(fn.created_by) created_by,
xxen_util.client_time(fn.creation_date) creation_date,
xxen_util.user_name(fn.last_updated_by) last_updated_by,
xxen_util.client_time(fn.last_update_date) last_update_date
from
fnd_nodes fn
order by
fn.support_db desc,
fn.support_cp desc,
fn.node_name