<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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

<nav class="navbar navbar-expand-lg navbar-dark bg-dark shadow-sm">
    <div class="container">
        <a class="navbar-brand fw-bold text-danger fs-3" href="/blindbox/list">✨ THẾ GIỚI HỘP MÙ - DD ✨</a>
        <div class="d-flex align-items-center">
            <c:if test="${not empty sessionScope.loggedInUser}">
                <span class="text-white me-3">Xin chào, <b class="text-info">${sessionScope.loggedInUser.username}</b></span>
                
                <span class="badge bg-warning text-dark p-2 me-3 fs-6">
                    Ví: <fmt:formatNumber value="${sessionScope.loggedInUser.balance}" type="currency" currencySymbol="đ"/>
                </span>
                
                <form action="/user/recharge" method="POST" class="d-inline mb-0">
                    <input type="hidden" name="amount" value="100000">
                    <button type="submit" class="btn btn-sm btn-success fw-bold">+ Nạp 100k</button>
                </form>
                
                <a href="/auth/logout" class="btn btn-sm btn-outline-danger ms-3">Đăng xuất</a>
            </c:if>
            
            <c:if test="${empty sessionScope.loggedInUser}">
                <a href="/auth/login" class="btn btn-primary fw-bold">🔐 Đăng Nhập</a>
            </c:if>
        </div>
    </div>
</nav>

<div class="container my-5">
    
    <c:if test="${param.error == 'notenoughmoney'}">
        <div class="alert alert-danger text-center fw-bold shadow-sm">❌ Tài khoản của bạn không đủ tiền! Vui lòng nạp thêm tiền để mở hộp.</div>
    </c:if>
    <c:if test="${param.error == 'outofstock'}">
        <div class="alert alert-warning text-center fw-bold shadow-sm">📦 Hộp mù này đã cháy hàng mất rồi!</div>
    </c:if>

    <c:if test="${sessionScope.loggedInUser.role.name == 'ADMIN'}">
        <div class="text-center mb-4">
            <a href="/blindbox/add" class="btn btn-success fw-bold px-4 shadow-sm">➕ Thêm Hộp Mù Mới (Admin)</a>
        </div>
    </c:if>

    <div class="row row-cols-1 row-cols-md-3 g-4">
        <c:forEach var="box" items="${blindBoxes}">
            <div class="col">
                <div class="card h-100 box-card border-0 shadow-sm">
                    <img src="${box.imageUrl != null && box.imageUrl != '' ? box.imageUrl : 'https://via.placeholder.com/300x250'}" class="card-img-top" alt="${box.name}" style="height: 250px; object-fit: cover;">
                    <div class="card-body">
                        <span class="badge bg-info text-dark mb-2">${box.brand}</span>
                        <h5 class="card-title fw-bold">${box.name}</h5>
                        <p class="card-text text-muted text-truncate">${box.description}</p>
                        <h5 class="text-danger fw-bold"><fmt:formatNumber value="${box.price}" type="currency" currencySymbol="đ"/></h5>
                        <p class="small text-secondary mb-0">Tồn kho còn: ${box.stock} hộp</p>
                    </div>
                    
                    <div class="card-footer bg-transparent border-top-0 mb-2">
                        <div class="d-flex gap-2">
                            <a href="/blindbox/open/${box.id}" class="btn btn-danger flex-grow-1 fw-bold ${box.stock == 0 ? 'disabled' : ''}">
                                ${box.stock == 0 ? 'Hết Hàng' : '🎯 Mua Ngay (Mở Hộp)'}
                            </a>
                            
                            <c:if test="${sessionScope.loggedInUser.role.name == 'ADMIN'}">
                                <a href="/blindbox/edit/${box.id}" class="btn btn-outline-primary fw-bold" title="Sửa sản phẩm">
                                    ✏️ Sửa
                                </a>
                                <a href="/blindbox/delete/${box.id}" class="btn btn-outline-warning fw-bold" title="Xóa sản phẩm" onclick="return confirm('Bạn có chắc chắn muốn xóa bộ này khỏi cửa hàng?')">
                                    🗑️ Xóa
                                </a>
                            </c:if>
                        </div>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
</div>

</body>
</html>