with selected as (
    select 	store_id as fk_store,
		    product_id as fk_product,
		    quantity
        from {{ ref('stg_stock') }}
),
transformed as (
    select  md5(fk_store::text || fk_product::text) AS sk_stock,
            *
        from selected
)

select * from transformed