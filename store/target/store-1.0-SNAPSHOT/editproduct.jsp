<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="com.store.ConnectionProvider" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Edytuj produkt</title>
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
    <%
        String prod= request.getParameter("prod");
        Integer typ_konta = (Integer) session.getAttribute("typ_konta");
        if(typ_konta!=2) {
            response.sendRedirect("index.jsp");
        }
        else
        {
            try{
                Connection con = ConnectionProvider.getCon();
                Statement st = con.createStatement();
                ResultSet rs = st.executeQuery("select * from products where id="+prod+";");
                if(rs.next()==true){

    %>
<div class="container">
    <div class="row justify-content-center">
        <div class="col-5">
            <h3>Edytuj produkt</h3><br>
            <form action="editProServlet?prod=<%=prod%>" method="post">
            Nazwa: <input type="text" name="nazwa" value='<%=rs.getString(2)%>' placeholder="Nazwa" required><br><br>
            Platforma: <input type="text" name="platforma" value='<%=rs.getString(3)%>' placeholder="Platforma" required><br><br>
            Kategoria: <input type="text" name="kategoria" value='<%=rs.getString(4)%>' placeholder="Kategoria" required><br><br>
            Opis: <input type="textarea" name="opis" value='<%=rs.getString(5)%>' placeholder="Opis" required><br><br>
            Zdjęcie: <input type="file" name="zdjecie" value=<%=rs.getString(6)%> placeholder="Zdjęcie" required><br><br>
            Ilość: <input type="number" name="ilosc" value=<%=rs.getString(7)%> placeholder="Ilość" required><br><br>
            Cena: <input type="number" step="0.01" value=<%=rs.getString(8)%> name="cena" placeholder="Cena" required><br><br>
            <input type="submit" value="Edytuj">
        </form>
        <a href="index.jsp"><button value="Anuluj">Anuluj</button></a>
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
        }
    %>
    <div>
        <%
            String msg= request.getParameter("msg");
            if("valid".equals(msg)){
        %>
        <h3>Udało się edytować produkt.</h3>
        <a href="index.jsp"><button>Strona główna</button></a>
        <%}
            if("invalid".equals(msg)){%>
        <h3>Nie udało się edytować produktu.</h3>
        <a href="index.jsp"><button>Strona główna</button></a>
        <% }
        %>
    </div>
</body>
</html>
