package de.justusneeb.labyrinth.entity;

import org.springframework.data.repository.ListCrudRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface GameTileRepository extends ListCrudRepository<GameTile, GameTileId> {
    List<GameTile> findByGameId(String gameId);
}
