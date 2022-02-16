package com.store;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Statement;


@WebServlet(name= "RegisterServlet", urlPatterns = {"/RegServlet"})
public class RegisterServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        String login = request.getParameter("login");
        String haslo = request.getParameter("haslo");
        Integer typ_konta = 1;
        String imie = request.getParameter("imie");
        String nazwisko = request.getParameter("nazwisko");
        String kod_pocztowy = request.getParameter("kod_pocztowy");
        String miejscowosc = request.getParameter("miejscowosc");
        String adres = request.getParameter("adres");
        String numer = request.getParameter("numer");
        Connection con = ConnectionProvider.getCon();
        try {
            Statement st = con.createStatement();
            String sql = "Insert into users(login, haslo, typ_konta, imie, nazwisko, kod_pocztowy, miejscowosc, adres, numer) values('"
                    + login + "','" + haslo + "','" + typ_konta + "','" + imie + "','" + nazwisko + "','" + kod_pocztowy +
                    "','" + miejscowosc + "','" + adres + "','" + numer + "');";
            Integer insertedRows = st.executeUpdate(sql);
            st.close();
            con.close();
            response.sendRedirect("register.jsp?msg=valid");

        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("register.jsp?msg=invalid");


        }

    }
}
