package com.blog.servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.blog.entities.MessagePage;

@WebServlet("/LogoutServlet")

public class LogoutServlet extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		//now we have to remove current user info from session object
		
				HttpSession s = req.getSession();
				s.removeAttribute("currentUser");
				
				MessagePage m = new MessagePage("logout successfully","success","alert-success");
				s.setAttribute("currentMessage", m);
				resp.sendRedirect("login.jsp");
	}

}
