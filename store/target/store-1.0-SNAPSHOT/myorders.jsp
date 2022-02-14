<%@ page import="java.sql.Connection" %>
<%@ page import="com.store.ConnectionProvider" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Moje zamówienia</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-light bg-light">
        <a class="navbar-brand" href="index.jsp">Strona główna</a>
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
    <div id="container">
        <table>
        <%
            if(typ==1){
                try{
                    Connection con = ConnectionProvider.getCon();
                    Statement st = con.createStatement();
                    ResultSet rs = st.executeQuery("select o.id, p.nazwa, p.platforma, o.amount, o.price, o.delivery from orders o, products p where p.id=o.product_id and user_id="+session.getAttribute("id"));
                    if(rs.next()==true)
                    {
                    %>
                        <tr><td><%=rs.getInt(1)%></td><td></td><td><%=rs.getString(2)%></td><td></td><td><%=rs.getString(3)%></td><td></td><td><%=rs.getInt(4)%></td><td><%=rs.getInt(5)%></td><td><%=rs.getString(6)%></td></tr>
                        <%
                            while (rs.next())
                            {
                                %>
                                <tr><td><%=rs.getInt(1)%></td><td></td><td><%=rs.getString(2)%></td><td></td><td><%=rs.getString(3)%></td><td></td><td><%=rs.getInt(4)%></td><td><%=rs.getInt(5)%></td><td><%=rs.getString(6)%></td></tr></tr>
                                <%
                            }
                        %>
                        <%--                    <form action="delallCartServlet" method="post">--%>
                        <%--                        <input type="submit" value="Opróżnij koszyk">--%>
                        <%--                    </form>--%>
                        <%
                        }
                        else
                        {
                        %>
                            <p>Historia zamówień jest pusta</p>
                        <%
                        }
                        rs.close();
                        st.close();
                        con.close();
                    } catch(Exception e){
                        e.printStackTrace();
                    }
            }
            else{
                response.sendRedirect("index.jsp");
                }
        %>
        </table>
    </div>
</body>
</html>