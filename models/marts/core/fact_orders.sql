with orders as (
    select * from {{ ref("stg_jaffle_shop_orders") }}
),
payment_type_orders as (
    select * from {{ ref("int_payment_type_amount_per_orders") }}
)
select
    ord.order_id,
    ord.customer_id,
    ord.order_date,
    pto.cash_amount,
    pto.credit_amount,
    pto.total_amount,
    case
        when ord.status = 'completed'
        then true
        else false
    end as is_order_completed
from orders as ord
left join payment_type_orders as pto
on ord.order_id = pto.order_id