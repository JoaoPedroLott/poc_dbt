with source as (
    select  order_id,
            item_id,
            product_id,
            quantity,
            list_price,
            discount
        from {{ source('poc_dbt_source', 'order_items') }}
)

select * from source