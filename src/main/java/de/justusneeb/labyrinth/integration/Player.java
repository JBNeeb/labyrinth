package de.justusneeb.labyrinth.integration;

import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Entity
@EqualsAndHashCode(of = {"playerId"})
public class Player {
    @Id
    private String playerId;
    private String username;
    private String color;
    private int x;
    private int y;
    private String gameId;
}
