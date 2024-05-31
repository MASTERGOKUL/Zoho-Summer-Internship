package com.demoapp;
import java.io.IOException;
import java.io.PrintWriter;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletConfig;
import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;



@WebServlet("/add")
public class AddServlet extends HttpServlet{

	public void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		int i = Integer.parseInt(req.getParameter("num1"));
		int j = Integer.parseInt(req.getParameter("num2"));
		int k = i+j;
		
//		k = k*k;
		
		
//		Cookie cookie = new Cookie("k",k+"");
//		res.addCookie(cookie);
//		HttpSession sess = req.getSession();
//		sess.setAttribute("k", k);
		
//		res.sendRedirect("sq");
//		res.sendRedirect("sq?k="+k); // url rewritting
//		req.setAttribute("k", k);
//		RequestDispatcher rd = req.getRequestDispatcher("sq");
//		rd.forward(req,res);
		
		// servlet config and context
//		
//		ServletContext ctx = getServletContext();
//		String name = ctx.getInitParameter("name");
		
//		ServletConfig cng = getServletConfig();
//		String name = cng.getInitParameter("name");
		
		PrintWriter out = res.getWriter();
		out.println("Result is = " + k);
		
		
		
	}
}
