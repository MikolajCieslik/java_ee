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
    <h2><%=rs.getString(2)%></h2><br>
    <img src=<%=rs.getString(6)%>><br>
    Platforma: <%=rs.getString(3)%><br>
    <%=rs.getString(4)%><br>
    <%=rs.getString(5)%><br>
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
                %>
                <form action="addToCartServlet?prod=<%=prod%>" method="post">
                    <select id="ilosc" name="ilosc">
                    <%
                    if(rs2.next()==true)
                    {
                        for(int i=1;i< (rs2.getInt(1)+1);i++)
                        {
                            %>
                        <option value="<%=i%>"><%=i%></option><%
                        }
                    }
                %>
                </select>
                <input type="submit" value="Dodaj do koszyka">
                </form>
                <%
                        rs2.close();
                    }
            if(typ==2)
            {
                %>
            <a href="editproduct.jsp?prod=<%=rs.getString(1)%>"><button>Edytuj</button></a>
            <%
            }
            rs.close();
            st.close();
            con.close();
        } catch (Exception e){
            e.printStackTrace();
        }
    %>
</body>
</html>
