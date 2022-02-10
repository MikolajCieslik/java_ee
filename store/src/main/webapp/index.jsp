<%@ page import="java.sql.Connection" %>
<%@ page import="com.store.ConnectionProvider" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Strona główna sklepu</title>
</head>
<body>
    <h1><%= "Hello World!" %>
    </h1>
    <br/>
    <a href="hello-servlet">Hello Servlet</a><br>
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
            <a href="register.jsp">Rejestracja</a><br>
            <a href="login.jsp">Zaloguj</a>
        <%
        }
        else{
            if(typ==1)
            {
                %>
                <a href="${pageContext.request.contextPath}/LogoServlet">Wyloguj</a>
                <%
            }
            if(typ==2)
            {
                %>
            <a href="${pageContext.request.contextPath}/LogoServlet">Wyloguj</a><br>
            <a href="addproduct.jsp">Dodaj produkt</a>
            <h2>Konto admina</h2>
                <%
            }
            if(typ==0)
            {
                %>
            <a href="register.jsp">Rejestracja</a><br>
            <a href="login.jsp">Zaloguj</a>
            <%
            }
        }

    %>
    <table>
    <%
        try{
            Connection con = ConnectionProvider.getCon();
            Statement st = con.createStatement();
            ResultSet rs = st.executeQuery("select * from products");
            while (rs.next()){
    %>
                <tr>
                    <td><a href="product.jsp?prod=<%=rs.getString(1)%>"><%=
                        rs.getString(2)
                    %></a></td>
                    <td><%=
                        rs.getString(3)
                    %></td>
                    <td><%=
                        rs.getString(4)
                    %></td>
                    <td><a href="product.jsp?prod=<%=rs.getString(1)%>">
                        <img src=<%=
                        rs.getString(6)
                    %>></a></td>
                    <td><%=
                        rs.getInt(7)
                    %></td>
                    <td><%=
                        rs.getDouble(8)
                    %></td>
                    <%
                        if(typ==2)
                        {
                            %>
                            <td><a href="editproduct.jsp?prod=<%=rs.getString(1)%>">Edytuj</a></td>
                    <%
                        }
                    %>
                </tr>
    <%
            }
            rs.close();
            st.close();
            con.close();
        } catch(Exception e){
            e.printStackTrace();
        }

    %>
    </table>
</body>
</html>