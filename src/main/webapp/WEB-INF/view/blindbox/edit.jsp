<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<html>
<head>
    <title>Chỉnh Sửa Hộp Mù</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body class="bg-light">
<div class="container my-5" style="max-width: 600px;">
    <div class="card shadow p-4 border-0 bg-white">
        <h3 class="fw-bold mb-4 text-dark text-center">📦 THÔNG TIN HỘP MÙ</h3>

        <form:form action="${pageContext.request.contextPath}/blindbox/save" method="post" modelAttribute="box">
            <form:hidden path="id" />

            <div class="mb-3">
                <label class="form-label fw-bold">Tên sản phẩm</label>
                <form:input path="name" class="form-control" placeholder="Nhập tên sản phẩm..." required="required" />
            </div>

            <div class="mb-3">
                <label class="form-label fw-bold">Thương hiệu</label>
                <form:input path="brand" class="form-control" placeholder="Nhập thương hiệu..." />
            </div>

            <div class="mb-3">
                <label class="form-label fw-bold">Giá bán (VNĐ)</label>
                <form:input path="price" type="number" class="form-control" required="required" />
            </div>

            <div class="mb-3">
                <label class="form-label fw-bold">Số lượng tồn kho</label>
                <form:input path="stock" type="number" class="form-control" required="required" />
            </div>

            <div class="mb-3">
                <label class="form-label fw-bold">Mô tả sản phẩm</label>
                <form:textarea path="description" class="form-control" rows="3" placeholder="Nhập mô tả chi tiết..." />
            </div>

            <div class="mb-3">
                <label class="form-label fw-bold">Đường dẫn hình ảnh (URL)</label>
                <form:input path="imageUrl" class="form-control" placeholder="https://..." />
            </div>

            <div class="d-flex gap-2 justify-content-end mt-4">
                <a href="${pageContext.request.contextPath}/blindbox/list" class="btn btn-secondary">Hủy</a>
                <button type="submit" class="btn btn-success px-4 fw-bold">Lưu lại</button>
            </div>
        </form:form>
    </div>
</div>
</body>
</html>