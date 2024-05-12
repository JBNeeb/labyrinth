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

INSERT INTO tile(tile, image, north, east, south, west, symbol) VALUES ('red', 'images/tiles/red-80x80-final.png', 0, 1, 1, 0, null);
INSERT INTO tile(tile, image, north, east, south, west, symbol) VALUES ('black', 'images/tiles/black-80x80-final.png', 0, 0, 1, 1, null);
INSERT INTO tile(tile, image, north, east, south, west, symbol) VALUES ('white', 'images/tiles/white-80x80-final.png', 1, 1, 0, 0, null);
INSERT INTO tile(tile, image, north, east, south, west, symbol) VALUES ('green', 'images/tiles/green-80x80-final.png', 1, 0, 0, 1, null);
INSERT INTO tile(tile, image, north, east, south, west, symbol) VALUES ('corner00', 'images/tiles/corner-80x80-final.png', 0, 1, 1, 0, null);
INSERT INTO tile(tile, image, north, east, south, west, symbol) VALUES ('corner01', 'images/tiles/corner-80x80-final.png', 0, 1, 1, 0, null);
INSERT INTO tile(tile, image, north, east, south, west, symbol) VALUES ('corner02', 'images/tiles/corner-80x80-final.png', 0, 1, 1, 0, null);
INSERT INTO tile(tile, image, north, east, south, west, symbol) VALUES ('corner03', 'images/tiles/corner-80x80-final.png', 0, 1, 1, 0, null);
INSERT INTO tile(tile, image, north, east, south, west, symbol) VALUES ('corner04', 'images/tiles/corner-80x80-final.png', 0, 1, 1, 0, null);
INSERT INTO tile(tile, image, north, east, south, west, symbol) VALUES ('corner05', 'images/tiles/corner-80x80-final.png', 0, 1, 1, 0, null);
INSERT INTO tile(tile, image, north, east, south, west, symbol) VALUES ('corner06', 'images/tiles/corner-80x80-final.png', 0, 1, 1, 0, null);
INSERT INTO tile(tile, image, north, east, south, west, symbol) VALUES ('corner07', 'images/tiles/corner-80x80-final.png', 0, 1, 1, 0, null);
INSERT INTO tile(tile, image, north, east, south, west, symbol) VALUES ('corner08', 'images/tiles/corner-80x80-final.png', 0, 1, 1, 0, null);
INSERT INTO tile(tile, image, north, east, south, west, symbol) VALUES ('corner09', 'images/tiles/corner-80x80-final.png', 0, 1, 1, 0, null);
INSERT INTO tile(tile, image, north, east, south, west, symbol) VALUES ('straight00', 'images/tiles/straight-80x80-final.png', 1, 0, 1, 0, null);
INSERT INTO tile(tile, image, north, east, south, west, symbol) VALUES ('straight01', 'images/tiles/straight-80x80-final.png', 1, 0, 1, 0, null);
INSERT INTO tile(tile, image, north, east, south, west, symbol) VALUES ('straight02', 'images/tiles/straight-80x80-final.png', 1, 0, 1, 0, null);
INSERT INTO tile(tile, image, north, east, south, west, symbol) VALUES ('straight03', 'images/tiles/straight-80x80-final.png', 1, 0, 1, 0, null);
INSERT INTO tile(tile, image, north, east, south, west, symbol) VALUES ('straight04', 'images/tiles/straight-80x80-final.png', 1, 0, 1, 0, null);
INSERT INTO tile(tile, image, north, east, south, west, symbol) VALUES ('straight05', 'images/tiles/straight-80x80-final.png', 1, 0, 1, 0, null);
INSERT INTO tile(tile, image, north, east, south, west, symbol) VALUES ('straight06', 'images/tiles/straight-80x80-final.png', 1, 0, 1, 0, null);
INSERT INTO tile(tile, image, north, east, south, west, symbol) VALUES ('straight07', 'images/tiles/straight-80x80-final.png', 1, 0, 1, 0, null);
INSERT INTO tile(tile, image, north, east, south, west, symbol) VALUES ('straight08', 'images/tiles/straight-80x80-final.png', 1, 0, 1, 0, null);
INSERT INTO tile(tile, image, north, east, south, west, symbol) VALUES ('straight09', 'images/tiles/straight-80x80-final.png', 1, 0, 1, 0, null);
INSERT INTO tile(tile, image, north, east, south, west, symbol) VALUES ('straight10', 'images/tiles/straight-80x80-final.png', 1, 0, 1, 0, null);
INSERT INTO tile(tile, image, north, east, south, west, symbol) VALUES ('straight11', 'images/tiles/straight-80x80-final.png', 1, 0, 1, 0, null);
INSERT INTO tile(tile, image, north, east, south, west, symbol) VALUES ('skull', 'images/tiles/skull-80x80-final.png', 0, 1, 1, 1, 'SKULL');
INSERT INTO tile(tile, image, north, east, south, west, symbol) VALUES ('sword', 'images/tiles/sword-80x80-final.png', 0, 1, 1, 1, 'SWORD');
INSERT INTO tile(tile, image, north, east, south, west, symbol) VALUES ('bag of gold', 'images/tiles/bag-of-gold-80x80-final.png', 1, 1, 1, 0, 'BAG_OF_GOLD');
INSERT INTO tile(tile, image, north, east, south, west, symbol) VALUES ('keychain', 'images/tiles/keychain-80x80-final.png', 1, 1, 1, 0, 'KEYCHAIN');
INSERT INTO tile(tile, image, north, east, south, west, symbol) VALUES ('diamond', 'images/tiles/diamond-80x80-final.png', 0, 1, 1, 1, 'DIAMOND');
INSERT INTO tile(tile, image, north, east, south, west, symbol) VALUES ('helmet', 'images/tiles/helmet-80x80-final.png', 1, 0, 1, 1, 'HELMET');
INSERT INTO tile(tile, image, north, east, south, west, symbol) VALUES ('book', 'images/tiles/book-80x80-final.png', 1, 1, 1, 0, 'BOOK');
INSERT INTO tile(tile, image, north, east, south, west, symbol) VALUES ('crown', 'images/tiles/crown-80x80-final.png', 1, 1, 0, 1, 'CROWN');
INSERT INTO tile(tile, image, north, east, south, west, symbol) VALUES ('chest', 'images/tiles/chest-80x80-final.png', 1, 0, 1, 1, 'CHEST');
INSERT INTO tile(tile, image, north, east, south, west, symbol) VALUES ('candle holder', 'images/tiles/candle-holder-80x80-final.png', 1, 0, 1, 1, 'CANDLE_HOLDER');
INSERT INTO tile(tile, image, north, east, south, west, symbol) VALUES ('map', 'images/tiles/map-80x80-final.png', 1, 1, 0, 1, 'MAP');
INSERT INTO tile(tile, image, north, east, south, west, symbol) VALUES ('ring', 'images/tiles/ring-80x80-final.png', 1, 1, 0, 1, 'RING');
INSERT INTO tile(tile, image, north, east, south, west, symbol) VALUES ('salamander', 'images/tiles/salamander-80x80-final.png', 0, 1, 1, 0, 'SALAMANDER');
INSERT INTO tile(tile, image, north, east, south, west, symbol) VALUES ('mouse', 'images/tiles/mouse-80x80-final.png', 0, 1, 1, 0, 'MOUSE');
INSERT INTO tile(tile, image, north, east, south, west, symbol) VALUES ('owl', 'images/tiles/owl-80x80-final.png', 0, 1, 1, 0, 'OWL');
INSERT INTO tile(tile, image, north, east, south, west, symbol) VALUES ('scarab', 'images/tiles/scarab-80x80-final.png', 0, 1, 1, 0, 'SCARAB');
INSERT INTO tile(tile, image, north, east, south, west, symbol) VALUES ('skull moth', 'images/tiles/skull-moth-80x80-final.png', 0, 1, 1, 0, 'SKULL_MOTH');
INSERT INTO tile(tile, image, north, east, south, west, symbol) VALUES ('spider', 'images/tiles/spider-80x80-final.png', 0, 1, 1, 0, 'SPIDER');
INSERT INTO tile(tile, image, north, east, south, west, symbol) VALUES ('dragon', 'images/tiles/dragon-80x80-final.png', 1, 1, 0, 1, 'DRAGON');
INSERT INTO tile(tile, image, north, east, south, west, symbol) VALUES ('ghost', 'images/tiles/ghost-80x80-final.png', 1, 1, 0, 1, 'GHOST');
INSERT INTO tile(tile, image, north, east, south, west, symbol) VALUES ('bat', 'images/tiles/bat-80x80-final.png', 1, 1, 0, 1, 'BAT');
INSERT INTO tile(tile, image, north, east, south, west, symbol) VALUES ('hobbit', 'images/tiles/hobbit-80x80-final.png', 1, 1, 0, 1, 'HOBBIT');
INSERT INTO tile(tile, image, north, east, south, west, symbol) VALUES ('fairy', 'images/tiles/fairy-80x80-final.png', 1, 1, 0, 1, 'FAIRY');
INSERT INTO tile(tile, image, north, east, south, west, symbol) VALUES ('genie', 'images/tiles/genie-80x80-final.png', 1, 1, 0, 1, 'GENIE');

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
