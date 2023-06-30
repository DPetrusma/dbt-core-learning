WITH

Orders as (
    select * from {{ ref('stg_jaffle_shop__orders') }}
),

Payments as (
    select * from {{ ref('stg_stripe__payments') }}
),

completed_payments as (
    select      order_id,
                max(successful_order_date) as payment_finalized_date,
                sum(successful_order_dollars) as total_amount_paid
    from        Payments
    where       status <> 'fail'
    group by    order_id
),

paid_orders as (
    select  Orders.order_id,
            Orders.customer_id,
            Orders.order_placed_at,
            Orders.order_status,
            p.total_amount_paid,
            p.payment_finalized_date
    from    Orders
                left join   completed_payments as p
                    on  orders.order_id = p.order_id
)

select * from paid_orders