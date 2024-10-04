with source as (
    select  store_id,
            store_name,
            phone,
            email,
            street,
            city,
            state,
            zip_code
        from {{ source('poc_dbt_source', 'stores') }}
)

select * from source