with source as (

    {#-
    Normally we would select from the table here, but we are using seeds to load
    our data in this project
    #}
    select * from {{ ref('raw_postcodes') }}

),

renamed as (

    select
        postcode as postcode_id,
        town,
        region
    from source

)

select * from renamed