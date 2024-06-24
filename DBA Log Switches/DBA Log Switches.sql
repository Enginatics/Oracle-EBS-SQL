/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: DBA Log Switches
-- Description: None
-- Excel Examle Output: https://www.enginatics.com/example/dba-log-switches/
-- Library Link: https://www.enginatics.com/reports/dba-log-switches/
-- Run Report: https://demo.enginatics.com/

select
trunc(glh.first_time) "Date",
glh.inst_id,
to_char(glh.first_time,'Dy') day,
count(*) total,
sum(decode(to_char(glh.first_time,'hh24'),'00',1,0)) "h0",
sum(decode(to_char(glh.first_time,'hh24'),'01',1,0)) "h1",
sum(decode(to_char(glh.first_time,'hh24'),'02',1,0)) "h2",
sum(decode(to_char(glh.first_time,'hh24'),'03',1,0)) "h3",
sum(decode(to_char(glh.first_time,'hh24'),'04',1,0)) "h4",
sum(decode(to_char(glh.first_time,'hh24'),'05',1,0)) "h5",
sum(decode(to_char(glh.first_time,'hh24'),'06',1,0)) "h6",
sum(decode(to_char(glh.first_time,'hh24'),'07',1,0)) "h7",
sum(decode(to_char(glh.first_time,'hh24'),'08',1,0)) "h8",
sum(decode(to_char(glh.first_time,'hh24'),'09',1,0)) "h9",
sum(decode(to_char(glh.first_time,'hh24'),'10',1,0)) "h10",
sum(decode(to_char(glh.first_time,'hh24'),'11',1,0)) "h11",
sum(decode(to_char(glh.first_time,'hh24'),'12',1,0)) "h12",
sum(decode(to_char(glh.first_time,'hh24'),'13',1,0)) "h13",
sum(decode(to_char(glh.first_time,'hh24'),'14',1,0)) "h14",
sum(decode(to_char(glh.first_time,'hh24'),'15',1,0)) "h15",
sum(decode(to_char(glh.first_time,'hh24'),'16',1,0)) "h16",
sum(decode(to_char(glh.first_time,'hh24'),'17',1,0)) "h17",
sum(decode(to_char(glh.first_time,'hh24'),'18',1,0)) "h18",
sum(decode(to_char(glh.first_time,'hh24'),'19',1,0)) "h19",
sum(decode(to_char(glh.first_time,'hh24'),'20',1,0)) "h20",
sum(decode(to_char(glh.first_time,'hh24'),'21',1,0)) "h21",
sum(decode(to_char(glh.first_time,'hh24'),'22',1,0)) "h22",
sum(decode(to_char(glh.first_time,'hh24'),'23',1,0)) "h23",
round(count(*)/24,2) avg
from
gv$log_history glh
where
glh.thread#=glh.inst_id and
glh.first_time>sysdate-7
group by
trunc(glh.first_time),
glh.inst_id,
to_char(glh.first_time,'Dy')
order by
1,2