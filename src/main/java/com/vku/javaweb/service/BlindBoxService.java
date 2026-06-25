package com.vku.javaweb.service;

import com.vku.javaweb.model.BlindBox;
import java.util.List;

public interface BlindBoxService {
    List<BlindBox> getAllBoxes();
    BlindBox getBoxById(Integer id);
    void saveBox(BlindBox box);
    void deleteBox(Integer id);
}