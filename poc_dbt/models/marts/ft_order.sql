with selected as (
    select 	o.order_id,
            oi.item_id,
            o.customer_id as fk_customer,
            o.store_id as fk_store,
            o.staff_id as fk_staff,
            oi.product_id as fk_product,
            oi.quantity,
            oi.list_price,
            oi.discount,
            o.order_status,
            o.order_date,
            o.required_date,
            o.shipped_date
    from {{ ref('stg_order') }} o
    left join {{ ref('stg_order_item') }} oi on (o.order_id = oi.order_id)
),
transformed as (
    select  md5(order_id::text || item_id::text) AS sk_order,
            *
    from selected
)

select * from transformed