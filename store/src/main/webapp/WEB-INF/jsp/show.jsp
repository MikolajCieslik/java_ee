<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Title</title>
    </head>
    <body>
    <form:form method="post" modelAttribute="user">
        <table border="1" >
            <tr><td>Imię</td><td><form:input path="imie"/>
                <font color="red"><form:errors path="imie"/></font>
            </td></tr>
            <tr><td>Nazwisko</td><td><form:input path="nazwisko"/>
                <font color="red"><form:errors path="nazwisko"/></font>
            </td></tr>
<%--            <tr><td>Numer rejestracyjny</td><td><form:input path="numerRejestracyjny"/>--%>
<%--                <font color="red"><form:errors path="numerRejestracyjny"/></font>--%>
<%--            </td></tr>--%>
        </table>
    <input type="submit" value="zapisz"/>
    </form:form>
    </body>
</html>
