with source as (
    select  brand_id,
            brand_name
        from {{ source('poc_dbt_source', 'brands') }}
)

select * from source