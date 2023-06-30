with source as (
    select * from {{ source('stripe', 'payments') }}
),
transformed as (
    select  ORDERID as order_id,
            CREATED AS successful_order_date,
            round(AMOUNT / 100.0,2) as successful_order_dollars,
            STATUS
    from    source
)
select * from transformed