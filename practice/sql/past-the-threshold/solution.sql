with t1 as  (select * from user_sessions),
t2 as (select * from users),
t3 as (select user_id,count(*) as session_count from t1 group by t1.user_id)
select * from t3 where t3.session_count>3;
