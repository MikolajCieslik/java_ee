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
<nav class="navbar navbar-expand-lg navbar-light bg-light">
    <a class="navbar-brand" href="index.jsp">Strona główna</a>
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
</nav>
<div class="container">
    <h3>Zamówienie numer <%=rs.getInt(1)%></h3><br>
    <p>Adres i rodzaj dostawy:</p><br>
    <p><%=rs.getString(6)%></p><br>
    <p><%=rs.getString(7)+" "+rs.getString(8)%></p><br>
    <p><%=rs.getString(9)%></p><br>
    <p><%=rs.getString(10)%></p><br>
    <p><%=rs.getString(11)%></p><br>
    <p><%=rs.getString(12)%></p><br>
    <h3>Zamówione produkty:</h3><br>
    <table>
        <tr><th>Nazwa produktu</th><th>Platforma</th><th>Ilość</th><th>Cena</th></tr>
        <tr><td><a href="product.jsp?prod=<%=rs.getInt(3)%>"><%=rs.getString(13)%></a></td><td><%=rs.getString(14)%></td><td><%=rs.getInt(4)%></td><td><%=rs.getDouble(5)%></td></tr>
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
        <tr><td><a href="product.jsp?prod=<%=rs.getInt(3)%>"><%=rs.getString(13)%></a></td><td><%=rs.getString(14)%></td><td><%=rs.getInt(4)%></td><td><%=rs.getDouble(5)%></td></tr>
                <%
                price+=rs.getDouble(5);
            }
            %>
        </table>
        <p>Wartość zamówienia: <%=price%></p>
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
</body>
</html>
