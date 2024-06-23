package de.justusneeb.labyrinth.entity;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface PlayerRepository extends CrudRepository<Player, String> {
    List<Player> findByGameId(String gameId);
}
