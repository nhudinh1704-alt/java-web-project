<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Sửa Hộp Mù</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body class="bg-light">
    <div class="container mt-5">
        <h2 class="text-center text-primary mb-4">✏️ CHỈNH SỬA HỘP MÙ</h2>
        <div class="card p-4 mx-auto shadow" style="max-width: 600px;">
            <form action="/blindbox/edit/${box.id}" method="post">
                <div class="mb-3">
                    <label class="form-label fw-bold">Tên Bộ Hộp Mù:</label>
                    <input type="text" name="name" class="form-control" value="${box.name}" required>
                </div>
                <div class="mb-3">
                    <label class="form-label fw-bold">Hãng Sản Xuất (Thương hiệu):</label>
                    <input type="text" name="brand" class="form-control" value="${box.brand}" required>
                </div>
                <div class="mb-3">
                    <label class="form-label fw-bold">Giá bán (VND):</label>
                    <input type="number" step="0.1" name="price" class="form-control" value="${box.price}" required>
                </div>
                <div class="mb-3">
                    <label class="form-label fw-bold">Số lượng tồn kho:</label>
                    <input type="number" name="stock" class="form-control" value="${box.stock}" required>
                </div>
                <div class="mb-3">
                    <label class="form-label fw-bold">Link Ảnh URL:</label>
                    <input type="text" name="imageUrl" class="form-control" value="${box.imageUrl}" required>
                </div>
                <div class="mb-3">
                    <label class="form-label fw-bold">Mô tả ngắn gọn:</label>
                    <textarea name="description" class="form-control" rows="3" required>${box.description}</textarea>
                </div>
                <div class="mb-3">
    <label class="form-label fw-bold text-danger">Danh sách nhân vật thường (Cách nhau bằng dấu phẩy):</label>
    <input type="text" name="characterList" class="form-control" value="${box.characterList}" required>
</div>
<div class="mb-3">
    <label class="form-label fw-bold text-warning">Tên nhân vật SECRET (Hiếm):</label>
    <input type="text" name="secretCharacter" class="form-control" value="${box.secretCharacter}" required>
</div>
                <button type="submit" class="btn btn-primary w-100 fw-bold">💾 Lưu Thay Đổi</button>
                <a href="/blindbox/list" class="btn btn-secondary w-100 mt-2">Hủy bỏ / Quay lại</a>
            </form>
        </div>
    </div>
</body>
</html>