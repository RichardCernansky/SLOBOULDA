package com.example.demo.repository;

import com.example.demo.model.Boulder;
import org.springframework.data.jpa.repository.JpaRepository;

public interface BoulderRepository extends JpaRepository<Boulder, Long> {
    //all crud database methods

}
