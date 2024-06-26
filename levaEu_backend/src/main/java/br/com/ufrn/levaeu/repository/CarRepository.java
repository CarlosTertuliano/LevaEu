package br.com.ufrn.levaeu.repository;

import br.com.ufrn.levaeu.model.Car;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface CarRepository extends JpaRepository<Car, Long> {
    Optional<Car> findByPlate(String plate);
}
