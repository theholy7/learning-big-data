{{ config(materialized='table') }}

-- product_pk (not null primary key), constraints: identity, auto_increment, start_with 1
-- product_id (varchar(255))
-- category (varchar(255))

with unique_products as (
    select distinct("PRODUCTCODE") as product_id, "PRODUCTLINE" as category
    from {{ ref('sales_data_sample') }}
)
select
md5(product_id) as product_pk,
product_id,
category
from unique_products
order by category, product_id
