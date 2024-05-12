CREATE TABLE color (
	color VARCHAR(10) NOT NULL,
	PRIMARY KEY (color)
);

INSERT INTO color (color) VALUES ('black');
INSERT INTO color (color) VALUES ('red');
INSERT INTO color (color) VALUES ('white');
INSERT INTO color (color) VALUES ('green');

CREATE TABLE symbol (
    symbol VARCHAR(40) NOT NULL,
    PRIMARY KEY (symbol)
);

INSERT INTO symbol(symbol) VALUES ('Helmet');
INSERT INTO symbol(symbol) VALUES ('Ghost');
INSERT INTO symbol(symbol) VALUES ('Hobbit');
INSERT INTO symbol(symbol) VALUES ('Diamond');
INSERT INTO symbol(symbol) VALUES ('Candle Holder');
INSERT INTO symbol(symbol) VALUES ('Owl');
INSERT INTO symbol(symbol) VALUES ('Chest');
INSERT INTO symbol(symbol) VALUES ('Bat');
INSERT INTO symbol(symbol) VALUES ('Dragon');
INSERT INTO symbol(symbol) VALUES ('Ring');
INSERT INTO symbol(symbol) VALUES ('Sword');
INSERT INTO symbol(symbol) VALUES ('Skull');
INSERT INTO symbol(symbol) VALUES ('Scarab');
INSERT INTO symbol(symbol) VALUES ('Genie');
INSERT INTO symbol(symbol) VALUES ('Crown');
INSERT INTO symbol(symbol) VALUES ('Keychain');
INSERT INTO symbol(symbol) VALUES ('Fairy');
INSERT INTO symbol(symbol) VALUES ('Bag of gold');
INSERT INTO symbol(symbol) VALUES ('Salamander');
INSERT INTO symbol(symbol) VALUES ('Book');
INSERT INTO symbol(symbol) VALUES ('Map');
INSERT INTO symbol(symbol) VALUES ('Spider');
INSERT INTO symbol(symbol) VALUES ('Skull moth');
INSERT INTO symbol(symbol) VALUES ('Mouse');

CREATE TABLE tile (
    tile VARCHAR(40) NOT NULL,
    image VARCHAR(250) NOT NULL,
    north INTEGER NOT NULL,
    east INTEGER NOT NULL,
    south INTEGER NOT NULL,
    west INTEGER NOT NULL,
    symbol VARCHAR(20),
    PRIMARY KEY (tile),
    FOREIGN KEY (symbol) REFERENCES symbol(symbol)
);

INSERT INTO tile(tile, image, north, east, south, west, symbol) VALUES ('red', '', 0, 1, 1, 0, null);
INSERT INTO tile(tile, image, north, east, south, west, symbol) VALUES ('black', '', 0, 0, 1, 1, null);
INSERT INTO tile(tile, image, north, east, south, west, symbol) VALUES ('white', '', 1, 1, 0, 0, null);
INSERT INTO tile(tile, image, north, east, south, west, symbol) VALUES ('green', '', 1, 0, 0, 1, null);
INSERT INTO tile(tile, image, north, east, south, west, symbol) VALUES ('corner00', '', 0, 1, 1, 0, null);
INSERT INTO tile(tile, image, north, east, south, west, symbol) VALUES ('corner01', '', 0, 1, 1, 0, null);
INSERT INTO tile(tile, image, north, east, south, west, symbol) VALUES ('corner02', '', 0, 1, 1, 0, null);
INSERT INTO tile(tile, image, north, east, south, west, symbol) VALUES ('corner03', '', 0, 1, 1, 0, null);
INSERT INTO tile(tile, image, north, east, south, west, symbol) VALUES ('corner04', '', 0, 1, 1, 0, null);
INSERT INTO tile(tile, image, north, east, south, west, symbol) VALUES ('corner05', '', 0, 1, 1, 0, null);
INSERT INTO tile(tile, image, north, east, south, west, symbol) VALUES ('corner06', '', 0, 1, 1, 0, null);
INSERT INTO tile(tile, image, north, east, south, west, symbol) VALUES ('corner07', '', 0, 1, 1, 0, null);
INSERT INTO tile(tile, image, north, east, south, west, symbol) VALUES ('corner08', '', 0, 1, 1, 0, null);
INSERT INTO tile(tile, image, north, east, south, west, symbol) VALUES ('corner09', '', 0, 1, 1, 0, null);
INSERT INTO tile(tile, image, north, east, south, west, symbol) VALUES ('straight00', '', 1, 0, 1, 0, null);
INSERT INTO tile(tile, image, north, east, south, west, symbol) VALUES ('straight01', '', 1, 0, 1, 0, null);
INSERT INTO tile(tile, image, north, east, south, west, symbol) VALUES ('straight02', '', 1, 0, 1, 0, null);
INSERT INTO tile(tile, image, north, east, south, west, symbol) VALUES ('straight03', '', 1, 0, 1, 0, null);
INSERT INTO tile(tile, image, north, east, south, west, symbol) VALUES ('straight04', '', 1, 0, 1, 0, null);
INSERT INTO tile(tile, image, north, east, south, west, symbol) VALUES ('straight05', '', 1, 0, 1, 0, null);
INSERT INTO tile(tile, image, north, east, south, west, symbol) VALUES ('straight06', '', 1, 0, 1, 0, null);
INSERT INTO tile(tile, image, north, east, south, west, symbol) VALUES ('straight07', '', 1, 0, 1, 0, null);
INSERT INTO tile(tile, image, north, east, south, west, symbol) VALUES ('straight08', '', 1, 0, 1, 0, null);
INSERT INTO tile(tile, image, north, east, south, west, symbol) VALUES ('straight09', '', 1, 0, 1, 0, null);
INSERT INTO tile(tile, image, north, east, south, west, symbol) VALUES ('straight10', '', 1, 0, 1, 0, null);
INSERT INTO tile(tile, image, north, east, south, west, symbol) VALUES ('straight11', '', 1, 0, 1, 0, null);
INSERT INTO tile(tile, image, north, east, south, west, symbol) VALUES ('skull', '', 0, 1, 1, 1, 'Skull');
INSERT INTO tile(tile, image, north, east, south, west, symbol) VALUES ('sword', '', 0, 1, 1, 1, 'Sword');
INSERT INTO tile(tile, image, north, east, south, west, symbol) VALUES ('bag of gold', '', 1, 1, 1, 0, 'Bag of gold');
INSERT INTO tile(tile, image, north, east, south, west, symbol) VALUES ('keychain', '', 1, 1, 1, 0, 'Keychain');
INSERT INTO tile(tile, image, north, east, south, west, symbol) VALUES ('diamond', '', 0, 1, 1, 1, 'Diamond');
INSERT INTO tile(tile, image, north, east, south, west, symbol) VALUES ('helmet', '', 1, 0, 1, 1, 'Helmet');
INSERT INTO tile(tile, image, north, east, south, west, symbol) VALUES ('book', '', 1, 1, 1, 0, 'Book');
INSERT INTO tile(tile, image, north, east, south, west, symbol) VALUES ('crown', '', 1, 1, 0, 1, 'Crown');
INSERT INTO tile(tile, image, north, east, south, west, symbol) VALUES ('chest', '', 1, 0, 1, 1, 'Chest');
INSERT INTO tile(tile, image, north, east, south, west, symbol) VALUES ('candle holder', '', 1, 0, 1, 1, 'Candle Holder');
INSERT INTO tile(tile, image, north, east, south, west, symbol) VALUES ('map', '', 1, 1, 0, 1, 'Map');
INSERT INTO tile(tile, image, north, east, south, west, symbol) VALUES ('ring', '', 1, 1, 0, 1, 'Ring');
INSERT INTO tile(tile, image, north, east, south, west, symbol) VALUES ('salamander', '', 0, 1, 1, 0, 'Salamander');
INSERT INTO tile(tile, image, north, east, south, west, symbol) VALUES ('mouse', '', 0, 1, 1, 0, 'Mouse');
INSERT INTO tile(tile, image, north, east, south, west, symbol) VALUES ('owl', '', 0, 1, 1, 0, 'Owl');
INSERT INTO tile(tile, image, north, east, south, west, symbol) VALUES ('scarab', '', 0, 1, 1, 0, 'Scarab');
INSERT INTO tile(tile, image, north, east, south, west, symbol) VALUES ('skull mouth', '', 0, 1, 1, 0, 'Skull mouth');
INSERT INTO tile(tile, image, north, east, south, west, symbol) VALUES ('spider', '', 0, 1, 1, 0, 'Spider');
INSERT INTO tile(tile, image, north, east, south, west, symbol) VALUES ('dragon', '', 1, 1, 0, 1, 'Dragon');
INSERT INTO tile(tile, image, north, east, south, west, symbol) VALUES ('ghost', '', 1, 1, 0, 1, 'Ghost');
INSERT INTO tile(tile, image, north, east, south, west, symbol) VALUES ('bat', '', 1, 1, 0, 1, 'Bat');
INSERT INTO tile(tile, image, north, east, south, west, symbol) VALUES ('hobbit', '', 1, 1, 0, 1, 'Hobbit');
INSERT INTO tile(tile, image, north, east, south, west, symbol) VALUES ('fairy', '', 1, 1, 0, 1, 'Fairy');
INSERT INTO tile(tile, image, north, east, south, west, symbol) VALUES ('genie', '', 1, 1, 0, 1, 'Genie');

CREATE TABLE game_status (
    status VARCHAR(20) NOT NULL,
    PRIMARY KEY (status)
);

INSERT INTO game_status(status) VALUES ('Waiting');
INSERT INTO game_status(status) VALUES ('Playing');
INSERT INTO game_status(status) VALUES ('Ended');

CREATE TABLE game (
    game_id VARCHAR(40) NOT NULL,
    status VARCHAR(20) NOT NULL,
    PRIMARY KEY (game_id),
    FOREIGN KEY (status) REFERENCES game_status(status)
);

CREATE TABLE game_tile(
    game_id VARCHAR(40) NOT NULL,
    tile VARCHAR(40) NOT NULL,
    rotation INTEGER NOT NULL,
    PRIMARY KEY (game_id, tile)
);

CREATE TABLE player (
	player_id VARCHAR(40) NOT NULL,
	username VARCHAR(80) NOT NULL,
	color VARCHAR(10) NOT NULL,
	game_id VARCHAR(40) NOT NULL,
	PRIMARY KEY (player_id),
	FOREIGN KEY (color) REFERENCES color(color),
	FOREIGN KEY (game_id) REFERENCES game(game_id)
);

CREATE TABLE card_status (
    status VARCHAR(20) NOT NULL,
    PRIMARY KEY (status)
);

INSERT INTO card_status (status) VALUES ('Hidden');
INSERT INTO card_status (status) VALUES ('Open');
INSERT INTO card_status (status) VALUES ('Solved');

CREATE TABLE player_card (
    player_id VARCHAR(40) NOT NULL,
    symbol VARCHAR(20) NOT NULL,
    status VARCHAR(20) NOT NULL,
    sequence INTEGER NOT NULL,
    PRIMARY KEY (player_id, symbol),
    FOREIGN KEY (player_id) REFERENCES player(player_id),
    FOREIGN KEY (symbol) REFERENCES symbol(symbol),
    FOREIGN KEY (status) REFERENCES card_status(status)
);
