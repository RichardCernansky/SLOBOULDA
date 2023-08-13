package com.example.demo.controller;


import com.example.demo.model.Boulder;
import com.example.demo.repository.BoulderRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/api/v1/boulders")
public class BoulderController {

    @Autowired
    private BoulderRepository boulderRepository;

    @GetMapping
    public List<Boulder> getAllBoulders(){
        return boulderRepository.findAll();
    }
}
