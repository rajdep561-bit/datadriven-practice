select t1.err_id,t1.err_type,t1.message,t1.svc_name,
t1.severity,t1."count",t1.first_at,t2.status,t2.latency,t2.uptime from err_tracks as t1 
inner join svc_health as t2
 on t1.svc_name=t2.svc_name;
