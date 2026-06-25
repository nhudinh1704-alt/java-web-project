package com.vku.javaweb.service.impl;

import com.vku.javaweb.model.BlindBox;
import com.vku.javaweb.repository.BlindBoxRepository;
import com.vku.javaweb.service.GachaService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Random;

@Service
public class GachaServiceImpl implements GachaService {

    @Autowired
    private BlindBoxRepository blindBoxRepository;

    @Override
    public BlindBox drawItem(Long boxId) {
        List<BlindBox> allBoxes = blindBoxRepository.findAll();
        if (allBoxes.isEmpty()) {
            return null;
        }
        // Logic chọn ngẫu nhiên hòm đồ cơ bản
        Random rand = new Random();
        return allBoxes.get(rand.nextInt(allBoxes.size()));
    }
}