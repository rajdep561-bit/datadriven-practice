with t1 as (select * from ad_impressions)
,t2 as (select * from transactions) 
,r1 as (
select t1.ad_campaign,count(distinct case when t1.clicked=1 then t1.user_id end) as unique_clickers
,count(*) as impressions,
sum(t1.clicked) as clicks from t1  where t1.user_id IS NOT NULL
group by t1.ad_campaign
having sum(t1.clicked)>=4)
,r2 as (select r1.ad_campaign,r1.unique_clickers,r1.impressions,r1.clicks
  , round(100.0* r1.clicks/r1.impressions,2) as ctr_pct from r1)

,r3 as (select t1.ad_campaign,count(distinct t2.user_id) as conversions from t1 
    inner join t2 on t2.user_id=t1.user_id 
    where t2.transaction_date>=date(t1.impression_time) and t1.clicked =1 and
    date(t2.transaction_date)<=date(t1.impression_time,'+7 days')
    group by t1.ad_campaign 
    )
    
,r4 as (select r2.ad_campaign,r2.impressions,r2.unique_clickers,r2.clicks,r2.ctr_pct,r3.conversions from r2 
left join r3 on r3.ad_campaign=r2.ad_campaign)

select r4.ad_campaign,r4.impressions,r4.clicks,r4.ctr_pct,coalesce(r4.conversions,0) as conversions,ROUND(
            100.0 * r4.conversions / NULLIF(r4.unique_clickers, 0),
            2
        ) AS conversion_pct from r4;
