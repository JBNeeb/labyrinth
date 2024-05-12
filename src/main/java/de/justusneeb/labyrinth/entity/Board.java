package de.justusneeb.labyrinth.entity;

import lombok.Getter;
import lombok.Setter;

import java.util.List;

@Getter
@Setter
public class Board {
    private String gameId;
    private PlacedTile[][] tiles;
    private PlacedTile freeTile;
    private Player actual;
    private List<Player> players;
}
