WITH

Customers as (
    select * from {{ ref('stg_jaffle_shop__customers') }}
),

int_orders as (
    select * from {{ ref('int_orders') }}
),

final as (
select      p.order_id,
            p.customer_id,
            p.order_placed_at,
            p.order_status,
            p.total_amount_paid,
            p.payment_finalized_date,
            C.customer_first_name,
            C.customer_last_name,
            MIN(p.order_placed_at) OVER (PARTITION BY p.customer_id ) as fdos,
            MAX(p.order_placed_at) OVER (PARTITION BY p.customer_id ) as most_recent_order_date,
            COUNT(p.order_id) OVER (PARTITION BY p.customer_id ) as number_of_orders,
            ROW_NUMBER() OVER (ORDER BY p.order_id) as transaction_seq,
            ROW_NUMBER() OVER (PARTITION BY p.customer_id ORDER BY p.order_id) as customer_sales_seq,
            CASE    WHEN RANK() OVER ( PARTITION BY p.customer_id ORDER BY p.order_placed_at, p.order_id ) = 1 
                            THEN    'new'
                            ELSE 'return'
            END as nvsr,
            SUM(p.total_amount_paid) OVER (PARTITION BY p.customer_id ORDER BY p.order_placed_at) as customer_lifetime_value
FROM        int_orders as p
                left join   Customers as C
                    on  p.customer_id = C.customer_id
order by    p.order_id
)

select * from final