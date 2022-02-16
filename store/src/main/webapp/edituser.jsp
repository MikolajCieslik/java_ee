<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="com.store.ConnectionProvider" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Edytuj konto</title>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-dark bg-primary">
    <ul class="navbar-nav me-auto mb-2 mb-lg-0">
        <li class="nav-item">
            <a class="navbar-brand" href="index.jsp">Strona główna</a>
        </li>
        <li class="nav-item dropdown">
            <a class="navbar-brand dropdown-toggle" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                Platforma
            </a>
            <ul class="dropdown-menu" aria-labelledby="navbarDropdown">
                <li><a class="dropdown-item" href="platform_list.jsp?platform=Playstation 4">Playstation 4</a></li>
                <li><a class="dropdown-item" href="platform_list.jsp?platform=Playstation 5">Playstation 5</a></li>
                <li><a class="dropdown-item" href="platform_list.jsp?platform=PC">PC</a></li>
                <li><a class="dropdown-item" href="platform_list.jsp?platform=Xbox one">Xbox one</a></li>
            </ul>
        </li>
    </ul>
    <%
        Integer typ;
        if(session.isNew()){
            typ = 0;
            session.setAttribute("typ_konta",0);
        }
        else{
            typ = (Integer) session.getAttribute("typ_konta");
        }
        if(typ == null)
        {
    %>
    <ul class="navbar-nav ml-auto">
        <li class="nav-item">
            <a class="navbar-brand" href="register.jsp">Rejestracja</a>
            <a class="navbar-brand" href="login.jsp">Logowanie</a>
        </li>
    </ul>
    <%
    }
    else{
        if(typ==1)
        {
    %>
    <a class="navbar-brand" href="myorders.jsp">Moje zamówienia</a>
    <ul class="navbar-nav ml-auto">
        <li class="nav-item">
            <a class="navbar-brand" href="cart.jsp">Koszyk</a>
            <a class="navbar-brand" href="${pageContext.request.contextPath}/LogoServlet">Wyloguj</a>
        </li>
    </ul>
    <%
        }
        if(typ==2)
        {
    %>
    <a class="navbar-brand" href="addproduct.jsp">Dodaj produkt</a>
    <a class="navbar-brand ml-auto" href="${pageContext.request.contextPath}/LogoServlet">Wyloguj</a>
    <%
        }
        if(typ==0)
        {
    %>
    <ul class="navbar-nav ml-auto">
        <li class="nav-item">
            <a class="navbar-brand" href="register.jsp">Rejestracja</a>
            <a class="navbar-brand" href="login.jsp">Logowanie</a>
        </li>
    </ul>
    <%
            }
        }
    %>
</nav><br><br>
    <%
        Integer typ_konta = (Integer) session.getAttribute("typ_konta");
        String id = (String) session.getAttribute("id");
        if(typ_konta==0) {
            response.sendRedirect("index.jsp");
        }
        else
        {
            try{
                Connection con = ConnectionProvider.getCon();
                Statement st = con.createStatement();
                ResultSet rs = st.executeQuery("select * from users where id="+id+";");
                if(rs.next()==true){
    %>
    <div id="container">
        <div class="row justify-content-center">
            <div class="col-3">
                <h3>Edytuj konto</h3><br>
        <form action="editUserServlet" method="post">
            Login: <input type="text" name="login" value="<%=rs.getString(2)%>" placeholder="Login" required><br><br>
            Hasło: <input type="password" name="haslo" value="<%=rs.getString(3)%>" placeholder="Hasło" required><br><br>
            Imię: <input type="text" name="imie" value="<%=rs.getString(5)%>" placeholder="Imię" required><br><br>
            Nazwisko: <input type="text" name="nazwisko" value="<%=rs.getString(6)%>" placeholder="Nazwisko" required><br><br>
            Kod pocztowy: <input type="text" name="kod_pocztowy" value="<%=rs.getString(7)%>" placeholder="Kod pocztowy" required><br><br>
            Miejscowość: <input type="text" name="miejscowosc" value="<%=rs.getString(8)%>" placeholder="Miejscowość" required><br><br>
            Adres: <input type="text" name="adres" value="<%=rs.getString(9)%>" placeholder="Adres" required><br><br>
            Numer: <input type="text" name="numer" value="<%=rs.getString(10)%>" placeholder="Numer telefonu" required><br><br>
            <input type="submit" value="Edytuj">
        </form>
        <a href="index.jsp"><button value="Anuluj">Anuluj</button></a>
    </div>
    </div>
    </div>
    <%
                }
                rs.close();
                st.close();
                con.close();
            } catch(Exception e){
                e.printStackTrace();

            }
        }
    %>
    <div>
        <%
            String msg= request.getParameter("msg");
            if("valid".equals(msg)){
        %>
        <h3>Udało się edytować konto.</h3>
        <a href="index.jsp"><button>Strona główna</button></a>
        <%}
            if("invalid".equals(msg)){%>
        <h3>Nie udało się edytować konta.</h3>
        <a href="index.jsp"><button>Strona główna</button></a>
        <% }
        %>
    </div>
</body>
</html>
