package com.blog.servlets;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.blog.dao.RegisterDao;
import com.blog.entities.Register;
import com.blog.helper.ConnectionProvider;

@MultipartConfig
@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PrintWriter writer = response.getWriter();
		
		//String check = request.getParameter("check");
		//System.out.print(check);
		/*if(check == null)
		{
			writer.println("box not checked");
		}*/
		//else
		//{
			//if checked then fetch rest of the data
			String name = request.getParameter("user_name");
			String email = request.getParameter("user_email");
			String password = request.getParameter("user_pass");
			String gender = request.getParameter("gender");
			String about = request.getParameter("user_about");
			//create register.java class object and set all data
			Register r = new Register(name,email,password,gender,about);
			
			//create obj of registerDao.java page and pass connection
			RegisterDao dao = new RegisterDao(ConnectionProvider.getConnection());
			if(dao.insertData(r))
			{
				writer.println("done");
			}
			else
			{
				writer.println("error");
			}
		//}
	}

}
