<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
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
        <a class="navbar-brand fw-bold text-danger fs-3" href="${pageContext.request.contextPath}/blindbox/list">✨ THẾ GIỚI HỘP MÙ - DD ✨</a>
        <div class="d-flex align-items-center">
            <c:if test="${not empty sessionScope.loggedInUser}">
                <span class="text-white me-3">Xin chào, <b class="text-info">${sessionScope.loggedInUser.username}</b></span>

                <span class="badge bg-warning text-dark p-2 me-3 fs-6">
                    Ví: <fmt:formatNumber value="${sessionScope.loggedInUser.balance}" type="currency" currencySymbol="đ"/>
                </span>

                <a href="${pageContext.request.contextPath}/user/inventory" class="btn btn-sm btn-info fw-bold text-white me-2">🎒 Tủ Đồ Của Tôi</a>

                <c:if test="${sessionScope.loggedInUser.username == 'admin'}">
                    <a href="${pageContext.request.contextPath}/admin/orders" class="btn btn-sm btn-warning fw-bold me-2 text-dark">📋 Quản Lý Hệ Thống</a>
                </c:if>

                <button type="button" class="btn btn-sm btn-success fw-bold" data-bs-toggle="modal" data-bs-target="#qrRechargeModal">
                    💳 Nạp Tiền QR
                </button>

                <a href="${pageContext.request.contextPath}/auth/logout" class="btn btn-sm btn-outline-danger ms-3">Đăng xuất</a>
            </c:if>

            <c:if test="${empty sessionScope.loggedInUser}">
                <a href="${pageContext.request.contextPath}/auth/login" class="btn btn-primary fw-bold">🔐 Đăng Nhập</a>
            </c:if>
        </div>
    </div>
</nav>

<div class="container my-5">

    <c:if test="${param.msg == 'submitted'}">
        <div class="alert alert-success text-center fw-bold shadow-sm">🚀 Gửi yêu cầu thành công! Vui lòng đợi tài khoản admin đối soát ngân hàng để cộng tiền.</div>
    </c:if>
    <c:if test="${param.msg == 'opensuccess'}">
        <div class="alert alert-success text-center fw-bold shadow-sm">🎉 Mua và khui hộp thành công! Vật phẩm đã được chuyển vào Tủ Đồ Của Tôi.</div>
    </c:if>
    <c:if test="${param.error == 'notenoughmoney'}">
        <div class="alert alert-danger text-center fw-bold shadow-sm">❌ Tài khoản của bạn không đủ tiền! Vui lòng nạp thêm tiền để mở hộp.</div>
    </c:if>
    <c:if test="${param.error == 'outofstock'}">
        <div class="alert alert-warning text-center fw-bold shadow-sm">📦 Hộp mù này đã cháy hàng mất rồi!</div>
    </c:if>

    <c:if test="${sessionScope.loggedInUser.username == 'admin'}">
        <div class="text-center mb-4">
            <a href="${pageContext.request.contextPath}/blindbox/add" class="btn btn-success fw-bold px-4 shadow-sm">➕ Thêm Hộp Mù Mới (Admin)</a>
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
                        <button type="button" class="btn btn-sm btn-outline-secondary w-100 mb-2 fw-bold"
                                onclick="showRatesModal(${box.id}, '${box.name}')">
                            📊 Xem Tỉ Lệ Trúng
                        </button>

                        <div class="d-flex gap-2">
                            <a href="${pageContext.request.contextPath}/blindbox/open/${box.id}" class="btn btn-danger flex-grow-1 fw-bold ${box.stock == 0 ? 'disabled' : ''}">
                                ${box.stock == 0 ? 'Hết Hàng' : '🎯 Mua Ngay'}
                            </a>

                            <c:if test="${sessionScope.loggedInUser.username == 'admin'}">
                                <a href="${pageContext.request.contextPath}/blindbox/edit/${box.id}" class="btn btn-outline-primary fw-bold" title="Sửa sản phẩm">
                                    ✏️ Sửa
                                </a>
                                <a href="${pageContext.request.contextPath}/blindbox/delete/${box.id}" class="btn btn-outline-warning fw-bold" title="Xóa sản phẩm"
                                   onclick="return confirm('Bạn có chắc chắn muốn xóa bộ này khỏi cửa hàng?')">
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

<div class="modal fade" id="qrRechargeModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content border-0 shadow-lg text-dark">
            <div class="modal-header bg-dark text-white">
                <h5 class="modal-title fw-bold">💳 NẠP TIỀN QUA MÃ VIETQR</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <form action="${pageContext.request.contextPath}/user/recharge-request" method="POST" class="mb-0">
                <div class="modal-body text-center bg-light">
                    <div class="mb-3 text-start px-3">
                        <label class="form-label fw-bold small text-muted">Nhập số tiền bạn muốn nạp (đ):</label>
                        <input type="number" id="inputAmount" name="amount" class="form-control form-control-lg fw-bold text-danger text-center" value="50000" min="10000" step="5000" required>
                    </div>

                    <img id="qrImage" src="https://img.vietqr.io/image/MB-0373663816-compact2.jpg?amount=50000&addInfo=NAP%20BLINDBOX%20${sessionScope.loggedInUser.username}"
                         class="img-fluid my-2 border p-3 bg-white rounded shadow-sm" style="max-width: 220px;" alt="VietQR MBBank">

                    <div class="card text-start border-0 shadow-sm mx-auto p-3" style="max-width: 380px; font-size: 14px; color:#333;">
                        <div class="mb-1">🏦 Ngân hàng: <b class="text-primary">MBBank (Ngân hàng Quân Đội)</b></div>
                        <div class="mb-1">👤 Chủ TK: <b>HA TRAN NHU DINH</b></div>
                        <div class="mb-1">🔢 Số TK: <b>0373663816</b></div>
                        <div>📝 Nội dung: <b class="text-danger">NAP BLINDBOX ${sessionScope.loggedInUser.username}</b></div>
                    </div>
                </div>
                <div class="modal-footer bg-white justify-content-center border-top-0">
                    <button type="submit" class="btn btn-danger w-100 fw-bold py-2 shadow-sm">✅ Tôi Đã Chuyển Khoản Thành Công</button>
                </div>
            </form>
        </div>
    </div>
</div>

<div class="modal fade" id="ratesModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered modal-lg">
        <div class="modal-content border-0 shadow-lg text-dark">
            <div class="modal-header bg-dark text-white">
                <h5 class="modal-title fw-bold" id="ratesModalTitle">📊 BẢNG TỈ LỆ LỢI NHUẬN & ĐỒ CHƠI</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body bg-light">
                <p class="text-muted small mb-3">💡 *Lưu ý: Tỉ lệ được cấu hình minh bạch bằng thuật toán ngẫu nhiên của hệ thống DD Blind Box.*</p>

                <div class="table-responsive">
                    <table class="table table-bordered table-hover align-middle bg-white rounded shadow-sm">
                        <thead class="table-secondary text-center">
                            <tr>
                                <th style="width: 15%">Hình ảnh</th>
                                <th>Tên Vật Phẩm</th>
                                <th style="width: 25%">Phân Loại</th>
                                <th style="width: 20%">Tỉ Lệ Xuất Hiện</th>
                            </tr>
                        </thead>
                        <tbody id="ratesTableBody"></tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<script>
    // Xử lý cập nhật hình ảnh QR động khi thay đổi số tiền nhập vào
    document.getElementById('inputAmount').addEventListener('input', function() {
        var amount = this.value;
        if(!amount || amount < 0) amount = 0;
        var username = "${sessionScope.loggedInUser.username}";
        document.getElementById('qrImage').src = "https://img.vietqr.io/image/MB-0373663816-compact2.jpg?amount=" + amount + "&addInfo=NAP%20BLINDBOX%20" + encodeURIComponent(username);
    });

    // FIX TRIỆT ĐỂ LỖI BẢNG TỈ LỆ TRỐNG TRƠN: Chuyển hoàn toàn sang nối chuỗi kiểu truyền thống để tránh xung đột cú pháp JSP El
    function showRatesModal(boxId, boxName) {
        document.getElementById('ratesModalTitle').innerText = "📊 TỈ LỆ RỚT VẬT PHẨM - " + boxName.toUpperCase();
        var tableBody = document.getElementById('ratesTableBody');
        tableBody.innerHTML = '<tr><td colspan="4" class="text-center text-muted">Đang tải dữ liệu tỉ lệ...</td></tr>';

        fetch('${pageContext.request.contextPath}/blindbox/api/rates/' + boxId)
            .then(response => response.json())
            .then(data => {
                tableBody.innerHTML = '';
                if (data.length === 0) {
                    tableBody.innerHTML = '<tr><td colspan="4" class="text-center text-danger fw-bold">Bộ này chưa được Admin cấu hình nhân vật!</td></tr>';
                    return;
                }
                data.forEach(item => {
                    var isSecret = item.isSecret ? true : false;
                    var badgeClass = isSecret ? 'bg-danger text-white' : 'bg-success text-white';
                    var badgeText = isSecret ? '🔥 SUPER SECRET (HIẾM)' : '⭐ NORMAL (THƯỜNG)';
                    var rateDisplay = item.dropRate ? item.dropRate + '%' : 'Chưa rõ';
                    var imgUrl = item.imageUrl ? item.imageUrl : 'https://via.placeholder.com/50';

                    var row = '<tr>' +
                        '<td class="text-center">' +
                            '<img src="' + imgUrl + '" class="rounded border shadow-sm" style="width: 50px; height: 50px; object-fit: cover;">' +
                        '</td>' +
                        '<td><b class="text-dark">' + item.itemName + '</b></td>' +
                        '<td class="text-center">' +
                            '<span class="badge ' + badgeClass + ' px-3 py-2 fw-bold" style="font-size: 11px;">' + badgeText + '</span>' +
                        '</td>' +
                        '<td class="text-center fw-bold text-primary fs-5">' + rateDisplay + '</td>' +
                    '</tr>';

                    tableBody.innerHTML += row;
                });
                var myModal = new bootstrap.Modal(document.getElementById('ratesModal'));
                myModal.show();
            })
            .catch(err => {
                console.error(err);
                tableBody.innerHTML = '<tr><td colspan="4" class="text-center text-danger">Có lỗi xảy ra khi lấy bảng tỉ lệ!</td></tr>';
            });
    }
</script>
</body>
</html>