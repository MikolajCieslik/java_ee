<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Logowanie</title>
</head>
<body>
    <div id="container">
        <div>
            <form action="LogServlet" method="post">
                Login: <input type="text" name="login" placeholder="Login" required><br><br>
                Hasło: <input type="password" name="haslo" placeholder="Hasło" required><br><br>
                <input type="submit" value="Zaloguj">
            </form>
            <a href="register.jsp">Zarejestruj się</a><br>

        </div>
    </div>
    <div>
        <%
            String msg= request.getParameter("msg");
            if("valid".equals(msg)){
        %>
        <h3>Udało się zalogować.</h3>
        <a href="index.jsp"><button>Strona główna</button></a>
        <%}
            if("invalid".equals(msg)){%>
        <h3>Błędny login lub hasło.</h3>
        <a href="index.jsp"><button>Strona główna</button></a>
        <% }
        %>
    </div>
</body>
</html>
