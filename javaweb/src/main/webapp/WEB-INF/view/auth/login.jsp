<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Cửa Hàng Hộp Mù - Đăng Nhập / Đăng Ký</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%); min-height: 100vh; display: flex; align-items: center; }
        .auth-card { border: none; border-radius: 15px; box-shadow: 0 10px 30px rgba(0,0,0,0.1); overflow: hidden; background: #fff; }
        .nav-pills .nav-link.active { background-color: #dc3545; }
        .nav-pills .nav-link { color: #495057; font-weight: bold; }
    </style>
</head>
<body>
<div class="container">
    <div class="row justify-content-center">
        <div class="col-md-5">
            
            <c:if test="${param.error == 'true'}">
                <div class="alert alert-danger text-center fw-bold rounded-3">❌ Sai tài khoản hoặc mật khẩu!</div>
            </c:if>
            <c:if test="${param.registerSuccess == 'true'}">
                <div class="alert alert-success text-center fw-bold rounded-3">🎉 Đăng ký thành công! Mời đăng nhập.</div>
            </c:if>
            <c:if test="${param.usernameExists == 'true'}">
                <div class="alert alert-warning text-center fw-bold rounded-3">⚠️ Tên đăng nhập này đã có người dùng!</div>
            </c:if>

            <div class="card auth-card p-4">
                <h3 class="text-center fw-bold text-danger mb-4">✨ BLIND BOX DD ✨</h3>
                
                <ul class="nav nav-pills nav-justified mb-4" id="pills-tab" role="tablist">
                    <li class="nav-item">
                        <button class="nav-link active fw-bold" id="pills-login-tab" data-bs-toggle="pill" data-bs-target="#pills-login" type="button" role="tab">🔐 Đăng Nhập</button>
                    </li>
                    <li class="nav-item">
                        <button class="nav-link fw-bold" id="pills-register-tab" data-bs-toggle="pill" data-bs-target="#pills-register" type="button" role="tab">📝 Đăng Ký</button>
                    </li>
                </ul>

                <div class="tab-content" id="pills-tabContent">
                    <div class="tab-pane fade show active" id="pills-login" role="tabpanel">
                        <form action="/auth/login" method="POST">
                            <div class="mb-3">
                                <label class="form-label fw-semibold">Tên đăng nhập</label>
                                <input type="text" name="username" class="form-control" placeholder="Nhập username..." required>
                            </div>
                            <div class="mb-4">
                                <label class="form-label fw-semibold">Mật khẩu</label>
                                <input type="password" name="password" class="form-control" placeholder="Nhập mật khẩu..." required>
                            </div>
                            <button type="submit" class="btn btn-danger w-100 fw-bold py-2 shadow-sm">ĐĂNG NHẬP NGAY</button>
                        </form>
                    </div>

                    <div class="tab-pane fade" id="pills-register" role="tabpanel">
                        <form action="/auth/register" method="POST">
                            <div class="mb-3">
                                <label class="form-label fw-semibold">Tên đăng nhập (Username)</label>
                                <input type="text" name="username" class="form-control" placeholder="Tên dùng để đăng nhập..." required>
                            </div>
                            <div class="mb-3">
                                <label class="form-label fw-semibold">Mật khẩu</label>
                                <input type="password" name="password" class="form-control" placeholder="Tạo mật khẩu..." required>
                            </div>
                            <div class="mb-4">
                                <label class="form-label fw-semibold">Họ và Tên</label>
                                <input type="text" name="fullName" class="form-control" placeholder="Nhập họ tên của bạn..." required>
                            </div>
                            <button type="submit" class="btn btn-success w-100 fw-bold py-2 shadow-sm">TẠO TÀI KHOẢN MỚI</button>
                        </form>
                    </div>
                </div>

            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>