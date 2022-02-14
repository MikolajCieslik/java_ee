package com.store;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

@WebServlet(name= "addToCartServlet", urlPatterns = {"/addToCartServlet"})
public class AddToCartServlet extends HttpServlet{
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();
        Integer typ_konta = (Integer) session.getAttribute("typ_konta");
        String prod= request.getParameter("prod");
        if(typ_konta==1){
            String id = session.getAttribute("id").toString();
            Integer ilosc = Integer.valueOf(request.getParameter("ilosc"));
            Double cena = 0.0;
            Connection con = ConnectionProvider.getCon();
            try {
                Statement st = con.createStatement();
                ResultSet rs = st.executeQuery("select cena from products where id='"+prod+"'");
                if(rs.next()==true) {

                    cena= rs.getDouble(1);
                }
                String sql = "Insert into cart values('" + id + "','" + prod + "','" + ilosc + "','" + ilosc*cena +"');";
                Integer insertedRows = st.executeUpdate(sql);
                rs.close();
                st.close();
                con.close();
                response.sendRedirect("product.jsp?prod="+prod);
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        else{
            response.sendRedirect("index.jsp");
        }


    }
}
