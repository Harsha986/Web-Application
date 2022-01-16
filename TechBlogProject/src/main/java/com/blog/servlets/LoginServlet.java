package com.blog.servlets;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.blog.dao.RegisterDao;
import com.blog.entities.MessagePage;
import com.blog.entities.Register;
import com.blog.helper.ConnectionProvider;

@WebServlet("/LoginServlet")

public class LoginServlet extends HttpServlet {
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String email = request.getParameter("email");
		String password = request.getParameter("password");
		
		PrintWriter writer = response.getWriter();
		//check send these data to registerDao.java 
		RegisterDao reg = new RegisterDao(ConnectionProvider.getConnection());
		Register user = reg.getDataByEmailandPassword(email, password);
		
		//if email or password is wrong - login error
		if(user == null) //wrong credentials
		{
			//writer.println("Invalid Details..try again");
			MessagePage m = new MessagePage("Invalid Details! Try again", "error", "alert-danger");
			//redirect to login page
			HttpSession s = request.getSession();
			s.setAttribute("currentMessage", m);
			response.sendRedirect("login.jsp");
		}
		else
		{
			 //right credentials - so create session object which will work untill browser get closed
			//store user to session
			HttpSession s = request.getSession();
			s.setAttribute("currentUser", user);
			response.sendRedirect("profile.jsp"); //send data to profile page
							
		}
	}

}
