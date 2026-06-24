<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Cửa Hàng Hộp Mù - Blind Box</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <style>
        .box-card { transition: 0.3s; }
        .box-card:hover { transform: translateY(-5px); box-shadow: 0 4px 15px rgba(0,0,0,0.15); }
    </style>
</head>
<body class="bg-light">

<div class="container my-5">
    <h1 class="text-center mb-5 fw-bold text-danger">✨ THẾ GIỚI HỘP MÙ - DD✨</h1>
    <div class="text-center mb-4">
    <a href="/blindbox/add" class="btn btn-success fw-bold px-4">➕ Thêm Hộp Mù Mới</a>
</div>
    <div class="row row-cols-1 row-cols-md-3 g-4">
        <c:forEach var="box" items="${blindBoxes}">
            <div class="col">
                <div class="card h-100 box-card border-0 shadow-sm">
                    <img src="${box.imageUrl != null && box.imageUrl != '' ? box.imageUrl : 'https://via.placeholder.com/300x250'}" class="card-img-top" alt="${box.name}" style="height: 250px; object-fit: cover;">
                    <div class="card-body">
                        <span class="badge bg-info text-dark mb-2">${box.brand}</span>
                        <h5 class="card-title fw-bold">${box.name}</h5>
                        <p class="card-text text-muted text-truncate">${box.description}</p>
                        <h5 class="text-danger fw-bold">${box.price} VND</h5>
                        <p class="small text-secondary mb-0">Tồn kho còn: ${box.stock} hộp</p>
                    </div>
                    <div class="card-footer bg-transparent border-top-0 mb-2">
                    <div class="d-flex gap-2">
    <a href="/blindbox/open/${box.id}" class="btn btn-danger flex-grow-1 fw-bold ${box.stock == 0 ? 'disabled' : ''}">
        ${box.stock == 0 ? 'Hết Hàng' : 'Mua Ngay'}
    </a>
    
    <a href="/blindbox/edit/${box.id}" class="btn btn-primary fw-bold">
        ✏️ Sửa
    </a>`

    <a href="/blindbox/delete/${box.id}" class="btn btn-warning fw-bold" onclick="return confirm('Bạn có chắc chắn muốn xóa bộ này khỏi cửa hàng?')">
        🗑️ Xóa
    </a>
</div>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
</div>

</body>
</html>