<%@ page import="java.sql.Connection" %>
<%@ page import="com.store.ConnectionProvider" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="com.mysql.cj.Session" %>
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
</head>
<body>
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
