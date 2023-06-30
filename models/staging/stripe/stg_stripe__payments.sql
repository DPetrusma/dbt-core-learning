with source as (
    select * from {{ source('stripe', 'payments') }}
),
transformed as (
    select  ORDERID as order_id,
            CREATED AS successful_order_date,
            AMOUNT / 100.0 as successful_order_dollars,
            STATUS
    from    source
    where   STATUS <> 'fail'
)
select * from transformed