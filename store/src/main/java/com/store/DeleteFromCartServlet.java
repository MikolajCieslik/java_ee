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

@WebServlet(name= "deleteFromCartServlet", urlPatterns = {"/delCartServlet"})
public class DeleteFromCartServlet extends HttpServlet{
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();
        String prod= request.getParameter("prod");
        Integer typ_konta = (Integer) session.getAttribute("typ_konta");
        if(typ_konta==1){
            String id = session.getAttribute("id").toString();
            Connection con = ConnectionProvider.getCon();
            try {
                Statement st = con.createStatement();
                String sql = "Delete from cart where user_id = "+id+" and product_id="+prod+";";
                Integer deletedRows = st.executeUpdate(sql);
                st.close();
                con.close();
                response.sendRedirect("cart.jsp");
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        else{
            response.sendRedirect("index.jsp");
        }


    }
}
