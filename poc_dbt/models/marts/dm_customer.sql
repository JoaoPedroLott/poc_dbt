with selected as (
    select  customer_id,
            first_name,
            last_name,
            phone,
            email,
            street,
            city,
            state,
            zip_code
        from {{ ref('stg_customer') }}
),
transformed as (
    select  md5(customer_id::text || email::text) AS sk_customer,
            *
        from selected
)

select * from transformed