<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Tủ Đồ Của Tôi</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body class="bg-light">
<div class="container my-5">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h2 class="fw-bold text-dark">🎒 BỘ SƯU TẬP NHÂN VẬT CỦA TÔI</h2>
        <a href="/blindbox/list" class="btn btn-secondary fw-bold">← Quay lại Cửa Hàng</a>
    </div>

    <c:if test="${empty inventoryItems}">
        <div class="alert alert-warning text-center fw-bold shadow-sm p-4">Bạn chưa sở hữu nhân vật nào cả! Hãy đi khui những chiếc túi mù đầu tiên nhé.</div>
    </c:if>

    <div class="row g-4">
        <c:forEach var="item" items="${inventoryItems}">
            <div class="col-md-3">
                <div class="card h-100 border-0 shadow-sm text-center">
                    <img src="${item.imageUrl}" class="card-img-top mx-auto p-3 rounded" style="max-height: 200px; object-fit: contain;">
                    <div class="card-body d-flex flex-column justify-content-between">
                        <div>
                            <h6 class="fw-bold text-dark mb-1">${item.itemName}</h6>
                            <p class="small text-muted mb-3">Tỷ lệ rơi: ${item.dropRate * 100}%</p>
                        </div>

                        <form action="/user/request-ship" method="POST" class="mb-0">
                            <input type="hidden" name="inventoryId" value="${item.id}">
                            <c:choose>
                                <c:when test="${item.description == 'IN_STOCK'}">
                                    <button type="submit" class="btn btn-sm btn-danger w-100 fw-bold py-2">🚚 Đặt Ship Về Nhà</button>
                                </c:when>
                                <c:when test="${item.description == 'PENDING_SHIP'}">
                                    <button type="button" class="btn btn-sm btn-warning w-100 fw-bold py-2 disabled">⏳ Đang Đóng Gói...</button>
                                </c:when>
                                <c:otherwise>
                                    <button type="button" class="btn btn-sm btn-success w-100 fw-bold py-2 disabled">✅ Đã Giao Thành Công</button>
                                </c:otherwise>
                            </c:choose>
                        </form>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
</div>
</body>
</html>