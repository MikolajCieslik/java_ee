<%@ page import="java.sql.Connection" %>
<%@ page import="com.store.ConnectionProvider" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <%
        Integer typ = (Integer) session.getAttribute("typ_konta");
        String prod= request.getParameter("prod");
        try{
            Connection con = ConnectionProvider.getCon();
            Statement st = con.createStatement();
            ResultSet rs = st.executeQuery("select * from products where id="+prod+";");
            if(rs.next()==true){
    %>
    <title><%=rs.getString(2)%></title>
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
    </nav><br><br>
    <div class="container">
    <div class="row justify-content-center">
        <div class="col-5">
    <h3><%=rs.getString(2)%></h3><br>
        </div>
        </div>
        <div class="row justify-content-center">
        <div class="col-5">
        <img src="<%=rs.getString(6)%>" style="height: 85%; width: 85%"><br>
        </div>
        <div class="col-5">
            Platforma: <%=rs.getString(3)%><br>
            <%=rs.getString(4)%><br>
            <%=rs.getString(5)%><br><br>
            Ilość: <%=rs.getInt(7)%><br>
            Cena: <%=rs.getDouble(8)%><br>
    <%
            }
            else
            {
    %>
    <h1>Wybrany produkt nie istnieje</h1>
    <%
            }
            if(typ==1)
            {
                ResultSet rs2 = st.executeQuery("select ilosc from products where id="+prod+";");
                if(rs2.next()==true)
                {
                    if(rs2.getInt(1)==0)
                    {
                        %>
                        <h5>Brak produktu w magazynie</h5>
                        <%
                    }
                    else{
                %>
            <br>
                <form action="addToCartServlet?prod=<%=prod%>" method="post">
                    <select id="ilosc" name="ilosc">
                    <%
                            for(int i=1;i< (rs2.getInt(1)+1);i++)
                            {
                                %>
                            <option value="<%=i%>"><%=i%></option><%
                            }
                    %>
                </select><br><br>
                <input type="submit" value="Dodaj do koszyka">
                </form>
                <%
                            }
                        }
                        rs2.close();
                    }
            if(typ==2)
            {
                %>
            <br>
            <a href="editproduct.jsp?prod=<%=rs.getString(1)%>"><button>Edytuj</button></a>
        </div>
            <div class="col-5">
            </div>
        </div>
            <%
            }
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
