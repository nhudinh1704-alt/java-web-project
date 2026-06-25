<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Thêm Hộp Mù Mới</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body class="bg-light">
    <div class="container mt-5">
        <h2 class="text-center text-success mb-4">📦 THÊM HỘP MÙ MỚI</h2>
        <div class="card p-4 mx-auto shadow" style="max-width: 600px;">
            <form action="/blindbox/add" method="post">
                <div class="mb-3">
                    <label class="form-label fw-bold">Tên Bộ Hộp Mù:</label>
                    <input type="text" name="name" class="form-control" required placeholder="VD: Crybaby Sad Club">
                </div>
                <div class="mb-3">
                    <label class="form-label fw-bold">Hãng Sản Xuất (Thương hiệu):</label>
                    <input type="text" name="brand" class="form-control" required placeholder="VD: Pop Mart">
                </div>
                <div class="mb-3">
                    <label class="form-label fw-bold">Giá bán (VND):</label>
                    <input type="number" step="0.1" name="price" class="form-control" required placeholder="VD: 350000">
                </div>
                <div class="mb-3">
                    <label class="form-label fw-bold">Số lượng nhập kho:</label>
                    <input type="number" name="stock" class="form-control" required placeholder="VD: 50">
                </div>
                <div class="mb-3">
                    <label class="form-label fw-bold">Link Ảnh URL (Lấy từ Google Images):</label>
                    <input type="text" name="imageUrl" class="form-control" required>
                </div>
                <div class="mb-3">
                    <label class="form-label fw-bold">Mô tả ngắn gọn:</label>
                    <textarea name="description" class="form-control" rows="3" required></textarea>
                </div>
                <div class="mb-3">
    <label class="form-label fw-bold text-danger">Danh sách nhân vật thường (Cách nhau bằng dấu phẩy):</label>
    <input type="text" name="characterList" class="form-control" required placeholder="VD: Labubu Pink, Labubu Green, Labubu Blue">
</div>
<div class="mb-3">
    <label class="form-label fw-bold text-warning">Tên nhân vật SECRET (Hiếm):</label>
    <input type="text" name="secretCharacter" class="form-control" required placeholder="VD: Labubu Cacao">
</div>
                <button type="submit" class="btn btn-success w-100 fw-bold">💾 Lưu Hộp Mù Vào Kho</button>
                <a href="/blindbox/list" class="btn btn-secondary w-100 mt-2">Hủy bỏ / Quay lại</a>
            </form>
        </div>
    </div>
</body>
</html>