package de.justusneeb.labyrinth.control;

import de.justusneeb.labyrinth.entity.*;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.*;

@Service
@RequiredArgsConstructor
public class GameService {
    private static final Random RANDOM = new Random();

    private final GameRepository gameRepository;

    private final PlayerRepository playerRepository;

    private final TileRepository tileRepository;

    private final GameTileRepository gameTileRepository;

    public Game createGame() {
        Game game = new Game();
        game.setGameId(UUID.randomUUID().toString());
        game.setStatus(GameStatus.WAITING.name());
        return gameRepository.save(game);
    }

    public Player createPlayer(String username, String color, String gameId) {
        Player player = new Player();
        player.setPlayerId(UUID.randomUUID().toString());
        player.setUsername(username);
        player.setColor(color);
        if ("BLACK".equals(player.getColor())) {
            player.setX(6);
            player.setY(0);
        } else if ("RED".equals(player.getColor())) {
            player.setX(0);
            player.setY(0);
        } else if ("GREEN".equals(player.getColor())) {
            player.setX(6);
            player.setY(6);
        } else if ("WHITE".equals(player.getColor())) {
            player.setX(0);
            player.setY(6);
        }
        player.setGameId(gameId);
        return playerRepository.save(player);
    }

    public Player retrievePlayer(String playerId) {
        return playerRepository.findById(playerId).orElseThrow(() -> new IllegalStateException(playerId));
    }

    public List<Player> retrievePlayers(String gameId) {
        return playerRepository.findByGameId(gameId);
    }

    public Game retrieveGame(String gameId) {
        return gameRepository.findById(gameId).orElseThrow(() -> new IllegalStateException(gameId));
    }

    public Board startGame(String playerId) {
        Player player = retrievePlayer(playerId);
        Game game = retrieveGame(player.getGameId());
        if (!game.getStatus().equals(GameStatus.WAITING.name())) {
            return loadBoard(playerId);
        }
        Map<String, PlacedTile> map = retrievePlacedTiles();
        Board board = createStaticBoard(map);
        placeDynamicTiles(new ArrayList<>(map.values()), board);
        board.setGameId(player.getGameId());
        board.setActual(player);
//        board.setActual(board.getPlayers().get(RANDOM.nextInt(board.getPlayers().size())));
        board.setPlayers(retrievePlayers(player.getGameId()));
        board.setOwnDraw(playerId.equals(board.getActual().getPlayerId()));
        board.setStatus(GameStatus.PLAYING.name());
        board.setPhase(GamePhase.SHIFT.name());
        saveBoard(board);
        return board;
    }

    private void saveBoard(Board board) {
        unmarkReachable(board);
        markReachable(board);
        List<GameTile> list = new ArrayList<>();
        for (int x = 0; x < board.getTiles().length; x++) {
            for (int y = 0; y < board.getTiles()[x].length; y++) {
                PlacedTile pt = board.getTiles()[x][y];
                GameTile gameTile = new GameTile();
                gameTile.setTile(pt.getTile());
                gameTile.setGameId(board.getGameId());
                gameTile.setX(x);
                gameTile.setY(y);
                gameTile.setRotation(pt.getRotation());
                list.add(gameTile);
            }
        }
        GameTile gameTile = new GameTile();
        gameTile.setTile(board.getFreeTile().getTile());
        gameTile.setGameId(board.getGameId());
        gameTile.setX(null);
        gameTile.setY(null);
        gameTile.setRotation(board.getFreeTile().getRotation());
        list.add(gameTile);
        gameTileRepository.saveAll(list);
        Game game = new Game();
        game.setGameId(board.getGameId());
        game.setStatus(board.getStatus());
        game.setActivePlayer(board.getActual().getPlayerId());
        game.setPhase(board.getPhase());
        gameRepository.save(game);
        playerRepository.saveAll(board.getPlayers());
    }

    private void markReachable(Board board) {
        if (board.isOwnDraw() && GamePhase.valueOf(board.getPhase()) == GamePhase.MOVE) {
            markReachable(board.getActual().getX(), board.getActual().getY(), board.getTiles());
        }
    }

    private void unmarkReachable(Board board) {
        for (PlacedTile[] t2 : board.getTiles()) {
            for (PlacedTile t1 : t2) {
                t1.setReachable(false);
            }
        }
    }

    private void placeDynamicTiles(List<PlacedTile> list, Board board) {
        for (int i = 0; i < board.getTiles().length; i++) {
            for (int j = 0; j < board.getTiles()[i].length; j++) {
                if (board.getTiles()[i][j] == null) {
                    board.getTiles()[i][j] = list.remove(RANDOM.nextInt(list.size()));
                    rotate(board.getTiles()[i][j], RANDOM.nextInt(4) * 90);
                }
            }
        }
        board.setFreeTile(list.remove(0));
    }

    private void rotate(PlacedTile placedTile, int rotation) {
        rotation = (placedTile.getRotation() + rotation) % 360;
        placedTile.setRotation(rotation);
        for (int i = 0; i < rotation / 90; i++) {
            boolean temp = placedTile.isNorth();
            placedTile.setNorth(placedTile.isWest());
            placedTile.setWest(placedTile.isSouth());
            placedTile.setSouth(placedTile.isEast());
            placedTile.setEast(temp);
        }
    }

    private Board createStaticBoard(Map<String, PlacedTile> map) {
        Board board = new Board();
        board.setTiles(new PlacedTile[7][7]);
        board.getTiles()[0][0] = map.remove("red");
        board.getTiles()[0][2] = map.remove("skull");
        board.getTiles()[0][4] = map.remove("sword");
        board.getTiles()[0][6] = map.remove("black");
        board.getTiles()[2][0] = map.remove("bag of gold");
        board.getTiles()[2][2] = map.remove("keychain");
        board.getTiles()[2][4] = map.remove("diamond");
        board.getTiles()[2][6] = map.remove("helmet");
        board.getTiles()[4][0] = map.remove("book");
        board.getTiles()[4][2] = map.remove("crown");
        board.getTiles()[4][4] = map.remove("chest");
        board.getTiles()[4][6] = map.remove("candle holder");
        board.getTiles()[6][0] = map.remove("white");
        board.getTiles()[6][2] = map.remove("map");
        board.getTiles()[6][4] = map.remove("ring");
        board.getTiles()[6][6] = map.remove("green");
        return board;
    }

    private Map<String, PlacedTile> retrievePlacedTiles() {
        Map<String, PlacedTile> map = new HashMap<>();
        List<Tile> tiles = tileRepository.findAll();
        for (Tile t : tiles) {
            PlacedTile pt = new PlacedTile();
            pt.setTile(t.getTile());
            pt.setImage(t.getImage());
            pt.setRotation(0);
            pt.setNorth(t.getNorth() == 1);
            pt.setEast((t.getEast() == 1));
            pt.setSouth(t.getSouth() == 1);
            pt.setWest(t.getWest() == 1);
            map.put(t.getTile(), pt);
        }
        return map;
    }

    public Board rotateFreePlate(String playerId, int rotation) {
        Board board = loadBoard(playerId);
        rotate(board.getFreeTile(), rotation);
        saveBoard(board);
        return board;
    }

    public Board loadBoard(String playerId) {
        Player player = playerRepository.findById(playerId).orElseThrow(() -> new IllegalStateException(playerId));
        Game game = gameRepository.findById(player.getGameId()).orElseThrow(() -> new IllegalStateException(player.getGameId()));
        List<GameTile> gameTiles = gameTileRepository.findByGameId(game.getGameId());
        Map<String, PlacedTile> map = retrievePlacedTiles();

        Board board = new Board();
        board.setPlayerId(playerId);
        board.setGameId(game.getGameId());
        board.setPlayers(retrievePlayers(game.getGameId()));
        board.setActual(board.getPlayers().stream().filter(f -> f.getPlayerId().equals(game.getActivePlayer())).findAny().orElseThrow());
        board.setStatus(game.getStatus());
        board.setPhase(game.getPhase());
        board.setOwnDraw(playerId.equals(board.getActual().getPlayerId()));
        board.setTiles(new PlacedTile[7][7]);
        for (GameTile gt : gameTiles) {
            PlacedTile pt = map.get(gt.getTile());
            rotate(pt, gt.getRotation());
            if (gt.getX() != null && gt.getY() != null) {
                board.getTiles()[gt.getX()][gt.getY()] = pt;
            } else {
                board.setFreeTile(pt);
            }
        }
        markReachable(board);
        return board;
    }

    private void markReachable(int x, int y, PlacedTile[][] tiles) {
        PlacedTile pt = tiles[y][x];
        if (pt.isReachable()) {
            return;
        }
        pt.setReachable(true);
        if (pt.isNorth() && y > 0 && tiles[y - 1][x].isSouth()) {
            markReachable(x, y - 1, tiles);
        }
        if (pt.isWest() && x > 0 && tiles[y][x - 1].isEast()) {
            markReachable(x - 1, y, tiles);
        }
        if (pt.isSouth() && y < tiles.length - 1 && tiles[y + 1][x].isNorth()) {
            markReachable(x, y + 1, tiles);
        }
        if (pt.isEast() && x < tiles.length - 1 && tiles[y][x + 1].isWest()) {
            markReachable(x + 1, y, tiles);
        }
    }

    public Board shift(String playerId, String direction, Integer line) {
        Board board = loadBoard(playerId);
        if (!board.isOwnDraw() || GamePhase.valueOf(board.getPhase()) != GamePhase.SHIFT) {
            return board;
        }
        if ("down".equals(direction)) {
            PlacedTile temp = board.getTiles()[board.getTiles().length - 1][line];
            for (int i = board.getTiles().length - 1; i > 0; i--) {
                board.getTiles()[i][line] = board.getTiles()[i - 1][line];
            }
            board.getTiles()[0][line] = board.getFreeTile();
            board.setFreeTile(temp);
            for (Player pLayer : board.getPlayers()) {
                if (pLayer.getX() == line) {
                    pLayer.setY((pLayer.getY() + 1) % board.getTiles().length);
                }
            }
        } else if ("up".equals(direction)) {
            PlacedTile temp = board.getTiles()[0][line];
            for (int i = 0; i < board.getTiles().length - 1; i++) {
                board.getTiles()[i][line] = board.getTiles()[i + 1][line];
            }
            board.getTiles()[board.getTiles().length - 1][line] = board.getFreeTile();
            board.setFreeTile(temp);
            for (Player pLayer : board.getPlayers()) {
                if (pLayer.getX() == line) {
                    pLayer.setY((pLayer.getY() + board.getTiles().length - 1) % board.getTiles().length);
                }
            }
        } else if ("right".equals(direction)) {
            PlacedTile temp = board.getTiles()[line][board.getTiles().length - 1];
            for (int i = board.getTiles().length - 1; i > 0; i--) {
                board.getTiles()[line][i] = board.getTiles()[line][i - 1];
            }
            board.getTiles()[line][0] = board.getFreeTile();
            board.setFreeTile(temp);
            for (Player pLayer : board.getPlayers()) {
                if (pLayer.getY() == line) {
                    pLayer.setX((pLayer.getX() + 1) % board.getTiles().length);
                }
            }
        } else if ("left".equals(direction)) {
            PlacedTile temp = board.getTiles()[line][0];
            for (int i = 0; i < board.getTiles().length - 1; i++) {
                board.getTiles()[line][i] = board.getTiles()[line][i + 1];
            }
            board.getTiles()[line][board.getTiles().length - 1] = board.getFreeTile();
            board.setFreeTile(temp);
            for (Player pLayer : board.getPlayers()) {
                if (pLayer.getY() == line) {
                    pLayer.setX((pLayer.getX() + board.getTiles().length - 1) % board.getTiles().length);
                }
            }
        }
        board.setPhase(GamePhase.MOVE.name());
        saveBoard(board);
        return board;
    }

    public Board move(String playerId, int x, int y) {
        Board board = loadBoard(playerId);
        if (!board.isOwnDraw() || GamePhase.valueOf(board.getPhase()) != GamePhase.MOVE || !board.getTiles()[y][x].isReachable()) {
            return board;
        }
        board.getActual().setX(x);
        board.getActual().setY(y);
        int index = board.getPlayers().indexOf(board.getActual());
        index = (index + 1) % board.getPlayers().size();
        board.setActual(board.getPlayers().get(index));
        board.setPhase(GamePhase.SHIFT.name());
        board.setOwnDraw(false);
        saveBoard(board);
        return board;
    }
}
