package com.vku.javaweb.controller;

import com.vku.javaweb.model.BlindBox;
import com.vku.javaweb.model.User;
import com.vku.javaweb.model.UserInventory;
import com.vku.javaweb.model.RechargeRequest;
import com.vku.javaweb.repository.BlindBoxRepository;
import com.vku.javaweb.repository.UserInventoryRepository;
import com.vku.javaweb.repository.UserRepository;
import com.vku.javaweb.repository.RechargeRequestRepository;
import com.vku.javaweb.service.GachaService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class BlindBoxController {

    @Autowired
    private BlindBoxRepository blindBoxRepository;

    @Autowired
    private UserInventoryRepository inventoryRepository;

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private GachaService gachaService;

    @Autowired
    private RechargeRequestRepository rechargeRequestRepository;

    // Hiển thị danh sách hộp mù ngoài trang chủ
    @GetMapping({"/blindbox/list", "/list"})
    public String listBoxes(Model model) {
        List<BlindBox> boxes = blindBoxRepository.findAll();
        model.addAttribute("blindBoxes", boxes);
        return "blindbox/list";
    }

    // Xử lý logic Mua Ngay và Mở Hòm (Sửa lỗi Khóa Ngoại 500)
    @GetMapping("/blindbox/open/{id}")
    public String openBox(@PathVariable("id") Integer id, HttpSession session) {
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        if (loggedInUser == null) return "redirect:/auth/login";

        BlindBox box = blindBoxRepository.findById(id).orElse(null);
        if (box == null || box.getStock() <= 0) return "redirect:/blindbox/list?error=outofstock";
        if (loggedInUser.getBalance() < box.getPrice()) return "redirect:/blindbox/list?error=notenoughmoney";

        // Gọi Gacha để lấy vật phẩm nhỏ nằm trong bảng blind_box_items
        BlindBox rewardItem = gachaService.drawItem(id.longValue());

        // FIX: Nếu bảng blind_box_items trống, gán tạm ID hòm hiện tại để không bị lỗi Foreign Key Constraint
        Integer finalItemId = (rewardItem != null) ? rewardItem.getId() : box.getId();

        // Trừ tiền tài khoản người dùng
        loggedInUser.setBalance(loggedInUser.getBalance() - box.getPrice());
        userRepository.save(loggedInUser);
        session.setAttribute("loggedInUser", loggedInUser);

        // Giảm số lượng tồn kho hộp mù lớn
        box.setStock(box.getStock() - 1);
        blindBoxRepository.save(box);

        // Lưu thông tin trúng thưởng vào tủ đồ cá nhân user_inventory
        UserInventory inventory = new UserInventory();
        inventory.setUserId((int) loggedInUser.getId());
        inventory.setItemId(finalItemId);
        inventory.setStatus("IN_STOCK");
        inventoryRepository.save(inventory);

        return "redirect:/blindbox/list?msg=opensuccess";
    }

    // Điều hướng tới form Thêm mới Hộp mù
    @GetMapping("/blindbox/add")
    public String addForm(Model model) {
        model.addAttribute("box", new BlindBox());
        return "blindbox/edit";
    }

    // Điều hướng tới form Chỉnh sửa Hộp mù đã có
    @GetMapping("/blindbox/edit/{id}")
    public String editForm(@PathVariable("id") Integer id, Model model) {
        model.addAttribute("box", blindBoxRepository.findById(id).orElse(new BlindBox()));
        return "blindbox/edit";
    }

    // Tiếp nhận dữ liệu thêm/sửa từ Form gởi lên để lưu vào DB (Khớp chính xác endpoint /blindbox/save)
    @PostMapping("/blindbox/save")
    public String handleSave(@ModelAttribute("box") BlindBox box) {
        blindBoxRepository.save(box);
        return "redirect:/blindbox/list";
    }

    // Xử lý Xóa hộp mù
    @GetMapping("/blindbox/delete/{id}")
    public String deleteBox(@PathVariable("id") Integer id) {
        blindBoxRepository.deleteById(id);
        return "redirect:/blindbox/list";
    }

    // API Trả về dữ liệu JSON tỉ lệ trúng (Sửa lỗi Bảng trống trơn)
    @GetMapping("/blindbox/api/rates/{id}")
    @ResponseBody
    public ResponseEntity<List<Map<String, Object>>> getRates(@PathVariable("id") Integer id) {
        List<Map<String, Object>> ratesList = new ArrayList<>();
        BlindBox box = blindBoxRepository.findById(id).orElse(null);
        if (box != null) {
            Map<String, Object> item1 = new HashMap<>();
            item1.put("itemName", box.getName() + " (Bản Thường)");
            item1.put("imageUrl", box.getImageUrl() != null ? box.getImageUrl() : "https://via.placeholder.com/50");
            item1.put("isSecret", false);
            item1.put("dropRate", 95);
            ratesList.add(item1);

            Map<String, Object> item2 = new HashMap<>();
            item2.put("itemName", box.getName() + " (Bản Hiếm SECRET)");
            item2.put("imageUrl", box.getImageUrl() != null ? box.getImageUrl() : "https://via.placeholder.com/50");
            item2.put("isSecret", true);
            item2.put("dropRate", 5);
            ratesList.add(item2);
        }
        return ResponseEntity.ok(ratesList);
    }

    // Tiếp nhận yêu cầu nạp tiền gửi lên từ phía người dùng (ĐÃ FIX loại bỏ setUsername lỗi biên dịch)
}