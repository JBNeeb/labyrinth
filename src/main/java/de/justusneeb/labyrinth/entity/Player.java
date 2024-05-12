package de.justusneeb.labyrinth.entity;

import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Entity
public class Player {
    @Id
    private String playerId;
    private String username;
    private String color;
    private String gameId;
}
