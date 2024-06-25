package de.justusneeb.labyrinth.model;

import lombok.Getter;
import lombok.Setter;

import java.util.List;

@Getter
@Setter
public class Board {
    private String gameId;
    private PlacedTile[][] tiles;
    private PlacedTile freeTile;
    private String actual;
    private List<PlayerInfo> players;
    private String status;
    private String phase;
    private String playerId;
    private boolean ownDraw;
    private String lastDirection;
    private Integer lastLine;
}
