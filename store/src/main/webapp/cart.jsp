<%@ page import="java.sql.Connection" %>
<%@ page import="com.store.ConnectionProvider" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Koszyk</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-light bg-light">
    <a class="navbar-brand" href="index.jsp">Strona główna</a>
    <%
        Integer typ;
        typ = (Integer) session.getAttribute("typ_konta");
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
    <a class="navbar-brand ml-auto" href="${pageContext.request.contextPath}/LogoServlet">Wyloguj</a>
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
            response.sendRedirect("index.jsp");
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
    <table>

    <%
        String id = session.getAttribute("id").toString();
        try {
            Connection con = ConnectionProvider.getCon();
            Statement st = con.createStatement();
            ResultSet rs = st.executeQuery("select p.id, p.nazwa, p.platforma, c.amount, c.price from cart c, products p where c.user_id="+id+" and c.product_id=p.id;");
            if(rs.next()==true)
            {
                %>
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
    %>
    </table>
</div>
</body>
</html>
