package de.justusneeb.labyrinth.integration;

import org.springframework.data.repository.ListCrudRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface CardRepository extends ListCrudRepository<Card, String> {
}
