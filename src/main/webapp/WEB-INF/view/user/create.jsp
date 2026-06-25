<%@page contentType="text/html" pageEncoding="UTF-8" %>

<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>


<!DOCTYPE html>
<html lang="en">
<head>
<title>Create User</title>
</head>

<body>

<h2>Create User</h2>

<form:form method="POST" action="/admin/user/create1" modelAttribute="newUser">

Username:
<form:input path="username"/>
<br><br>

Password:
<form:input path="password"/>
<br><br>

Full Name:
<form:input path="fullName"/>
<br><br>
<button type="submit">Lưu</button>


</form:form>

</body>
</html>