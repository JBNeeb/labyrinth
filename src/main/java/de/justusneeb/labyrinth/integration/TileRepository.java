package de.justusneeb.labyrinth.entity;

import org.springframework.data.repository.ListCrudRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface TileRepository extends ListCrudRepository<Tile, String> {
    Optional<Tile> findByColor(String color);
}
