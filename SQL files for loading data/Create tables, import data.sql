CREATE TABLE raw.personal_game_collection (
	objectname text NULL,
	objectid integer NULL,
	rating integer NULL,
	average numeric(7,5) NULL,
	minplayers integer NULL,
	maxplayers integer NULL
	);
	
COPY raw.personal_game_collection
FROM '/Users/dylanpetrusma1/Downloads/bgg_personal_collection.csv'
DELIMITER ','
CSV Header;

select * from raw.personal_game_collection;

CREATE TABLE raw.board_game_ratings (
	board_game_id integer NULL,
	rating_datetime timestamp(0) with time zone NULL,
	score integer NULL
	);

set datestyle to dmy;

COPY raw.board_game_ratings
FROM '/Users/dylanpetrusma1/Downloads/board_game_ratings.csv'
DELIMITER ','
CSV Header;

select * from raw.board_game_ratings;