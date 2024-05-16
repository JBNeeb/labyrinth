package de.justusneeb.labyrinth.entity;

import org.springframework.data.repository.ListCrudRepository;

import java.util.List;

public interface PlayerCardRepository extends ListCrudRepository<PlayerCard, PlayerCardId> {
    List<PlayerCard> findByPlayerId(String playerId);
}
