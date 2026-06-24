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
import com.vku.javaweb.model.User; // 1. ĐÃ THÊM IMPORT USER
import com.vku.javaweb.repository.BlindBoxRepository;
import com.vku.javaweb.repository.UserRepository; // 2. ĐÃ THÊM IMPORT USERREPOSITORY
import com.vku.javaweb.service.BlindBoxService;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/blindbox")
public class BlindBoxController {

    @Autowired
    private BlindBoxService blindBoxService;

    @Autowired
    private BlindBoxRepository blindBoxRepository; 

    @Autowired // 3. ĐÃ TIÊM USERREPOSITORY VÀO ĐỂ KHÔNG BỊ LỖI ĐỎ Ở DÒNG TRỪ TIỀN
    private UserRepository userRepository;

    @GetMapping("/list")
    public String showBlindBoxList(Model model) {
        model.addAttribute("blindBoxes", blindBoxService.getAllBlindBoxes());
        return "blindbox/list";
    }

    @GetMapping("/open/{id}")
    public String openBox(@PathVariable Long id, Model model, HttpSession session) {
        // 1. Kiểm tra đăng nhập
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        if (loggedInUser == null) {
            return "redirect:/auth/login";
        }

        Optional<BlindBox> boxOpt = blindBoxRepository.findById(id);
        if (boxOpt.isEmpty()) return "redirect:/blindbox/list";
        BlindBox box = boxOpt.get();

        // 2. Kiểm tra hàng trong kho
        if (box.getStock() <= 0) {
            return "redirect:/blindbox/list?error=outofstock";
        }

        // 3. KIỂM TRA SỐ DƯ TÀI KHOẢN CÓ ĐỦ MUA KHÔNG
        if (loggedInUser.getBalance() < box.getPrice()) {
            // Trả về kèm mã lỗi hụt tiền để giao diện hiển thị thông báo nạp tiền
            return "redirect:/blindbox/list?error=notenoughmoney"; 
        }

        // 4. ĐỦ TIỀN THÌ TIẾN HÀNH TRỪ TIỀN VÀ KHUI HỘP
        loggedInUser.setBalance(loggedInUser.getBalance() - box.getPrice());
        userRepository.save(loggedInUser); // Đã hết lỗi đỏ vì đã khai báo userRepository ở trên
        session.setAttribute("loggedInUser", loggedInUser); // Cập nhật lại ví tiền trên thanh menu

        box.setStock(box.getStock() - 1); // Giảm 1 món trong kho
        blindBoxRepository.save(box);

        // Logic bốc thăm ngẫu nhiên nhân vật
        List<String> normalCharacters = Arrays.asList(box.getCharacterList().split(","));
        String secretCharacter = "✨ SECRET: " + box.getSecretCharacter() + " ✨";
        Random rand = new Random();
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
            box.setCharacterList(characterList);   
            box.setSecretCharacter(secretCharacter); 
            
            blindBoxRepository.save(box); 
        }
        return "redirect:/blindbox/list";
    }
}