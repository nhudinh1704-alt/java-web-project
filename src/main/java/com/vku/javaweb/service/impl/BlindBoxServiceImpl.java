package com.vku.javaweb.service.impl;

import com.vku.javaweb.model.BlindBox;
import com.vku.javaweb.repository.BlindBoxRepository;
import com.vku.javaweb.service.BlindBoxService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class BlindBoxServiceImpl implements BlindBoxService {

    @Autowired
    private BlindBoxRepository blindBoxRepository;

    @Override
    public List<BlindBox> getAllBoxes() {
        return blindBoxRepository.findAll();
    }

    @Override
    public BlindBox getBoxById(Integer id) {
        return blindBoxRepository.findById(id).orElse(null);
    }

    @Override
    public void saveBox(BlindBox box) {
        blindBoxRepository.save(box);
    }

    @Override
    public void deleteBox(Integer id) {
        blindBoxRepository.deleteById(id);
    }
}