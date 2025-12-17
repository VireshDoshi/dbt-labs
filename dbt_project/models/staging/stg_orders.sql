{{ 
    config(
        materialized='incremental',
        unique_key='order_id', 
        on_schema_change='sync_all_columns'
    )

 }}

with source as (

    {#-
    Normally we would select from the table here, but we are using seeds to load
    our data in this project
    #}
    select * from {{ ref('raw_orders') }}

),

renamed as (

    select
        order_id,
        customer_id,
        order_date,
        order_status,
        total_amount as order_total_amount,
        customer_name as cust_name,
        customer_postcode as cust_postcode,
        SPLIT_PART(customer_postcode, ' ', 1) as cust_postcode_id 


    from source

    {% if is_incremental() %}

    -- Filter for new or changed records on subsequent runs
    WHERE order_date > (SELECT MAX(order_date) FROM {{ this }} )

    {% endif %}

)

select * from renamed