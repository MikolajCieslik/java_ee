<%@ page import="java.sql.Connection" %>
<%@ page import="com.store.ConnectionProvider" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <%
        Integer typ = (Integer) session.getAttribute("typ_konta");
        String nr= request.getParameter("nr");
        try{
            Connection con = ConnectionProvider.getCon();
            Statement st = con.createStatement();
            ResultSet rs = st.executeQuery("select * from orders where id="+nr+";");
            if(rs.next()==true){
    %>
    <title>Zamówienie nr <%=rs.getInt(1)%></title>
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
            }
            }catch (Exception e){

                }
        %>
    </nav>
</body>
</html>
