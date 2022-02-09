<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Logowanie</title>
</head>
<body>
<div id="container">
    <form action="LogServlet" method="post">
        Login: <input type="text" name="login" placeholder="Login" required><br><br>
        Hasło: <input type="password" name="haslo" placeholder="Hasło" required><br><br>
        <input type="submit" value="Zaloguj">
    </form>
</div>
</body>
</html>
