package com.vku.javaweb.controller;

import java.util.Arrays;
import java.util.List;
import java.util.Optional;
import java.util.Random;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.vku.javaweb.model.BlindBox;
import com.vku.javaweb.repository.BlindBoxRepository;
import com.vku.javaweb.service.BlindBoxService;

@Controller
@RequestMapping("/blindbox")
public class BlindBoxController {

    @Autowired
    private BlindBoxService blindBoxService;

    @Autowired
    private BlindBoxRepository blindBoxRepository; 

    @GetMapping("/list")
    public String showBlindBoxList(Model model) {
        model.addAttribute("blindBoxes", blindBoxService.getAllBlindBoxes());
        return "blindbox/list";
    }

    // Cơ chế mở hộp Động hoàn toàn dựa vào danh sách người dùng tự nhập
    @GetMapping("/open/{id}")
    public String openBox(@PathVariable Long id, Model model) {
        Optional<BlindBox> boxOpt = blindBoxService.getBlindBoxById(id);
        if (boxOpt.isEmpty()) return "redirect:/blindbox/list";

        BlindBox box = boxOpt.get();
        if (box.getStock() > 0) {
            box.setStock(box.getStock() - 1);
            blindBoxService.saveBlindBox(box);
        } else {
            return "redirect:/blindbox/list";
        }

        // TỰ ĐỘNG TÁCH CHUỖI THÀNH DANH SÁCH NHÂN VẬT
        // Ví dụ: "Con Gấu, Con Thỏ" -> ["Con Gấu", "Con Thỏ"]
        List<String> normalCharacters = Arrays.asList(box.getCharacterList().split(","));
        String secretCharacter = "✨ SECRET: " + box.getSecretCharacter() + " ✨";
        
        Random rand = new Random();
        // Tỷ lệ 10% ra con Secret hiếm, 90% ra nhân vật thường trong list
        String resultCharacter = rand.nextInt(100) < 10 ? secretCharacter : normalCharacters.get(rand.nextInt(normalCharacters.size())).trim();

        model.addAttribute("box", box);
        model.addAttribute("character", resultCharacter);
        return "blindbox/open";
    }

    @GetMapping("/add")
    public String showAddForm() {
        return "blindbox/add";
    }

    @PostMapping("/add")
    public String addBlindBox(@RequestParam String name, @RequestParam String brand,
                              @RequestParam Double price, @RequestParam Integer stock,
                              @RequestParam String description, @RequestParam String imageUrl,
                              @RequestParam String characterList, @RequestParam String secretCharacter) {
        BlindBox newBox = new BlindBox(name, brand, price, stock, description, imageUrl, characterList, secretCharacter);
        blindBoxRepository.save(newBox); 
        return "redirect:/blindbox/list"; 
    }

    @GetMapping("/delete/{id}")
    public String deleteBox(@PathVariable Long id) {
        blindBoxRepository.deleteById(id); 
        return "redirect:/blindbox/list";
    }

    @GetMapping("/edit/{id}")
    public String showEditForm(@PathVariable Long id, Model model) {
        Optional<BlindBox> boxOpt = blindBoxService.getBlindBoxById(id);
        if (boxOpt.isPresent()) {
            model.addAttribute("box", boxOpt.get());
            return "blindbox/edit";
        }
        return "redirect:/blindbox/list"; 
    }

    @PostMapping("/edit/{id}")
    public String updateBlindBox(@PathVariable Long id, @RequestParam String name, @RequestParam String brand,
                                 @RequestParam Double price, @RequestParam Integer stock,
                                 @RequestParam String description, @RequestParam String imageUrl,
                                 @RequestParam String characterList, @RequestParam String secretCharacter) {
        Optional<BlindBox> boxOpt = blindBoxService.getBlindBoxById(id);
        if (boxOpt.isPresent()) {
            BlindBox box = boxOpt.get();
            box.setName(name);
            box.setBrand(brand);
            box.setPrice(price);
            box.setStock(stock);
            box.setDescription(description);
            box.setImageUrl(imageUrl);
            box.setCharacterList(characterList);   // Cập nhật list nhân vật thường mới
            box.setSecretCharacter(secretCharacter); // Cập nhật con secret mới
            
            blindBoxRepository.save(box); 
        }
        return "redirect:/blindbox/list";
    }
}