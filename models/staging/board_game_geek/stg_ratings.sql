select
    board_game_id as game_id,
    rating_datetime,
    score as rating
from {{ source('board_game_geek','game_ratings') }}