package com.vku.javaweb.service;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.vku.javaweb.model.BlindBox;
import com.vku.javaweb.repository.BlindBoxRepository;

@Service
public class BlindBoxService {

    @Autowired
    private BlindBoxRepository blindBoxRepository;

    public List<BlindBox> getAllBlindBoxes() {
        return blindBoxRepository.findAll();
    }

    public Optional<BlindBox> getBlindBoxById(Long id) {
        return blindBoxRepository.findById(id);
    }

    public BlindBox saveBlindBox(BlindBox blindBox) {
        return blindBoxRepository.save(blindBox);
    }

    public void deleteBlindBox(Long id) {
        blindBoxRepository.deleteById(id);
    }
}