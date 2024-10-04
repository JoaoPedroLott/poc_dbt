with validation as (
    select  sum(quantity) as sum_val
        from {{ ref('ft_stock')}}
    where fk_store = 1
)

select * from validation where sum_val != 4532