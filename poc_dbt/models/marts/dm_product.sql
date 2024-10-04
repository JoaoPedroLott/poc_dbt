with selected as (
    select  product_id,
            product_name,
            brand_id,
            category_id,
            model_year,
            list_price
        from {{ ref('stg_product') }}
),
transformed as (
    select  md5(product_id::text || product_name::text || category_id::text|| model_year::text) AS sk_product,
            *
        from selected
)

select * from transformed