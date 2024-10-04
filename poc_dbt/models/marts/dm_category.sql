with selected as (
    select  category_id,
            category_name
        from {{ ref('stg_category') }}
),
transformed as (
    select  md5(category_id::text || category_name::text) AS sk_category,
            *
        from selected
)

select * from transformed