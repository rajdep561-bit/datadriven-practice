with t1 as (select * from transactions limit 1000),
t2 as (select user_id,round(sum(total_amount),3) 
as total_spend,count(distinct transaction_id) as purchase_count from t1 
group by user_id)
select user_id,total_spend,purchase_count,(100*total_spend/nullif(sum(total_spend) over (),0)) as spend_share_pct from t2;
