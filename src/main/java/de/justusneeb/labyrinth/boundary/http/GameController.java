package de.justusneeb.labyrinth.boundary.http;

import de.justusneeb.labyrinth.control.GameService;
import de.justusneeb.labyrinth.entity.Game;
import de.justusneeb.labyrinth.entity.Player;
import de.justusneeb.labyrinth.entity.PlayerColor;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;

import java.util.ArrayList;
import java.util.List;

@Controller
@RequiredArgsConstructor
public class GameController {
    private final GameService gameService;

    @GetMapping("/")
    public String homePage(Model model) {
        return "home";
    }

    @GetMapping("/create-match")
    public String createMatchGet(Model model) {
        return createMatch(null, model);
    }

    @PostMapping("/create-match")
    public String createMatch(@ModelAttribute Player player, Model model) {
        List<String> errors = new ArrayList<>();
        if (player == null) {
            player = new Player();
        } else {
            if ("".equals(player.getUsername()) || player.getUsername() == null) {
                errors.add("Benutzername ist ein Pflichtfeld");
            }
            if ("".equals(player.getColor()) || player.getColor() == null) {
                errors.add("Farbe muss ausgewählt werden");
            }
            if (errors.isEmpty()) {
                Game game = gameService.createGame();
                player = gameService.createPlayer(player.getUsername(), player.getColor(), game.getGameId());
                return "creator-waiting";
            }
        }
        model.addAttribute("colors", PlayerColor.values());
        model.addAttribute("player", player);
        model.addAttribute("errors", errors);
        return "create-match";
    }
}
