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
