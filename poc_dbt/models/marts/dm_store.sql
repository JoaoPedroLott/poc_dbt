with selected as (
    select  store_id,
            store_name,
            phone,
            email,
            street,
            city,
            state,
            zip_code
        from {{ ref('stg_store') }}
),
transformed as (
    select  md5(store_id::text || zip_code::text) AS sk_store,
            *
        from selected
)

select * from transformed