with selected as (
    select  staff_id,
            first_name,
            last_name,
            email,
            phone,
            active,
            store_id,
            manager_id
        from {{ ref('stg_staff') }}
),
transformed as (
    select  md5(staff_id::text || phone::text) AS sk_staff,
            *
        from selected
)

select * from transformed