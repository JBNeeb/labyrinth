package de.justusneeb.labyrinth.control;

import de.justusneeb.labyrinth.entity.Game;
import de.justusneeb.labyrinth.entity.GameRepository;
import de.justusneeb.labyrinth.entity.Player;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.UUID;

@Service
@RequiredArgsConstructor
public class GameService {
    private GameRepository gameRepository;
    public Game createGame() {
        Game game = new Game();
        game.setGameId(UUID.randomUUID().toString());
        return gameRepository.save(game);
    }

    public Player createPlayer(String username, String color, String gameId) {
        Player player = new Player();
        player.setPlayerId(UUID.randomUUID().toString());
        player.setUsername(username);
        player.setColor(color);
        player.setGameId(gameId);
        return null;
    }
}
