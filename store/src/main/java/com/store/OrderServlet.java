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

@WebServlet(name= "OrderServlet", urlPatterns = {"/OrderServlet"})
public class OrderServlet extends HttpServlet{
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();
        Integer typ_konta = (Integer) session.getAttribute("typ_konta");
        String id = session.getAttribute("id").toString();
        String imie = request.getParameter("imie");
        String nazwisko = request.getParameter("nazwisko");
        String kod_pocztowy = request.getParameter("kod_pocztowy");
        String miejscowosc = request.getParameter("miejscowosc");
        String adres = request.getParameter("adres");
        String numer = request.getParameter("numer");
        String dostawa = request.getParameter("delivery");
        Connection con = ConnectionProvider.getCon();
        if(typ_konta==1){
            try {
                Statement st = con.createStatement();
                Statement st2 = con.createStatement();
                Statement st3 = con.createStatement();
                Statement st4 = con.createStatement();
                Statement st5 = con.createStatement();
                Statement st6 = con.createStatement();
                ResultSet rs2 = st.executeQuery("select max(id) from orders");
                int id_zamowienia;
                if(rs2.next()==true){
                    id_zamowienia=rs2.getInt(1);
                }
                else{
                    id_zamowienia=0;
                }
                id_zamowienia++;
                String sql;
                String sql2;
                ResultSet rs = st2.executeQuery("select * from cart where user_id='"+id+"'");
                while(rs.next())
                {
                    int prod_id = rs.getInt(2);
                    int amount = rs.getInt(3);
                    double price = rs.getDouble(4);
                    ResultSet rs3 = st4.executeQuery("select ilosc from products where id="+prod_id+";");
                    rs3.next();
                    int ilosc = rs3.getInt(1)-rs.getInt(3);
                    if(ilosc>=0){
                        sql= "Insert into orders values('"+id_zamowienia+"','"+id+"','"+prod_id+"','"+amount+"','"+price+
                                "','"+dostawa+"','"+imie+"','"+nazwisko+"','"+kod_pocztowy+"','"+miejscowosc+"','"+adres+"','"+numer+"');";
                        Integer insertedRows = st3.executeUpdate(sql);

                        sql2 = "Update products set ilosc="+ilosc+" where id="+rs.getInt(2)+";";
                        Integer updatedRows = st5.executeUpdate(sql2);
                    }
                    else{
                        response.sendRedirect("cart.jsp?error=error");
                    }
                    rs3.close();
                }
                rs2.close();
                rs.close();
                try {
                    String sql3 = "Delete from cart where user_id = "+id+";";
                    Integer deletedRows = st6.executeUpdate(sql3);
                    st6.close();
                    st5.close();
                    st4.close();
                    st3.close();
                    st2.close();
                    st.close();
                    con.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
                response.sendRedirect("order.jsp?id="+id_zamowienia);

            } catch (SQLException e) {
                e.printStackTrace();
                response.sendRedirect("index.jsp");

            }
        }
        else{
            response.sendRedirect("index.jsp");
        }

    }

}

