with validation as (
    select  sum(quantity) as sum_val
        from {{ ref('ft_order')}}
    where order_id = 2
)

select * from validation where sum_val != 3