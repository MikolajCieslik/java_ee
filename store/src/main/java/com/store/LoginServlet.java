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


@WebServlet(name= "LoginServlet", urlPatterns = {"/LogServlet"})
public class LoginServlet extends HttpServlet{

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //TODO: dorobić hashowanie haseł
        String login = request.getParameter("login");
        String haslo = request.getParameter("haslo");
        try{
            Connection con = ConnectionProvider.getCon();
            String sql = "Select id from users where login='"+login+"' AND haslo='"+haslo+"';";
            Statement st = con.createStatement();
            ResultSet rs = st.executeQuery(sql);

            if(rs.next()==true){
                HttpSession session = request.getSession();
                session.setAttribute("login",login);
                String id;
                id =  rs.getString(1);
                session.setAttribute("id",id);
                sql = "Select typ_konta, imie, nazwisko from users where id="+id+";";
                rs = st.executeQuery(sql);
                String imie_nazwisko = new String();
                rs.next();
                Integer typ_konta =  rs.getInt(1);
                imie_nazwisko = rs.getString(2)+" "+ rs.getString(3);
                session.setAttribute("imie_nazwisko",imie_nazwisko);
                session.setAttribute("typ_konta",typ_konta);
                //
                response.sendRedirect("login.jsp?msg=valid");
            }
            else{
                response.sendRedirect("login.jsp?msg=invalid");
            }
            rs.close();
            st.close();
            con.close();
        } catch (Exception e){
            e.printStackTrace();
            response.sendRedirect("login.jsp?msg=invalid");

        }

    }
}
