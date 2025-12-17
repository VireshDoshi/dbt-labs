with orders as (

    select * from {{ ref('stg_orders') }}

),

postcodes as (

    select * from {{ ref('stg_postcodes') }}

),
final as (

    select
        orders.order_id,
        orders.customer_id,
        orders.order_date,
        orders.order_status,
        orders.order_total_amount,
        orders.cust_name,
        COALESCE(postcodes.town, postcodes.region, 'Unknown') as cust_town
    from orders, postcodes 
    where orders.cust_postcode_id = postcodes.postcode_id


)

select * from final