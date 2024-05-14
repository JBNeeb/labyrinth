package de.justusneeb.labyrinth.entity;

import org.springframework.data.repository.ListCrudRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface CardRepository extends ListCrudRepository<Card, String> {
}
