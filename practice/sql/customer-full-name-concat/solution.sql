with t1 as (select * from customers)
select concat(t1.first_name,' ',t1.last_name) as full_name,t1.customer_id,t1.country 
from t1
order by full_name,t1.customer_id;
