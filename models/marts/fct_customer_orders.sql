WITH

Orders as (
    select * from {{ ref('stg_jaffle_shop__orders') }}
),

Payments as (
    select * from {{ ref('stg_stripe__payments') }}
),

Customers as (
    select * from {{ ref('stg_jaffle_shop__customers') }}
),

paid_orders as (
    select  Orders.order_id,
            Orders.customer_id,
            Orders.order_placed_at,
            Orders.order_status,
            p.total_amount_paid,
            p.payment_finalized_date,
            C.customer_first_name,
            C.customer_last_name
    from    Orders
                left join   (
                            select      order_id,
                                        max(successful_order_date) as payment_finalized_date,
                                        sum(successful_order_dollars) as total_amount_paid
                            from        Payments
                            group by    order_id
                            ) as p
                    on  orders.order_id = p.order_id
                left join   Customers as C
                    on  orders.customer_id = C.customer_id
),

customer_orders as (
    select      C.customer_id,
                min(Orders.order_placed_at) as first_order_date,
                max(Orders.order_placed_at) as most_recent_order_date,
                count(Orders.order_id) AS number_of_orders
    from        Customers as C
                    left join   Orders
                        on  orders.customer_id = C.customer_id
    group by    C.customer_id
),

final as (
select      p.*,
            ROW_NUMBER() OVER (ORDER BY p.order_id) as transaction_seq,
            ROW_NUMBER() OVER (PARTITION BY p.customer_id ORDER BY p.order_id) as customer_sales_seq,
            CASE    WHEN c.first_order_date = p.order_placed_at THEN 'new'
                                                                ELSE 'return'
            END as nvsr,
            SUM(p.total_amount_paid) OVER (PARTITION BY c.customer_id ORDER BY p.order_id) as customer_lifetime_value,
            c.first_order_date as fdos
FROM        paid_orders p
                left join   customer_orders as c
                    on  c.customer_id = p.customer_id
order by    p.order_id
)

select * from final