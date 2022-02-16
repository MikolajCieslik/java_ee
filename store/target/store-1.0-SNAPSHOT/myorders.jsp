<%@ page import="java.sql.Connection" %>
<%@ page import="com.store.ConnectionProvider" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Moje zamówienia</title>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-light bg-light">
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
    </nav><br><br>
    <div id="container">
        <div class="row justify-content-center">
            <div class="col-3">
                <h3>Historia zamówień</h3>
        <table>
        <%
            if(typ==1){
                try{
                    Connection con = ConnectionProvider.getCon();
                    Statement st = con.createStatement();
                    ResultSet rs = st.executeQuery("select o.id, o.price, o.delivery from orders o where o.user_id="+session.getAttribute("id")+" group by o.id");
                    double del=0;
                    if(rs.next()==true)
                    {
                        Statement st2 = con.createStatement();
                        ResultSet rs2 = st2.executeQuery("select sum(price) from orders where id="+rs.getInt(1)+";");
                        if(rs.getString(3).equals("Poczta")){
                            del=12;
                        }
                        else
                        {
                            del=20;
                        }
                        rs2.next();
                    %>
                    <tr><td><a href="order.jsp?id=<%=rs.getInt(1)%>"><%=rs.getInt(1)%></a></td><td></td><td><%=rs.getString(3)%></td><td></td><td><%=rs2.getDouble(1)+del%></td></tr>
                    <%
                        rs2.close();
                        while (rs.next())
                        {
                            if(rs.getString(3).equals("Poczta")){
                                del=12;
                            }
                            else
                            {
                                del=20;
                            }
                            rs2 = st2.executeQuery("select sum(price) from orders where id="+rs.getInt(1)+";");
                            rs2.next();
                            %>
                            <tr><td><a href="order.jsp?id=<%=rs.getInt(1)%>"><%=rs.getInt(1)%></a></td><td></td><td><%=rs.getString(3)%></td><td></td><td><%=rs2.getDouble(1)+del%></td></tr>
                            <%
                            rs2.close();
                            }
                        st2.close();
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
        </div>
    </div>
</body>
</html>