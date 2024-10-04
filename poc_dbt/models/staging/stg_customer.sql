with source as (
    select  customer_id,
            first_name,
            last_name,
            phone,
            email,
            street,
            city,
            state,
            zip_code
        from {{ source('poc_dbt_source', 'customers') }}
)

select * from source