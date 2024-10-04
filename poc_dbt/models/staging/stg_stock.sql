with source as (
    select  store_id,
            product_id,
            quantity
        from {{ source('poc_dbt_source', 'stocks') }}
)

select * from source