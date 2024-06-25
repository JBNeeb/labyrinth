package de.justusneeb.labyrinth.integration;

import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import lombok.Getter;
import lombok.Setter;

@Entity
@Getter
@Setter
public class Game {
    @Id
    private String gameId;
    private String status;
    private String activePlayer;
    private String phase;
    private String lastDirection;
    private Integer lastLine;
}
