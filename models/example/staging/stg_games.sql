select
    game_id,
    name,
    min_players,
    max_players
from {{ source('board_game_geek','games')}}