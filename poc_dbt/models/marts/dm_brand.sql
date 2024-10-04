with selected as (
    select  brand_id,
            brand_name
        from {{ ref('stg_brand') }}
),
transformed as (
    select  md5(brand_id::text || brand_name::text) AS sk_brand,
            *
        from selected
)

select * from transformed