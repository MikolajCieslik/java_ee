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


@WebServlet(name= "LogoutServlet", urlPatterns = {"/LogoServlet"})
public class LogoutServlet extends HttpServlet{

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Integer typ_konta = (Integer) session.getAttribute("typ_konta");
        if(typ_konta==1){
            String id = session.getAttribute("id").toString();
            Connection con = ConnectionProvider.getCon();
            try {
                Statement st = con.createStatement();
                String sql = "Delete from cart where user_id = "+id+";";
                Integer deletedRows = st.executeUpdate(sql);
                st.close();
                con.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        session.invalidate();
        response.sendRedirect("index.jsp");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Integer typ_konta = (Integer) session.getAttribute("typ_konta");
        if(typ_konta==1){
            String id = session.getAttribute("id").toString();
            Connection con = ConnectionProvider.getCon();
            try {
                Statement st = con.createStatement();
                String sql = "Delete from cart where user_id = "+id+";";
                Integer deletedRows = st.executeUpdate(sql);
                st.close();
                con.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        session.invalidate();
        response.sendRedirect("index.jsp");
    }
}