package com.store;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Statement;

@WebServlet(name= "editUserServlet", urlPatterns = {"/editUserServlet"})
public class EditUserServlet extends HttpServlet{

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();
        Integer typ_konta = (Integer) session.getAttribute("typ_konta");
        String ids = (String) session.getAttribute("id");
        Integer id = Integer.parseInt(ids);
        if(typ_konta==0) {
            response.sendRedirect("index.jsp");
        }
        String login = request.getParameter("login");
        String haslo = request.getParameter("haslo");
        String imie = request.getParameter("imie");
        String nazwisko = request.getParameter("nazwisko");
        String kod_pocztowy = request.getParameter("kod_pocztowy");
        String miejscowosc = request.getParameter("miejscowosc");
        String adres = request.getParameter("adres");
        String numer = request.getParameter("numer");
        Connection con = ConnectionProvider.getCon();
        try {
            Statement st = con.createStatement();
            String sql = "Update users set login='"+login+"', haslo='"+haslo+"', imie='"+imie+"', nazwisko='"+nazwisko+"', kod_pocztowy='"+kod_pocztowy+
                    "', miejscowosc='"+miejscowosc+"', adres='"+adres+"', numer='"+numer+"' where id="+id+";";
            Integer insertedRows = st.executeUpdate(sql);
            st.close();
            con.close();
            response.sendRedirect("edituser.jsp?msg=valid");

        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("edituser.jsp?msg=invalid");

        }
    }
}
