package de.justusneeb.labyrinth.boundary.http;

import de.justusneeb.labyrinth.client.boundary.DefaultApi;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class TestController implements DefaultApi {

    @Override
    public ResponseEntity<String> testGet() {
        return ResponseEntity.ok("Hello world");
    }
}
