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
        Integer typ = (Integer) session.getAttribute("typ_konta");
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
            <a href="${pageContext.request.contextPath}/LogoServlet">Wyloguj</a>
            <h2>Konto admina</h2>
                <%
            }
            else{

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
                    <td><%=
                        rs.getString(2)
                        %></td>
                    <td><%=
                        rs.getString(3)
                    %></td>
                    <td><%=
                        rs.getString(4)
                    %></td>
                    <td><%=
                        rs.getString(5)
                    %></td>
                    <td><img src=<%=
                        rs.getString(6)
                    %>></td>
                    <td><%=
                        rs.getInt(7)
                    %></td>
                    <td><%=
                        rs.getDouble(8)
                    %></td>
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
    <%--<img src="zdjecia/deathstranding.png">--%>
</body>
</html>