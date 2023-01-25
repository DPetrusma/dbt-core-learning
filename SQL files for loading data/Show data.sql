select * from raw.board_game_ratings;
select * from raw.personal_game_collection;
--select * from dylanp_dev.stg_games;
--select * from dylanp_dev.stg_ratings;
--select * from dylanp_dev.dim_games;
--select * from prod.stg_games;
--select * from prod.stg_ratings;
--select * from prod.dim_games;

update raw.board_game_ratings
set score = 9
where score = 90;