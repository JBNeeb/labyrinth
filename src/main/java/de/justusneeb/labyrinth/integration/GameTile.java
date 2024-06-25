package de.justusneeb.labyrinth.integration;

import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.IdClass;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Entity
@IdClass(GameTileId.class)
public class GameTile {
    @Id
    private String gameId;
    @Id
    private String tile;
    private Integer x;
    private Integer y;
    private Integer rotation;
}
