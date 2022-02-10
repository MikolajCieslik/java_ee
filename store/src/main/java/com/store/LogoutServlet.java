package com.store;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;



@WebServlet(name= "LogoutServlet", urlPatterns = {"/LogoServlet"})
public class LogoutServlet extends HttpServlet{

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        session.removeAttribute("id");
        session.removeAttribute("login");
        session.removeAttribute("imie_nazwisko");
        session.removeAttribute("typ_konta");
        response.sendRedirect("index.jsp");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        session.removeAttribute("id");
        session.removeAttribute("login");
        session.removeAttribute("imie_nazwisko");
        session.removeAttribute("typ_konta");
        session.invalidate();
        response.sendRedirect("index.jsp");
    }
}