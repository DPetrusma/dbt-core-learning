with games as (
    select * from {{ ref('stg_games') }}
),
game_ratings as (
    select
        game_id,
        count(*) as number_of_ratings,
        cast(avg(rating) as numeric(3,2)) as avg_rating,
        max(rating_datetime) as latest_rating_datetime
    from 
        {{ ref('stg_ratings')}}
    group by
        game_id
)
select
    g.game_id,
    g.name,
    g.dylan_rating,
    g.min_players,
    g.max_players,
    gr.number_of_ratings,
    gr.avg_rating,
    gr.latest_rating_datetime
from
    games as g
    left join game_ratings as gr using (game_id)