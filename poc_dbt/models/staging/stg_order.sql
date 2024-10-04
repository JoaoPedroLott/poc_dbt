with source as (
    select  order_id,
            customer_id,
            order_status,
            order_date,
            required_date,
            shipped_date,
            store_id,
            staff_id
        from {{ source('poc_dbt_source', 'orders') }}
)

select * from source