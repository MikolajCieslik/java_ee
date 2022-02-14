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

@WebServlet(name= "addProductServlet", urlPatterns = {"/addServlet"})
public class AddProductServlet extends HttpServlet{

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();
        Integer typ_konta = (Integer) session.getAttribute("typ_konta");
        if(typ_konta==2){
            String nazwa = request.getParameter("nazwa");
            String platforma = request.getParameter("platforma");
            String kategoria = request.getParameter("kategoria");
            String opis = request.getParameter("opis");
            String zdjecie = request.getParameter("zdjecie");
            Integer ilosc = Integer.parseInt(request.getParameter("ilosc"));
            Double cena = Double.parseDouble(request.getParameter("cena"));
            Connection con = ConnectionProvider.getCon();
            //TODO: naprawić wstawianie zdjęć żeby nie trzeba było resetować serwera
            try {
                Statement st = con.createStatement();
                String sql = "Insert into products(nazwa, platforma, kategoria, opis, zdjecie, ilosc, cena) values('"
                        + nazwa + "','" + platforma + "','" + kategoria + "','" + opis + "',' zdjecia/" + zdjecie + "','" + ilosc +
                        "','" + cena + "');";
                Integer insertedRows = st.executeUpdate(sql);
                st.close();
                con.close();
                response.sendRedirect("addproduct.jsp?msg=valid");

            } catch (SQLException e) {
                e.printStackTrace();
                response.sendRedirect("addproduct.jsp?msg=invalid");

            }
        }
        else{
            response.sendRedirect("index.jsp");
        }


    }
}
