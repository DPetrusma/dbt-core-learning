select
    objectid as game_id,
    objectname as name,
    rating as dylan_rating,
    average as bgg_average_rating,
    minplayers as min_players,
    maxplayers as max_players
from {{ source('board_game_geek','games') }}