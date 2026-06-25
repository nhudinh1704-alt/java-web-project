<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Kết Quả Mở Hộp!</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body class="bg-dark text-white d-flex align-items-center justify-content-center" style="height: 100vh;">

    <div class="text-center">
        <h3 class="text-warning mb-3">Đang mở hộp ${box.name}...</h3>
        
        <div class="card bg-light text-dark mx-auto p-4 shadow-lg" style="max-width: 400px; border-radius: 20px;">
            <img src="https://media.giphy.com/media/26FPqX4Oud5PzK9vO/giphy.gif" class="img-fluid rounded mb-4" alt="unboxing">
            <h4 class="mb-3">🎉 CHÚC MỪNG BẠN ĐÃ BÓC ĐƯỢC 🎉</h4>
            
            <h2 class="text-danger fw-bold py-3 border border-danger border-2 border-dashed">
                ${character}
            </h2>
        </div>

        <div class="mt-5">
            <a href="/blindbox/list" class="btn btn-outline-light btn-lg">Trở về Cửa Hàng mua tiếp</a>
        </div>
    </div>

</body>
</html>