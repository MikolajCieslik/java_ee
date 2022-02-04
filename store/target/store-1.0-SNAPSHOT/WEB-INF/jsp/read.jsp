<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<html>
<head>
    <title>Read</title>
</head>
<body>
    <h2>Read</h2>
    <p><strong>User List:
        <table border="1">
            <tr>
                <th>Imie</th>
                <th>Nazwisko</th>
            </tr>
            <c:forEach var="user" items="${listUser}">
                <tr>
                    <td>${user.imie}</td>
                    <td>${user.nazwisko}</td>
                </tr>
            </c:forEach>
        </table>
</body>
</html>
