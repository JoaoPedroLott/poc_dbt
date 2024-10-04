with source as (
    select  category_id,
            category_name
        from {{ source('poc_dbt_source', 'categories') }}
)

select * from source