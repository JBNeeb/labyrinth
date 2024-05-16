package de.justusneeb.labyrinth.entity;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class PlacedTile {
    private String tile;
    private int rotation;
    private boolean north;
    private boolean east;
    private boolean south;
    private boolean west;
    private String image;
    private boolean reachable;
    private String symbol;
    private String color;
}
