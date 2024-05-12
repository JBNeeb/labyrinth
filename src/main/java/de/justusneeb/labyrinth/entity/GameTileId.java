package de.justusneeb.labyrinth.entity;

import lombok.Getter;
import lombok.Setter;

import java.io.Serializable;

@Getter
@Setter
public class GameTileId implements Serializable {
    private String gameId;
    private String tile;
}
