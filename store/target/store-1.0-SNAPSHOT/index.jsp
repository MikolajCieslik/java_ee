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
    <div class="container">
        <div class="card-deck">
        <%
            try{
                Connection con = ConnectionProvider.getCon();
                Statement st = con.createStatement();
                ResultSet rs = st.executeQuery("select * from products where ilosc>0");
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
</body>
</html>