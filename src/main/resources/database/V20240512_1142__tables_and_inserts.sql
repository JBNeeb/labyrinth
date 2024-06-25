DROP TABLE player_card;
DROP TABLE card_status;
DROP TABLE player;
DROP TABLE game_tile;
DROP TABLE game;
DROP TABLE game_status;
DROP TABLE tile;
DROP TABLE card;
DROP TABLE symbol;
DROP TABLE color;

CREATE TABLE color (
	color VARCHAR(10) NOT NULL,
	PRIMARY KEY (color)
);

INSERT INTO color (color) VALUES ('BLACK');
INSERT INTO color (color) VALUES ('RED');
INSERT INTO color (color) VALUES ('WHITE');
INSERT INTO color (color) VALUES ('GREEN');

CREATE TABLE symbol (
    symbol VARCHAR(40) NOT NULL,
    PRIMARY KEY (symbol)
);

INSERT INTO symbol(symbol) VALUES ('HELMET');
INSERT INTO symbol(symbol) VALUES ('GHOST');
INSERT INTO symbol(symbol) VALUES ('HOBBIT');
INSERT INTO symbol(symbol) VALUES ('DIAMOND');
INSERT INTO symbol(symbol) VALUES ('CANDLE_HOLDER');
INSERT INTO symbol(symbol) VALUES ('OWL');
INSERT INTO symbol(symbol) VALUES ('CHEST');
INSERT INTO symbol(symbol) VALUES ('BAT');
INSERT INTO symbol(symbol) VALUES ('DRAGON');
INSERT INTO symbol(symbol) VALUES ('RING');
INSERT INTO symbol(symbol) VALUES ('SWORD');
INSERT INTO symbol(symbol) VALUES ('SKULL');
INSERT INTO symbol(symbol) VALUES ('SCARAB');
INSERT INTO symbol(symbol) VALUES ('GENIE');
INSERT INTO symbol(symbol) VALUES ('CROWN');
INSERT INTO symbol(symbol) VALUES ('KEYCHAIN');
INSERT INTO symbol(symbol) VALUES ('FAIRY');
INSERT INTO symbol(symbol) VALUES ('BAG_OF_GOLD');
INSERT INTO symbol(symbol) VALUES ('SALAMANDER');
INSERT INTO symbol(symbol) VALUES ('BOOK');
INSERT INTO symbol(symbol) VALUES ('MAP');
INSERT INTO symbol(symbol) VALUES ('SPIDER');
INSERT INTO symbol(symbol) VALUES ('SKULL_MOTH');
INSERT INTO symbol(symbol) VALUES ('MOUSE');

CREATE TABLE card (
    symbol VARCHAR(40) NOT NULL,
    image VARCHAR(250) NOT NULL,
    PRIMARY KEY (symbol),
    FOREIGN KEY (symbol) REFERENCES symbol(symbol)
);

INSERT INTO card (symbol, image) VALUES ('HELMET', '/images/cards/helmet-card-final-100x157.png');
INSERT INTO card (symbol, image) VALUES ('GHOST', '/images/cards/ghost-card-final-100x157.png');
INSERT INTO card (symbol, image) VALUES ('HOBBIT', '/images/cards/hobbit-card-final-100x157.png');
INSERT INTO card (symbol, image) VALUES ('DIAMOND', '/images/cards/diamond-card-final-100x157.png');
INSERT INTO card (symbol, image) VALUES ('CANDLE_HOLDER', '/images/cards/candle-holder-card-final-100x157.png');
INSERT INTO card (symbol, image) VALUES ('OWL', '/images/cards/owl-card-final-100x157.png');
INSERT INTO card (symbol, image) VALUES ('CHEST', '/images/cards/chest-card-final-100x157.png');
INSERT INTO card (symbol, image) VALUES ('BAT', '/images/cards/bat-card-final-100x157.png');
INSERT INTO card (symbol, image) VALUES ('DRAGON', '/images/cards/dragon-card-final-100x157.png');
INSERT INTO card (symbol, image) VALUES ('RING', '/images/cards/ring-card-final-100x157.png');
INSERT INTO card (symbol, image) VALUES ('SWORD', '/images/cards/sword-card-final-100x157.png');
INSERT INTO card (symbol, image) VALUES ('SKULL', '/images/cards/skull-card-final-100x157.png');
INSERT INTO card (symbol, image) VALUES ('SCARAB', '/images/cards/scarab-card-final-100x157l.png');
INSERT INTO card (symbol, image) VALUES ('GENIE', '/images/cards/genie-card-final-100x157.png');
INSERT INTO card (symbol, image) VALUES ('CROWN', '/images/cards/crown-card-final-100x157.png');
INSERT INTO card (symbol, image) VALUES ('KEYCHAIN', '/images/cards/keychain-card-final-100x157.png');
INSERT INTO card (symbol, image) VALUES ('FAIRY', '/images/cards/fairy-card-final-100x157.png');
INSERT INTO card (symbol, image) VALUES ('BAG_OF_GOLD', '/images/cards/bag-of-gold-card-final-100x157.png');
INSERT INTO card (symbol, image) VALUES ('SALAMANDER', '/images/cards/salamander-card-final-100x157.png');
INSERT INTO card (symbol, image) VALUES ('BOOK', '/images/cards/book-card-final-100x157.png');
INSERT INTO card (symbol, image) VALUES ('MAP', '/images/cards/map-card-final-100x157.png');
INSERT INTO card (symbol, image) VALUES ('SPIDER', '/images/cards/spider-card-final-100x157.png');
INSERT INTO card (symbol, image) VALUES ('SKULL_MOTH', '/images/cards/skull-moth-card-final-100x157.png');
INSERT INTO card (symbol, image) VALUES ('MOUSE', '/images/cards/mouse-card-final-100x157.png');

CREATE TABLE tile (
    tile VARCHAR(40) NOT NULL,
    image VARCHAR(250) NOT NULL,
    north INTEGER NOT NULL,
    east INTEGER NOT NULL,
    south INTEGER NOT NULL,
    west INTEGER NOT NULL,
    symbol VARCHAR(20),
    color VARCHAR(10),
    x INTEGER,
    y INTEGER,
    PRIMARY KEY (tile),
    FOREIGN KEY (symbol) REFERENCES symbol(symbol),
    FOREIGN KEY (color) REFERENCES color(color)
);

INSERT INTO tile(tile, image, north, east, south, west, color, x, y) VALUES ('red', '/images/tiles/red-80x80-final.png', 0, 1, 1, 0, 'RED', 0, 0);
INSERT INTO tile(tile, image, north, east, south, west, color, x, y) VALUES ('black', '/images/tiles/black-80x80-final.png', 0, 0, 1, 1, 'BLACK', 6, 0);
INSERT INTO tile(tile, image, north, east, south, west, color, x, y) VALUES ('white', '/images/tiles/white-80x80-final.png', 1, 1, 0, 0, 'WHITE', 0, 6);
INSERT INTO tile(tile, image, north, east, south, west, color, x, y) VALUES ('green', '/images/tiles/green-80x80-final.png', 1, 0, 0, 1, 'GREEN', 6, 6);
INSERT INTO tile(tile, image, north, east, south, west) VALUES ('corner00', '/images/tiles/corner-80x80-final.png', 0, 1, 1, 0);
INSERT INTO tile(tile, image, north, east, south, west) VALUES ('corner01', '/images/tiles/corner-80x80-final.png', 0, 1, 1, 0);
INSERT INTO tile(tile, image, north, east, south, west) VALUES ('corner02', '/images/tiles/corner-80x80-final.png', 0, 1, 1, 0);
INSERT INTO tile(tile, image, north, east, south, west) VALUES ('corner03', '/images/tiles/corner-80x80-final.png', 0, 1, 1, 0);
INSERT INTO tile(tile, image, north, east, south, west) VALUES ('corner04', '/images/tiles/corner-80x80-final.png', 0, 1, 1, 0);
INSERT INTO tile(tile, image, north, east, south, west) VALUES ('corner05', '/images/tiles/corner-80x80-final.png', 0, 1, 1, 0);
INSERT INTO tile(tile, image, north, east, south, west) VALUES ('corner06', '/images/tiles/corner-80x80-final.png', 0, 1, 1, 0);
INSERT INTO tile(tile, image, north, east, south, west) VALUES ('corner07', '/images/tiles/corner-80x80-final.png', 0, 1, 1, 0);
INSERT INTO tile(tile, image, north, east, south, west) VALUES ('corner08', '/images/tiles/corner-80x80-final.png', 0, 1, 1, 0);
INSERT INTO tile(tile, image, north, east, south, west) VALUES ('corner09', '/images/tiles/corner-80x80-final.png', 0, 1, 1, 0);
INSERT INTO tile(tile, image, north, east, south, west) VALUES ('straight00', '/images/tiles/straight-80x80-final.png', 1, 0, 1, 0);
INSERT INTO tile(tile, image, north, east, south, west) VALUES ('straight01', '/images/tiles/straight-80x80-final.png', 1, 0, 1, 0);
INSERT INTO tile(tile, image, north, east, south, west) VALUES ('straight02', '/images/tiles/straight-80x80-final.png', 1, 0, 1, 0);
INSERT INTO tile(tile, image, north, east, south, west) VALUES ('straight03', '/images/tiles/straight-80x80-final.png', 1, 0, 1, 0);
INSERT INTO tile(tile, image, north, east, south, west) VALUES ('straight04', '/images/tiles/straight-80x80-final.png', 1, 0, 1, 0);
INSERT INTO tile(tile, image, north, east, south, west) VALUES ('straight05', '/images/tiles/straight-80x80-final.png', 1, 0, 1, 0);
INSERT INTO tile(tile, image, north, east, south, west) VALUES ('straight06', '/images/tiles/straight-80x80-final.png', 1, 0, 1, 0);
INSERT INTO tile(tile, image, north, east, south, west) VALUES ('straight07', '/images/tiles/straight-80x80-final.png', 1, 0, 1, 0);
INSERT INTO tile(tile, image, north, east, south, west) VALUES ('straight08', '/images/tiles/straight-80x80-final.png', 1, 0, 1, 0);
INSERT INTO tile(tile, image, north, east, south, west) VALUES ('straight09', '/images/tiles/straight-80x80-final.png', 1, 0, 1, 0);
INSERT INTO tile(tile, image, north, east, south, west) VALUES ('straight10', '/images/tiles/straight-80x80-final.png', 1, 0, 1, 0);
INSERT INTO tile(tile, image, north, east, south, west) VALUES ('straight11', '/images/tiles/straight-80x80-final.png', 1, 0, 1, 0);
INSERT INTO tile(tile, image, north, east, south, west, symbol, x, y) VALUES ('skull', '/images/tiles/skull-80x80-final.png', 0, 1, 1, 1, 'SKULL', 2, 0);
INSERT INTO tile(tile, image, north, east, south, west, symbol, x, y) VALUES ('sword', '/images/tiles/sword-80x80-final.png', 0, 1, 1, 1, 'SWORD', 4, 0);
INSERT INTO tile(tile, image, north, east, south, west, symbol, x, y) VALUES ('bag of gold', '/images/tiles/bag-of-gold-80x80-final.png', 1, 1, 1, 0, 'BAG_OF_GOLD', 0 ,2);
INSERT INTO tile(tile, image, north, east, south, west, symbol, x, y) VALUES ('keychain', '/images/tiles/keychain-80x80-final.png', 1, 1, 1, 0, 'KEYCHAIN', 2, 2);
INSERT INTO tile(tile, image, north, east, south, west, symbol, x, y) VALUES ('diamond', '/images/tiles/diamond-80x80-final.png', 0, 1, 1, 1, 'DIAMOND', 4, 2);
INSERT INTO tile(tile, image, north, east, south, west, symbol, x, y) VALUES ('helmet', '/images/tiles/helmet-80x80-final.png', 1, 0, 1, 1, 'HELMET', 6, 2);
INSERT INTO tile(tile, image, north, east, south, west, symbol, x, y) VALUES ('book', '/images/tiles/book-80x80-final.png', 1, 1, 1, 0, 'BOOK', 0, 4);
INSERT INTO tile(tile, image, north, east, south, west, symbol, x, y) VALUES ('crown', '/images/tiles/crown-80x80-final.png', 1, 1, 0, 1, 'CROWN', 2, 4);
INSERT INTO tile(tile, image, north, east, south, west, symbol, x, y) VALUES ('chest', '/images/tiles/chest-80x80-final.png', 1, 0, 1, 1, 'CHEST', 4, 4);
INSERT INTO tile(tile, image, north, east, south, west, symbol, x, y) VALUES ('candle holder', '/images/tiles/candle-holder-80x80-final.png', 1, 0, 1, 1, 'CANDLE_HOLDER', 6, 4);
INSERT INTO tile(tile, image, north, east, south, west, symbol, x, y) VALUES ('map', '/images/tiles/map-80x80-final.png', 1, 1, 0, 1, 'MAP', 2, 6);
INSERT INTO tile(tile, image, north, east, south, west, symbol, x, y) VALUES ('ring', '/images/tiles/ring-80x80-final.png', 1, 1, 0, 1, 'RING', 4, 6);
INSERT INTO tile(tile, image, north, east, south, west, symbol) VALUES ('salamander', '/images/tiles/salamander-80x80-final.png', 0, 1, 1, 0, 'SALAMANDER');
INSERT INTO tile(tile, image, north, east, south, west, symbol) VALUES ('mouse', '/images/tiles/mouse-80x80-final.png', 0, 1, 1, 0, 'MOUSE');
INSERT INTO tile(tile, image, north, east, south, west, symbol) VALUES ('owl', '/images/tiles/owl-80x80-final.png', 0, 1, 1, 0, 'OWL');
INSERT INTO tile(tile, image, north, east, south, west, symbol) VALUES ('scarab', '/images/tiles/scarab-80x80-final.png', 0, 1, 1, 0, 'SCARAB');
INSERT INTO tile(tile, image, north, east, south, west, symbol) VALUES ('skull moth', '/images/tiles/skull-moth-80x80-final.png', 0, 1, 1, 0, 'SKULL_MOTH');
INSERT INTO tile(tile, image, north, east, south, west, symbol) VALUES ('spider', '/images/tiles/spider-80x80-final.png', 0, 1, 1, 0, 'SPIDER');
INSERT INTO tile(tile, image, north, east, south, west, symbol) VALUES ('dragon', '/images/tiles/dragon-80x80-final.png', 1, 1, 0, 1, 'DRAGON');
INSERT INTO tile(tile, image, north, east, south, west, symbol) VALUES ('ghost', '/images/tiles/ghost-80x80-final.png', 1, 1, 0, 1, 'GHOST');
INSERT INTO tile(tile, image, north, east, south, west, symbol) VALUES ('bat', '/images/tiles/bat-80x80-final.png', 1, 1, 0, 1, 'BAT');
INSERT INTO tile(tile, image, north, east, south, west, symbol) VALUES ('hobbit', '/images/tiles/hobbit-80x80-final.png', 1, 1, 0, 1, 'HOBBIT');
INSERT INTO tile(tile, image, north, east, south, west, symbol) VALUES ('fairy', '/images/tiles/fairy-80x80-final.png', 1, 1, 0, 1, 'FAIRY');
INSERT INTO tile(tile, image, north, east, south, west, symbol) VALUES ('genie', '/images/tiles/genie-80x80-final.png', 1, 1, 0, 1, 'GENIE');

CREATE TABLE game_status (
    status VARCHAR(20) NOT NULL,
    PRIMARY KEY (status)
);

INSERT INTO game_status(status) VALUES ('WAITING');
INSERT INTO game_status(status) VALUES ('PLAYING');
INSERT INTO game_status(status) VALUES ('ENDED');

CREATE TABLE game (
    game_id VARCHAR(40) NOT NULL,
    status VARCHAR(20) NOT NULL,
    active_player VARCHAR(40),
    phase VARCHAR(20),
    last_direction VARCHAR(10),
    last_line INTEGER,
    PRIMARY KEY (game_id),
    FOREIGN KEY (status) REFERENCES game_status(status)
);

CREATE TABLE game_tile(
    game_id VARCHAR(40) NOT NULL,
    tile VARCHAR(40) NOT NULL,
    x INTEGER,
    y INTEGER,
    rotation INTEGER NOT NULL,
    PRIMARY KEY (game_id, tile),
    FOREIGN KEY (game_id) REFERENCES game(game_id),
    FOREIGN KEY (tile) REFERENCES tile(tile)
);

CREATE TABLE player (
	player_id VARCHAR(40) NOT NULL,
	username VARCHAR(80) NOT NULL,
	color VARCHAR(10) NOT NULL,
	game_id VARCHAR(40) NOT NULL,
	x INTEGER NOT NULL,
	y INTEGER NOT NULL,
	PRIMARY KEY (player_id),
	FOREIGN KEY (color) REFERENCES color(color),
	FOREIGN KEY (game_id) REFERENCES game(game_id)
);

CREATE TABLE card_status (
    status VARCHAR(20) NOT NULL,
    PRIMARY KEY (status)
);

INSERT INTO card_status (status) VALUES ('HIDDEN');
INSERT INTO card_status (status) VALUES ('OPEN');
INSERT INTO card_status (status) VALUES ('SOLVED');

CREATE TABLE player_card (
    player_id VARCHAR(40) NOT NULL,
    symbol VARCHAR(20) NOT NULL,
    status VARCHAR(20) NOT NULL,
    PRIMARY KEY (player_id, symbol),
    FOREIGN KEY (player_id) REFERENCES player(player_id),
    FOREIGN KEY (symbol) REFERENCES card(symbol),
    FOREIGN KEY (status) REFERENCES card_status(status)
);
