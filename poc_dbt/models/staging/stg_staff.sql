with source as (
    select  staff_id,
            first_name,
            last_name,
            email,
            phone,
            case 
                when active = 1 then True
                else False
            end as active,
            store_id,
            manager_id
        from {{ source('poc_dbt_source', 'staffs') }}
)

select * from source