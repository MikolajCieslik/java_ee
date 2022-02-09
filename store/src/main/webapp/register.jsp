<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Rejestracja</title>
</head>
<body>
    <div id="container">
        <form action="RegServlet" method="post">
            Login: <input type="text" name="login" placeholder="Login" required><br><br>
            Hasło: <input type="password" name="haslo" placeholder="Hasło" required><br><br>
            Imię: <input type="text" name="imie" placeholder="Imię" required><br><br>
            Nazwisko: <input type="text" name="nazwisko" placeholder="Nazwisko" required><br><br>
            Kod pocztowy: <input type="text" name="kod_pocztowy" placeholder="Kod pocztowy" required><br><br>
            Miejscowość: <input type="text" name="miejscowosc" placeholder="Miejscowość" required><br><br>
            Adres: <input type="text" name="adres" placeholder="Adres" required><br><br>
            Numer: <input type="text" name="numer" placeholder="Numer telefonu" required><br><br>
            <input type="submit" value="Zarejestruj">
        </form>
    </div>
    <div>
        <%
            String msg= request.getParameter("msg");
            if("valid".equals(msg)){
                %>
        <h3>Udało się zarejestrować. Proszę się zalogować</h3>
        <a href="index.jsp"><button>Strona główna</button></a>
        <%}
            if("invalid".equals(msg)){%>
                <h3>Nie udało się zarejestrować.</h3>
        <a href="index.jsp"><button>Strona główna</button></a>
        <% }
        %>
    </div>

</body>
</html>
