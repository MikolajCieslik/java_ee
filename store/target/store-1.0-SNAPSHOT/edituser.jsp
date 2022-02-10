<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="com.store.ConnectionProvider" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Edytuj konto</title>
</head>
<body>
    <%
        Integer typ_konta = (Integer) session.getAttribute("typ_konta");
        String id = (String) session.getAttribute("id");
        if(typ_konta==0) {
            response.sendRedirect("index.jsp");
        }
        else
        {
            try{
                Connection con = ConnectionProvider.getCon();
                Statement st = con.createStatement();
                ResultSet rs = st.executeQuery("select * from users where id="+id+";");
                if(rs.next()==true){
    %>
    <div id="container">
        <form action="editUserServlet" method="post">
            Login: <input type="text" name="login" value="<%=rs.getString(2)%>" placeholder="Login" required><br><br>
            Hasło: <input type="password" name="haslo" value="<%=rs.getString(3)%>" placeholder="Hasło" required><br><br>
            Imię: <input type="text" name="imie" value="<%=rs.getString(5)%>" placeholder="Imię" required><br><br>
            Nazwisko: <input type="text" name="nazwisko" value="<%=rs.getString(6)%>" placeholder="Nazwisko" required><br><br>
            Kod pocztowy: <input type="text" name="kod_pocztowy" value="<%=rs.getString(7)%>" placeholder="Kod pocztowy" required><br><br>
            Miejscowość: <input type="text" name="miejscowosc" value="<%=rs.getString(8)%>" placeholder="Miejscowość" required><br><br>
            Adres: <input type="text" name="adres" value="<%=rs.getString(9)%>" placeholder="Adres" required><br><br>
            Numer: <input type="text" name="numer" value="<%=rs.getString(10)%>" placeholder="Numer telefonu" required><br><br>
            <input type="submit" value="Edytuj">
        </form>
        <a href="index.jsp"><button value="Anuluj">Anuluj</button></a>
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
        <h3>Udało się edytować konto.</h3>
        <a href="index.jsp"><button>Strona główna</button></a>
        <%}
            if("invalid".equals(msg)){%>
        <h3>Nie udało się edytować konta.</h3>
        <a href="index.jsp"><button>Strona główna</button></a>
        <% }
        %>
    </div>
</body>
</html>
