package de.justusneeb.labyrinth.entity;

import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.IdClass;
import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Entity
@IdClass(PlayerCardId.class)
@EqualsAndHashCode(of = {"playerId", "symbol"})
public class PlayerCard {
    @Id
    private String playerId;
    @Id
    private String symbol;
    private String status;
}
