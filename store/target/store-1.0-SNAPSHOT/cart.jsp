<%@ page import="java.sql.Connection" %>
<%@ page import="com.store.ConnectionProvider" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Koszyk</title>
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
                <li><a class="dropdown-item" href="platform_list.jsp?platform=Nintendo Switch">Nintendo Switch</a></li>
                <li><a class="dropdown-item" href="platform_list.jsp?platform=Xbox Series X/S">Xbox Series X/S</a></li>
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

    <a class="navbar-brand" href="edituser.jsp">Edytuj konto</a>
    <a class="navbar-brand" href="myorders.jsp">Moje zamówienia</a>
    <ul class="navbar-nav ml-auto">
        <li class="nav-item">
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
<div class="container">
    <div class="row justify-content-center">
        <div class="col-5">
            <h3>Koszyk</h3><br>
    <%
        String msg= request.getParameter("error");
        if("error".equals(msg)){
    %>
    <h3>Wystąpił błąd podczas składania zamówienia.</h3>
    <a href="index.jsp"><button>Strona główna</button></a>
    <%}
        else {
    %>

    <%
        String id = session.getAttribute("id").toString();
        try {
            Connection con = ConnectionProvider.getCon();
            Statement st = con.createStatement();
            Statement st2 = con.createStatement();
            ResultSet rs = st.executeQuery("select p.id, p.nazwa, p.platforma, c.amount, c.price from cart c, products p where c.user_id="+id+" and c.product_id=p.id;");

            ResultSet rs2 = st2.executeQuery("select imie, nazwisko, kod_pocztowy, miejscowosc, adres, numer from users where id="+id+";");
            if(rs2.next()==true){
        %>
        <form action="OrderServlet" method="post">
            Imię: <input type="text" name="imie" value="<%=rs2.getString(1)%>" required><br><br>
            Nazwisko: <input type="text" name="nazwisko" value="<%=rs2.getString(2)%>" required><br><br>
            Kod pocztowy: <input type="text" name="kod_pocztowy" value="<%=rs2.getString(3)%>" required><br><br>
            Miejscowość: <input type="text" name="miejscowosc" value="<%=rs2.getString(4)%>" required><br><br>
            Adres: <input type="text" name="adres" value="<%=rs2.getString(5)%>" required><br><br>
            Numer: <input type="text" name="numer" value="<%=rs2.getString(6)%>" required><br><br>
            <select id="delivery" name="delivery">
                <option value="Poczta">Poczta +12 zł</option>
                <option value="Kurier">Kurier +20 zł</option>
            </select><br><br>
            <input type="submit" value="Zakup">
        </form><br><br>
        <%
            }
            if(rs.next()==true)
            {
                %>
        <h4>Zawartość koszyka</h4>
            <table>
                <tr><td><%=rs.getString(2)%></td><td></td><td><%=rs.getString(3)%></td><td></td><td><%=rs.getInt(4)%></td><td></td><td><%=rs.getDouble(5)%></td>
                    <td>
                        <form action="delCartServlet?prod=<%=rs.getString(1)%>" method="post">
                            <input type="submit" value="Usuń">
                        </form>
                    </td></tr>
                <%
                while (rs.next())
                {
                    %>
                <tr><td><%=rs.getString(2)%></td><td></td><td><%=rs.getString(3)%></td><td></td><td><%=rs.getInt(4)%></td><td></td><td><%=rs.getDouble(5)%></td>
                    <td>
                        <form action="delCartServlet?prod=<%=rs.getString(1)%>" method="post">
                            <input type="submit" value="Usuń">
                        </form>
                    </td></tr>
                    <%
                }
                %>
            </table><br>
            <form action="delallCartServlet" method="post">
                    <input type="submit" value="Opróżnij koszyk">
                </form>

            <%
                }
            else
            {
                %>
                    <p>Koszyk jest pusty</p>
                <%
            }

        } catch (Exception e){
            e.printStackTrace();
        }
        }
    %>
</div>
    </div>
</div>
</body>
</html>
