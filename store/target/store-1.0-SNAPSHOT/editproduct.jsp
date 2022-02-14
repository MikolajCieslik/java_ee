<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="com.store.ConnectionProvider" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Edytuj produkt</title>
</head>
<body>
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
    <div id="container">
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
