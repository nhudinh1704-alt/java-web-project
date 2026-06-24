<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>User List</title>
</head>
<body>

<h2>User List</h2>

<table border="1">
    <tr>
        <th>ID</th>
        <th>Username</th>
        <th>Full Name</th>
    </tr>

    <c:forEach var="u" items="${users}">
        <tr>
            <td>${u.id}</td>
            <td>${u.username}</td>
            <td>${u.fullName}</td>
        </tr>
    </c:forEach>

</table>

</body>
</html>