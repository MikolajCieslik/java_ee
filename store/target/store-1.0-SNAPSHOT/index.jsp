<%@ page import="java.sql.Connection" %>
<%@ page import="com.store.ConnectionProvider" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Strona główna sklepu</title>
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

            <a class="navbar-brand" href="edituser.jsp">Edytuj konto</a>
            <a class="navbar-brand" href="myorders.jsp">Moje zamówienia</a>
            <ul class="navbar-nav ml-auto">
                <li class="nav-item">
                    <a class="navbar-brand" href="cart.jsp"><svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-cart" viewBox="0 0 16 16">
                        <path d="M0 1.5A.5.5 0 0 1 .5 1H2a.5.5 0 0 1 .485.379L2.89 3H14.5a.5.5 0 0 1 .491.592l-1.5 8A.5.5 0 0 1 13 12H4a.5.5 0 0 1-.491-.408L2.01 3.607 1.61 2H.5a.5.5 0 0 1-.5-.5zM3.102 4l1.313 7h8.17l1.313-7H3.102zM5 12a2 2 0 1 0 0 4 2 2 0 0 0 0-4zm7 0a2 2 0 1 0 0 4 2 2 0 0 0 0-4zm-7 1a1 1 0 1 1 0 2 1 1 0 0 1 0-2zm7 0a1 1 0 1 1 0 2 1 1 0 0 1 0-2z"/>
                    </svg></a>
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
        <div class="card-deck">
        <%
            try{
                Connection con = ConnectionProvider.getCon();
                Statement st = con.createStatement();
                ResultSet rs = st.executeQuery("select * from products");
                while (rs.next()){
        %>
                <div class="card mb-3" style="min-width: 18rem; max-width: 18rem;">
                    <a href="product.jsp?prod=<%=rs.getString(1)%>"><img class="card-img-top" src="<%=rs.getString(6)%>" alt="Card image cap"></a>
                    <div class="card-body">
                        <h5 class="card-title"><a href="product.jsp?prod=<%=rs.getString(1)%>"><%=rs.getString(2)%></a></h5>
                        <p class="card-text">Cena: <%=rs.getDouble(8)%></p>
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