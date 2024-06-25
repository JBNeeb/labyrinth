package de.justusneeb.labyrinth.integration;

import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.Setter;

import java.io.Serializable;

@Getter
@Setter
@EqualsAndHashCode
public class GameTileId implements Serializable {
    private String gameId;
    private String tile;
}
