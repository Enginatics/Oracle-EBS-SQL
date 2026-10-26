/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: FND Integrated SOA Gateway Requests
-- Description: Integrated SOA Gateway (ISG) web service requests as logged for the SOA Monitor, one row per request, with execution time, status, HTTP and fault details.
-- Execution seconds is the time between the gateway receiving the request and sending the response, rounded to whole seconds. Time a request spends queued before it reaches the gateway (client, load balancer, web tier) is not included: compare the client's send time with Request Received to measure it.
-- Show Requests in Process counts, for each request, the requests in process when it was received, itself included, to show how many calls the gateway handled in parallel. Use the template Throughput per Minute to see request volume and average execution time per minute.
-- Show Payload adds the request and response bodies, which ISG stores only for services with auditing enabled.
-- Excel Example Output: https://www.enginatics.com/example/fnd-integrated-soa-gateway-requests/
-- Library Link: https://www.enginatics.com/reports/fnd-integrated-soa-gateway-requests/
-- Run Report: https://demo.enginatics.com/

select
fsr.message_id,
fiai.display_name interface,
fsr.method operation,
&isg_12_2_columns
fsr.request_timestamp request_received,
fsr.request_completed response_sent,
round((fsr.request_completed-fsr.request_timestamp)*86400) execution_seconds,
&requests_in_process
trunc(fsr.request_timestamp,'mi') received_minute,
xxen_util.meaning(fsr.request_status,'FND_SOA_REQUEST_STATUS',0) status,
fsr.attrib6 http_status,
fsr.attrib7 fault_type,
fsr.attrib8 message,
fsr.attrib1 http_method,
xxen_util.meaning(fsr.request_pattern,'FND_SOA_MESSAGE_PATTERN',0) interaction_pattern,
fsr.attrib9 authentication_type,
xxen_util.user_name(fsr.user_id) user_name,
frv.responsibility_name responsibility,
fav.application_name application,
fsr.security_group_name security_group,
fsr.nls_language,
fsr.ip_address client_ip_address,
fsr.attrib2 content_type,
fsr.attrib3 accept,
fsr.attrib4 accept_language,
fsr.attrib5 language,
&payload_columns
fsr.irep_name internal_name
from
fnd_soa_request fsr,
fnd_irep_all_interfaces fiai,
fnd_responsibility_vl frv,
fnd_application_vl fav
where
1=1 and
fsr.irep_name=fiai.irep_name and
fiai.class_type not in ('SOAPSERVICEDOC','WEBSERVICEDOC','RESTSERVICEDOC') and
fsr.responsibility_id=frv.responsibility_id(+) and
fsr.responsibility_application_id=frv.application_id(+) and
fsr.responsibility_application_id=fav.application_id(+)
order by
fsr.request_timestamp desc,
fsr.message_id desc
