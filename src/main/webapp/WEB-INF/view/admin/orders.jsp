<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>DD Control Center (Admin)</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body class="bg-light">

<nav class="navbar navbar-dark bg-danger shadow-sm py-2">
    <div class="container">
        <a class="navbar-brand fw-bold fs-4" href="#">⚙️ DD CONTROL CENTER (ADMIN)</a>
        <a href="${pageContext.request.contextPath}/blindbox/list" class="btn btn-sm btn-light fw-bold text-danger">🏠 Trở Về Cửa Hàng</a>
    </div>
</nav>

<div class="container my-5">
    <h2 class="fw-bold mb-4 text-dark text-uppercase">BẢNG ĐIỀU HƯỚNG HỆ THỐNG</h2>

    <div class="row g-4">
        <div class="col-md-7">
            <div class="card border-0 shadow-sm">
                <div class="card-header bg-dark text-white fw-bold py-3">
                    🏛️ Phê Duyệt Yêu Cầu Nạp Tiền (VietQR)
                </div>
                <div class="card-body p-0">
                    <div class="table-responsive">
                        <table class="table table-hover align-middle mb-0 bg-white">
                            <thead class="table-light">
                                <tr>
                                    <th class="ps-3">Mã Đơn</th>
                                    <th>ID Khách</th>
                                    <th>Số Tiền</th>
                                    <th class="text-center">Trạng Thái</th>
                                    <th class="text-center pe-3">Thao Tác</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:if test="${empty rechargeRequests}">
                                    <tr>
                                        <td colspan="5" class="text-center text-muted py-4">Hiện tại không có lịch sử nạp tiền nào.</td>
                                    </tr>
                                </c:if>

                                <c:forEach var="req" items="${rechargeRequests}">
                                    <tr>
                                        <td class="ps-3 fw-bold text-secondary">#${req.id}</td>
                                        <td>
                                            <span class="badge bg-secondary">${req.username != null ? req.username : req.userId}</span>
                                        </td>
                                        <td class="fw-bold text-success">
                                            <fmt:formatNumber value="${req.amount}" type="currency" currencySymbol="đ"/>
                                        </td>
                                        <td class="text-center">
                                            <c:choose>
                                                <c:when test="${req.status == 'PENDING'}">
                                                    <span class="badge bg-warning text-dark px-2 py-1">CHỜ DUYỆT</span>
                                                </c:when>
                                                <c:when test="${req.status == 'APPROVED'}">
                                                    <span class="badge bg-success px-2 py-1">ĐÃ DUYỆT</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="badge bg-danger px-2 py-1">${req.status}</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td class="text-center pe-3">
                                            <c:if test="${req.status == 'PENDING'}">
                                                <a href="${pageContext.request.contextPath}/admin/recharge/approve/${req.id}"
                                                   class="btn btn-sm btn-success fw-bold px-3 shadow-sm"
                                                   onclick="return confirm('Bạn đã đối soát ngân hàng và xác nhận cộng tiền cho tài khoản này?')">
                                                    Duyệt Nạp
                                                </a>
                                            </c:if>
                                            <c:if test="${req.status != 'PENDING'}">
                                                <button class="btn btn-sm btn-light border" disabled>Hoàn tất</button>
                                            </c:if>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-md-5">
            <div class="card border-0 shadow-sm">
                <div class="card-header bg-secondary text-white fw-bold py-3">
                    📦 Quản Lý Đơn Vận Chuyển Đồ Chơi
                </div>
                <div class="card-body p-0">
                    <table class="table align-middle mb-0 bg-white">
                        <thead class="table-light">
                            <tr>
                                <th class="ps-3">ID Đơn</th>
                                <th>ID Item</th>
                                <th>Trạng Thái Kho</th>
                                <th class="pe-3">Xử Lý Logistics</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td colspan="4" class="text-center text-muted py-4">Chưa có hòm đồ nào được khởi tạo.</td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>