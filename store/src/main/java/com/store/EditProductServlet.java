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

@WebServlet(name= "editProductServlet", urlPatterns = {"/editProServlet"})
public class EditProductServlet extends HttpServlet{

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        String prod= request.getParameter("prod");
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
            try {
                Statement st = con.createStatement();
                String sql = "Update products set nazwa='"+nazwa+"', platforma='"+platforma+"', kategoria='"+kategoria+"', opis='"+opis+"', zdjecie='zdjecia/"+zdjecie+
                        "', ilosc='"+ilosc+"', cena='"+cena+"' where id="+prod+";";
                Integer insertedRows = st.executeUpdate(sql);
                st.close();
                con.close();
                response.sendRedirect("editproduct.jsp?msg=valid");

            } catch (SQLException e) {
                e.printStackTrace();
                response.sendRedirect("editproduct.jsp?msg=invalid");

            }
        }
        else{
            response.sendRedirect("index.jsp");
        }


    }
}
