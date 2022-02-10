<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Dodaj produkt</title>
</head>
<body>
    <%
        Integer typ_konta = (Integer) session.getAttribute("typ_konta");
        if(typ_konta!=2) {
            response.sendRedirect("index.jsp");
        }
        else
        {
            %>
            <div id="container">
                <form action="addServlet" method="post">
                    Nazwa: <input type="text" name="nazwa" placeholder="Nazwa" required><br><br>
                    Platforma: <input type="text" name="platforma" placeholder="Platforma" required><br><br>
                    Kategoria: <input type="text" name="kategoria" placeholder="Kategoria" required><br><br>
                    Opis: <input type="textbox" name="opis" placeholder="Opis" required><br><br>
                    Zdjęcie: <input type="file" name="zdjecie" placeholder="Zdjęcie" required><br><br>
                    Ilość: <input type="number" name="ilosc" placeholder="Ilość" required><br><br>
                    Cena: <input type="number" step="0.01" name="cena" placeholder="Cena" required><br><br>
                    <input type="submit" value="Dodaj">
                </form>
            </div>
            <%
        }
    %>
    <div>
        <%
            String msg= request.getParameter("msg");
            if("valid".equals(msg)){
        %>
        <h3>Udało się dodać produkt.</h3>
        <a href="index.jsp"><button>Strona główna</button></a>
        <%}
            if("invalid".equals(msg)){%>
        <h3>Nie udało się dodać produktu.</h3>
        <a href="index.jsp"><button>Strona główna</button></a>
        <% }
        %>
    </div>
</body>
</html>
