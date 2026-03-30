
--checking if the table is loaded correctly

select * from `workspace`.`default`.`bright_coffee_shop_analysis_case_study_1` limit 100;


--Checking Data collection: started on 2023-01-01 and ended on 2023-06-30

select min(transaction_date) as start_date,
       max(transaction_date) as end_date
       from `workspace`.`default`.
       `bright_coffee_shop_analysis_case_study_1`;
 

--checking the names of the stores(Lower Manhattan,Hell's Kitchen and Astoria)

select distinct store_location
from `workspace`.`default`.
       `bright_coffee_shop_analysis_case_study_1`;


--checking products sold across all stores

 select distinct product_category
               from `workspace`.`default`.
       `bright_coffee_shop_analysis_case_study_1`;

--Showing product_category,product_type and product_detail


  select distinct product_category
                from `workspace`.`default`.
       `bright_coffee_shop_analysis_case_study_1`;

  select distinct product_detail
                from `workspace`.`default`.
       `bright_coffee_shop_analysis_case_study_1`;


  select distinct product_type
                from `workspace`.`default`.
       `bright_coffee_shop_analysis_case_study_1`;

   --Matching product_category,product_type and product_detail


  select distinct product_category,
                  product_type,
                  product_detail
                from `workspace`.`default`.
       `bright_coffee_shop_analysis_case_study_1`;

--checking for Nulls

select *
    from `workspace`.`default`.
       `bright_coffee_shop_analysis_case_study_1`
     where unit_price is NULL
      or transaction_date is NULL
      or transaction_time is NULL
      or transaction_qty is NULL
      or store_id is NULL;

--checking lowest and highest unit price

select min(unit_price) as lowest_price,
       max(unit_price) as Highest_price
from `workspace`.`default`.
       `bright_coffee_shop_analysis_case_study_1`;

--extracting the day and month

select
      dayname(transaction_date) as day_name,
      Monthname(transaction_date) as Month_name
from `workspace`.`default`.
       `bright_coffee_shop_analysis_case_study_1`;

--extracting time events


select
           Case
          when date_format (transaction_time,'HH:mm:ss') BETWEEN '00:00:00' and '11:59:59' then '01 Morning'
          when date_format (transaction_time,'HH:mm:ss') BETWEEN '12:00:00' and '16:59:59' then '02 Afternoon'
          when date_format (transaction_time,'HH:mm:ss') >='17:00:00' then '03 Evening'
          End as Time_Buckets
  from `workspace`.`default`.
       `bright_coffee_shop_analysis_case_study_1`;
----------------------------------------------------------------------
--Summury/final outcome of the case study
----------------------------------------------------------------------

SELECT
       transaction_id,
       transaction_date,
       transaction_time,
       transaction_qty,
       store_id,
       store_location,
       product_id,
       unit_price,
       product_category,
       product_type,
       transaction_qty,
       product_detail,
       Dayname(transaction_date) AS Day_name,
       Monthname(transaction_date) AS Month_name,
       Dayofmonth(transaction_date) AS Day_of_month,
CASE
          when Dayname(transaction_date) in ('Sat','Sun') Then 'weekend'
          Else 'Weekday'
          End as day_classification,
CASE
     WHEN date_format(transaction_time, 'HH:MM:SS') BETWEEN '05:00:00'AND '08:59:59' THEN '01 Rush Hour'
     WHEN date_format(transaction_time, 'HH:MM:SS') BETWEEN '09:00:00'AND '11:59:59' THEN '02 Mid Morning'
     WHEN date_format(transaction_time, 'HH:MM:SS') BETWEEN '12:00:00'AND '15:59:59' THEN '03 Afternoon'
     when date_format(transaction_time, 'HH:MM:SS') BETWEEN '16:00:00'AND '18:00:00' THEN '04 Night'
     ELSE '05 closed'
     END AS Time_classification,

CASE 
     WHEN (transaction_qty*unit_price) <=50  THEN'01 low spender'
     WHEN (transaction_qty*unit_price) BETWEEN 51 AND 200 THEN '02 medium spender'
     WHEN (transaction_qty*unit_price) BETWEEN 201 AND 300 THEN '03 high spender'
     ELSE '04 Blesser '
END AS Speend_bucket,
transaction_qty*unit_price AS Revenue
FROM `workspace`.`default`.`bright_coffee_shop_analysis_case_study_1`;
