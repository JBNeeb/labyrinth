package de.justusneeb.labyrinth.entity;

import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Entity
public class Tile {
    @Id
    private String tile;
    private String image;
    private int north;
    private int east;
    private int south;
    private int west;
    private String symbol;
}
