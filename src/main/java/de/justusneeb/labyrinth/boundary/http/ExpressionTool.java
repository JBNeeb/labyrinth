package de.justusneeb.labyrinth.boundary.http;

import de.justusneeb.labyrinth.entity.Player;

import java.util.Arrays;

public class ExpressionTool {
    public boolean colorExists(Player[] players, String color) {
        return Arrays.stream(players).anyMatch(f -> color.equals(f.getColor()));
    }
}
