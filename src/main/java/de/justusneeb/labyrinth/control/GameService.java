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

    private final CardRepository cardRepository;

    private final PlayerCardRepository playerCardRepository;

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
        player.setGameId(gameId);
        Tile tile = tileRepository.findByColor(color).orElseThrow();
        player.setX(tile.getX());
        player.setY(tile.getY());
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
        Board board = placeTiles();
        board.setGameId(game.getGameId());
        board.setPlayerId(playerId);
        List<PlayerInfo> players = mapPlayers(game.getGameId());
        dealCards(players);
        for (PlayerInfo pi : players) {
            solveCard(pi);
        }
        board.setPlayers(players);
        board.setActual(playerId);
//        board.setActual(board.getPlayers().get(RANDOM.nextInt(board.getPlayers().size())));
        board.setOwnDraw(board.getActual().equals(playerId));
        board.setStatus(GameStatus.PLAYING.name());
        board.setPhase(GamePhase.SHIFT.name());
        saveBoard(board);
        return board;
    }

    private List<PlayerInfo> mapPlayers(String gameId) {
        List<PlayerInfo> players = new ArrayList<>();
        for (Player p : retrievePlayers(gameId)) {
            PlayerInfo pi = new PlayerInfo();
            pi.setPlayerId(p.getPlayerId());
            pi.setUsername(p.getUsername());
            pi.setX(p.getX());
            pi.setY(p.getY());
            pi.setColor(p.getColor());
            players.add(pi);
        }
        return players;
    }

    private void solveCard(PlayerInfo player) {
        List<PlayerCard> cards = playerCardRepository.findByPlayerId(player.getPlayerId());
        cards.stream().filter(f -> f.getStatus().equals(CardStatus.OPEN.name())).findAny()
                .ifPresent(playerCard -> playerCard.setStatus(CardStatus.SOLVED.name()));
        cards.stream().filter(f -> f.getStatus().equals(CardStatus.HIDDEN.name()))
                .findFirst().ifPresent(playerCard -> playerCard.setStatus(CardStatus.OPEN.name()));
        setCardStatus(cards, player);
        playerCardRepository.saveAll(cards);
    }

    private void setCardStatus(List<PlayerInfo> players) {
        for (PlayerInfo p : players) {
            setCardStatus(playerCardRepository.findByPlayerId(p.getPlayerId()), p);
        }
    }

    private void setCardStatus(List<PlayerCard> cards, PlayerInfo player) {
        Optional<PlayerCard> optional = cards.stream().filter(f -> f.getStatus().equals(CardStatus.OPEN.name())).findAny();
        if (optional.isPresent()) {
            player.setOpenCard(cardRepository.findById(optional.get().getSymbol()).orElseThrow());
        } else {
            player.setOpenCard(null);
        }
        player.setSolved(cards.stream().filter(f -> f.getStatus().equals(CardStatus.SOLVED.name())).count());
        player.setHidden(cards.stream().filter(f -> f.getStatus().equals(CardStatus.HIDDEN.name())).count());
    }

    private void dealCards(List<PlayerInfo> players) {
        List<PlayerCard> pcs = new ArrayList<>();
        List<String> cards = new ArrayList<>(Arrays.stream(Symbol.values()).map(Enum::name).toList());
        while (!cards.isEmpty()) {
            for (PlayerInfo p : players) {
                String card = cards.remove(RANDOM.nextInt(cards.size()));
                PlayerCard pc = new PlayerCard();
                pc.setSymbol(card);
                pc.setStatus(CardStatus.HIDDEN.name());
                pc.setPlayerId(p.getPlayerId());
                pcs.add(pc);
            }
        }
        playerCardRepository.saveAll(pcs);
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
        game.setActivePlayer(board.getActual());
        game.setPhase(board.getPhase());
        gameRepository.save(game);
        List<Player> players = new ArrayList<>();
        for (PlayerInfo pi : board.getPlayers()) {
            Player p = new Player();
            p.setPlayerId(pi.getPlayerId());
            p.setGameId(board.getGameId());
            p.setUsername(pi.getUsername());
            p.setX(pi.getX());
            p.setY(pi.getY());
            p.setColor(pi.getColor());
            players.add(p);
        }
        playerRepository.saveAll(players);
    }

    private void markReachable(Board board) {
        if (board.isOwnDraw() && GamePhase.valueOf(board.getPhase()) == GamePhase.MOVE) {
            PlayerInfo pi = board.getPlayers().stream().filter(f -> f.getPlayerId().equals(board.getActual())).findAny().orElseThrow();
            markReachable(pi.getX(), pi.getY(), board.getTiles());
        }
    }

    private void unmarkReachable(Board board) {
        for (PlacedTile[] t2 : board.getTiles()) {
            for (PlacedTile t1 : t2) {
                t1.setReachable(false);
            }
        }
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

    private Map<String, PlacedTile> retrievePlacedTiles() {
        Map<String, PlacedTile> map = new HashMap<>();
        List<Tile> tiles = tileRepository.findAll();
        for (Tile t : tiles) {
            PlacedTile pt = map(t);
            map.put(pt.getTile(), pt);
        }
        return map;
    }

    private Board placeTiles() {
        Board board = new Board();
        board.setTiles(new PlacedTile[7][7]);
        List<Tile> tiles = tileRepository.findAll();
        List<PlacedTile> freeTiles = new ArrayList<>();
        for (Tile t : tiles) {
            PlacedTile pt = map(t);
            if (t.getX() != null && t.getY() != null) {
                board.getTiles()[t.getY()][t.getX()] = pt;
            } else {
                freeTiles.add(pt);
            }
        }
        for (int i = 0; i < board.getTiles().length; i++) {
            for (int j = 0; j < board.getTiles()[i].length; j++) {
                if (board.getTiles()[i][j] == null) {
                    board.getTiles()[i][j] = freeTiles.remove(RANDOM.nextInt(freeTiles.size()));
                    rotate(board.getTiles()[i][j], RANDOM.nextInt(4) * 90);
                }
            }
        }
        board.setFreeTile(freeTiles.remove(0));
        return board;
    }

    private PlacedTile map(Tile t) {
        PlacedTile pt = new PlacedTile();
        pt.setTile(t.getTile());
        pt.setImage(t.getImage());
        pt.setRotation(0);
        pt.setNorth(t.getNorth() == 1);
        pt.setEast((t.getEast() == 1));
        pt.setSouth(t.getSouth() == 1);
        pt.setWest(t.getWest() == 1);
        pt.setSymbol(t.getSymbol());
        pt.setColor(t.getColor());
        return pt;
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
        board.setPlayers(mapPlayers(game.getGameId()));
        board.setActual(game.getActivePlayer());
        board.setStatus(game.getStatus());
        board.setPhase(game.getPhase());
        board.setOwnDraw(board.getActual().equals(playerId));
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
        setCardStatus(board.getPlayers());
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
            shiftDown(line, board);
        } else if ("up".equals(direction)) {
            shiftUp(line, board);
        } else if ("right".equals(direction)) {
            shiftRight(line, board);
        } else if ("left".equals(direction)) {
            shiftLeft(line, board);
        }
        board.setPhase(GamePhase.MOVE.name());
        saveBoard(board);
        return board;
    }

    private void shiftLeft(Integer line, Board board) {
        PlacedTile temp = board.getTiles()[line][0];
        for (int i = 0; i < board.getTiles().length - 1; i++) {
            board.getTiles()[line][i] = board.getTiles()[line][i + 1];
        }
        board.getTiles()[line][board.getTiles().length - 1] = board.getFreeTile();
        board.setFreeTile(temp);
        for (PlayerInfo pLayer : board.getPlayers()) {
            if (pLayer.getY() == line) {
                pLayer.setX((pLayer.getX() + board.getTiles().length - 1) % board.getTiles().length);
            }
        }
    }

    private void shiftRight(Integer line, Board board) {
        PlacedTile temp = board.getTiles()[line][board.getTiles().length - 1];
        for (int i = board.getTiles().length - 1; i > 0; i--) {
            board.getTiles()[line][i] = board.getTiles()[line][i - 1];
        }
        board.getTiles()[line][0] = board.getFreeTile();
        board.setFreeTile(temp);
        for (PlayerInfo pLayer : board.getPlayers()) {
            if (pLayer.getY() == line) {
                pLayer.setX((pLayer.getX() + 1) % board.getTiles().length);
            }
        }
    }

    private void shiftUp(Integer line, Board board) {
        PlacedTile temp = board.getTiles()[0][line];
        for (int i = 0; i < board.getTiles().length - 1; i++) {
            board.getTiles()[i][line] = board.getTiles()[i + 1][line];
        }
        board.getTiles()[board.getTiles().length - 1][line] = board.getFreeTile();
        board.setFreeTile(temp);
        for (PlayerInfo pLayer : board.getPlayers()) {
            if (pLayer.getX() == line) {
                pLayer.setY((pLayer.getY() + board.getTiles().length - 1) % board.getTiles().length);
            }
        }
    }

    private void shiftDown(Integer line, Board board) {
        PlacedTile temp = board.getTiles()[board.getTiles().length - 1][line];
        for (int i = board.getTiles().length - 1; i > 0; i--) {
            board.getTiles()[i][line] = board.getTiles()[i - 1][line];
        }
        board.getTiles()[0][line] = board.getFreeTile();
        board.setFreeTile(temp);
        for (PlayerInfo pLayer : board.getPlayers()) {
            if (pLayer.getX() == line) {
                pLayer.setY((pLayer.getY() + 1) % board.getTiles().length);
            }
        }
    }

    public Board move(String playerId, int x, int y) {
        Board board = loadBoard(playerId);
        if (!board.isOwnDraw() || GamePhase.valueOf(board.getPhase()) != GamePhase.MOVE || !board.getTiles()[y][x].isReachable()) {
            return board;
        }
        PlayerInfo pi = board.getPlayers().stream().filter(f -> f.getPlayerId().equals(playerId)).findAny().orElseThrow();
        pi.setX(x);
        pi.setY(y);
        PlacedTile tile = board.getTiles()[y][x];
        if (pi.getOpenCard() != null && pi.getOpenCard().getSymbol().equals(tile.getSymbol())) {
            solveCard(pi);
        }
        if (pi.getHidden() == 0 && pi.getColor().equals(tile.getColor())) {
            board.setStatus(GameStatus.ENDED.name());
        } else {
            int index = board.getPlayers().indexOf(pi);
            index = (index + 1) % board.getPlayers().size();
            board.setActual(board.getPlayers().get(index).getPlayerId());
            board.setPhase(GamePhase.SHIFT.name());
            board.setOwnDraw(false);
        }
        saveBoard(board);
        return board;
    }
}
