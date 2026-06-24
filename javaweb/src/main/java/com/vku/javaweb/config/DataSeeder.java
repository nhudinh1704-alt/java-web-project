package com.vku.javaweb.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.stereotype.Component;

import com.vku.javaweb.model.BlindBox;
import com.vku.javaweb.repository.BlindBoxRepository;

@Component
public class DataSeeder implements CommandLineRunner {

    @Autowired
    private BlindBoxRepository blindBoxRepository;

    @Override
    public void run(String... args) throws Exception {
        if (blindBoxRepository.count() == 0) {
            System.out.println("Dang khoi tao du lieu Hop mu vao CSDL...");

            blindBoxRepository.save(new BlindBox(
                    "Labubu Macaron Vinyl Face", "Pop Mart", 450000.0, 15, 
                    "Phiên bản mặt nhựa siêu hot hit.", 
                    "https://down-vn.img.susercontent.com/file/vn-11134207-7r98o-lty68yqy6m5i3a",
                    "Lychee Berry, Green Grape, Soymilk, Sea Salt, Toffee", "Chestnut Cocoa"
            ));

            blindBoxRepository.save(new BlindBox(
                    "Skullpanda Everyday Wonderland", "Pop Mart", 320000.0, 20, 
                    "Khám phá thế giới cổ tích nhiệm màu.", 
                    "https://down-vn.img.susercontent.com/file/vn-11134207-7r98o-ls8k5b4y2d9h9f",
                    "The Princess, The Knight, The Magician, The Fake King", "The Queen"
            ));
            
            System.out.println("Khoi tao du lieu thanh cong!");
        }
    }
}