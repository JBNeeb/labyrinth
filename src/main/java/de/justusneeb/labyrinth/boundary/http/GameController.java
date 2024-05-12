package de.justusneeb.labyrinth.boundary.http;

import de.justusneeb.labyrinth.control.GameService;
import de.justusneeb.labyrinth.entity.*;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;

@Controller
@RequiredArgsConstructor
public class GameController {
    private final GameService gameService;

    @GetMapping("/")
    public String homePage() {
        return "home";
    }

    @GetMapping("/create-match")
    public String createMatchGet(Model model) {
        return createMatch(null, model);
    }

    @PostMapping("/create-match")
    public String createMatch(@ModelAttribute Player player, Model model) {
        List<String> errors;
        if (player == null) {
            player = new Player();
            errors = new ArrayList<>();
        } else {
            errors = validatePlayer(player);
            if (errors.isEmpty()) {
                Game game = gameService.createGame();
                player = gameService.createPlayer(player.getUsername(), player.getColor(), game.getGameId());
                return creatorWaiting(player.getPlayerId(), model);
            }
        }
        model.addAttribute("colors", PlayerColor.values());
        model.addAttribute("player", player);
        model.addAttribute("errors", errors);
        return "create-match";
    }

    @GetMapping("/creator-waiting")
    public String creatorWaiting(@RequestParam("playerId") String playerId, Model model) {
        Player player = gameService.retrievePlayer(playerId);
        model.addAttribute("player", player);
        model.addAttribute("players", gameService.retrievePlayers(player.getGameId()));
        model.addAttribute("colors", PlayerColor.values());
        return "creator-waiting";
    }

    @GetMapping("/join-match")
    public String joinMatchGet(@RequestParam("gameId") String gameId, Model model) {
        Player player = new Player();
        player.setGameId(gameId);
        return joinMatch(player, model, true);
    }

    @PostMapping("/join-match")
    public String joinMatchPost(@ModelAttribute Player player, Model model) {
        return joinMatch(player, model, false);
    }

    public String joinMatch(Player player, Model model, boolean initial) {
        List<String> errors;
        if (!initial) {
            errors = validatePlayer(player);
            if (errors.isEmpty()) {
                player = gameService.createPlayer(player.getUsername(), player.getColor(), player.getGameId());
                return playerWaitingGet(player.getPlayerId(), model);
            }
        } else {
            errors = new ArrayList<>();
        }

        model.addAttribute("colors", PlayerColor.values());
        model.addAttribute("player", player);
        model.addAttribute("players", gameService.retrievePlayers(player.getGameId()));
        model.addAttribute("errors", errors);
        model.addAttribute("tool", new ExpressionTool());
        return "join-match";
    }

    @GetMapping("/player-waiting")
    public String playerWaitingGet(@RequestParam("playerId") String playerId, Model model) {
        Player player = gameService.retrievePlayer(playerId);
        model.addAttribute("player", player);
        model.addAttribute("players", gameService.retrievePlayers(player.getGameId()));
        model.addAttribute("colors", PlayerColor.values());
        return "player-waiting";
    }

    @GetMapping("/start")
    public String start(@RequestParam("playerId") String playerId, Model model) {
        Player player = gameService.retrievePlayer(playerId);
        Board board = gameService.startGame(player.getGameId());
        board.setActual(player);
        model.addAttribute("board", board);
        return "board";
    }

    @GetMapping("/rotate/{rotation}")
    public String rotation(@PathVariable Integer rotation, @RequestParam("playerId") String playerId, Model model) {
        Board board = gameService.rotateFreePlate(playerId, rotation);
        model.addAttribute("board", board);
        return "board";
    }

    private List<String> validatePlayer(Player player) {
        List<String> errors = new ArrayList<>();
        if ("".equals(player.getUsername()) || player.getUsername() == null) {
            errors.add("Benutzername ist ein Pflichtfeld");
        }
        if ("".equals(player.getColor()) || player.getColor() == null) {
            errors.add("Farbe muss ausgewählt werden");
        }
        return errors;
    }
}
