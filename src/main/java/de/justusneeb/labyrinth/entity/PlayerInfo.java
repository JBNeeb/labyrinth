package de.justusneeb.labyrinth.entity;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class PlayerInfo {
    private String playerId;
    private String username;
    private String color;
    private int x;
    private int y;
    private Card openCard;
    private long solved;
    private long hidden;
}
