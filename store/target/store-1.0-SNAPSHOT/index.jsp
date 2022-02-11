<%@ page import="java.sql.Connection" %>
<%@ page import="com.store.ConnectionProvider" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Strona główna sklepu</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-light bg-light">
        <a class="navbar-brand" href="index.jsp">Strona główna</a>
<%--        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">--%>
<%--            <span class="navbar-toggler-icon"></span>--%>
<%--        </button>--%>


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
        <div class="card-deck">
        <%
            try{
                Connection con = ConnectionProvider.getCon();
                Statement st = con.createStatement();
                ResultSet rs = st.executeQuery("select * from products");
                while (rs.next()){
        %>
                <div class="card mb-3" style="min-width: 18rem; max-width: 18rem;">
                    <img class="card-img-top" src="<%=rs.getString(6)%>" alt="Card image cap">
                    <div class="card-body">
                        <h5 class="card-title"><a href="product.jsp?prod=<%=rs.getString(1)%>"><%=rs.getString(2)%></a></h5>
                        <p class="card-text">Cena:<%=rs.getDouble(8)%></p>
                        <%
                            if(typ==2)
                            {
                        %>
                        <td><a href="editproduct.jsp?prod=<%=rs.getString(1)%>">Edytuj</a></td>
                        <%
                            }
                        %>
                    </div>
                </div>

<%--        <div class="card">--%>
<%--            <div class="card-body">--%>
<%--                <h5 class="card-title"><a href="product.jsp?prod=<%=rs.getString(1)%>"><%=rs.getString(2)%></a></h5>--%>
<%--                <img class="card-img" src="<%=rs.getString(6)%>" alt="Card image cap">--%>
<%--                <p class="card-text">Cena:<%=rs.getDouble(8)%></p>--%>
<%--                <%--%>
<%--                    if(typ==2)--%>
<%--                    {--%>
<%--                %>--%>
<%--                <td><a href="editproduct.jsp?prod=<%=rs.getString(1)%>">Edytuj</a></td>--%>
<%--                <%--%>
<%--                    }--%>
<%--                %>--%>
<%--            </div>--%>
<%--        </div>--%>
<%--        <div class="card">--%>
<%--            <img class="card-img-top" src="..." alt="Card image cap">--%>
<%--            <div class="card-body">--%>
<%--                <h5 class="card-title">Card title</h5>--%>
<%--                <p class="card-text">This card has supporting text below as a natural lead-in to additional content.</p>--%>
<%--                <p class="card-text"><small class="text-muted">Last updated 3 mins ago</small></p>--%>
<%--            </div>--%>
<%--        </div>--%>
<%--        <div class="card">--%>
<%--            <img class="card-img-top" src="..." alt="Card image cap">--%>
<%--            <div class="card-body">--%>
<%--                <h5 class="card-title">Card title</h5>--%>
<%--                <p class="card-text">This is a wider card with supporting text below as a natural lead-in to additional content. This card has even longer content than the first to show that equal height action.</p>--%>
<%--                <p class="card-text"><small class="text-muted">Last updated 3 mins ago</small></p>--%>
<%--            </div>--%>
<%--        </div>--%>
<%--    <table>--%>

<%--                <tr>--%>
<%--                    <td><a href="product.jsp?prod=<%=rs.getString(1)%>"><%=rs.getString(2)%></a></td>--%>
<%--                    <td><%=rs.getString(3)%></td>--%>
<%--                    <td><%=rs.getString(4)%></td>--%>
<%--                    <td><a href="product.jsp?prod=<%=rs.getString(1)%>">--%>
<%--                        <img src="<%=rs.getString(6)%>" width="100px"></a></td>--%>
<%--                    <td><%=rs.getInt(7)%></td>--%>
<%--                    <td><%=rs.getDouble(8)%></td>--%>
<%--                    <%--%>
<%--                        if(typ==2)--%>
<%--                        {--%>
<%--                            %>--%>
<%--                            <td><a href="editproduct.jsp?prod=<%=rs.getString(1)%>">Edytuj</a></td>--%>
<%--                    <%--%>
<%--                        }--%>
<%--                    %>--%>
<%--                </tr>--%>
    <%
            }
            rs.close();
            st.close();
            con.close();
        } catch(Exception e){
            e.printStackTrace();
        }

    %>
        </div>
    </div>
    <%--    </table>--%>
</body>
</html>