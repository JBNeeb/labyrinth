package de.justusneeb.labyrinth.integration;

import jakarta.persistence.Id;
import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.Setter;

import java.io.Serializable;

@Getter
@Setter
@EqualsAndHashCode
public class PlayerCardId implements Serializable {
    private String playerId;
    private String symbol;
}
