<%@ page import="java.sql.Connection" %>
<%@ page import="com.store.ConnectionProvider" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <%
        Integer typ = (Integer) session.getAttribute("typ_konta");
        String nr= request.getParameter("id");
        try{
            Connection con = ConnectionProvider.getCon();
            Statement st = con.createStatement();
            ResultSet rs = st.executeQuery("select o.*, p.nazwa, p.platforma from orders o, products p where p.id=o.product_id and o.id="+nr+";");
            if(rs.next()==true){
    %>
    <title>Zamówienie nr <%=rs.getInt(1)%></title>
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
    <h3>Zamówienie numer <%=rs.getInt(1)%></h3>
    <p>Adres i rodzaj dostawy:</p>
    <p>Rodzaj dostawy: <%=rs.getString(6)%></p>
    <p>Klient: <%=rs.getString(7)+" "+rs.getString(8)%></p>
    <p>Kod pocztowy: <%=rs.getString(9)%></p>
    <p>Miasto: <%=rs.getString(10)%></p>
    <p>Ulica: <%=rs.getString(11)%></p>
    <p> Nummer telefonu: <%=rs.getString(12)%></p>
    <h3>Zamówione produkty:</h3>
    <table>
        <tr><th>Nazwa produktu</th><th></th><th>Platforma</th><th></th><th>Ilość</th><th></th><th>Cena</th></tr>
        <tr><td><a href="product.jsp?prod=<%=rs.getInt(3)%>"><%=rs.getString(13)%></a></td><td></td><td><%=rs.getString(14)%></td><td></td><td><%=rs.getInt(4)%></td><td></td><td><%=rs.getDouble(5)%></td></tr>
        <%
            double price= rs.getDouble(5);
            if(rs.getString(6).equals("Poczta"))
            {
                price+=12;
            }
            else if(rs.getString(6).equals("Kurier"))
            {
                price+=20;
            }
            while(rs.next())
            {
                %>
        <tr><td><a href="product.jsp?prod=<%=rs.getInt(3)%>"><%=rs.getString(13)%></a></td><td></td><td><%=rs.getString(14)%></td><td></td><td><%=rs.getInt(4)%></td><td></td><td><%=rs.getDouble(5)%></td></tr>
                <%
                price+=rs.getDouble(5);
            }
            %>
        </table><br>
        <p>Wartość zamówienia z wysyłką: <%=price%></p>
    <%
        }
        %>

    <%
        rs.close();
        st.close();
        con.close();
        } catch (Exception e){
        e.printStackTrace();
        }
    %>
</div>
</div>
</div>
</body>
</html>
