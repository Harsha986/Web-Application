package com.blog.servlets;

import javax.servlet.http.*;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.blog.dao.RegisterDao;
import com.blog.entities.Register;
import com.blog.helper.ConnectionProvider;

@MultipartConfig //as form is sending multipart data
@WebServlet("/EditServlet")
public class EditServlet extends HttpServlet {
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//taking data from profile page
		
		String email = request.getParameter("email");
		String name = request.getParameter("name");
		String password = request.getParameter("password");
		String about = request.getParameter("about");
	    //Part part = request.getPart("image"); //used to take file inpuy
		//String imageName = part.getName();
		
		//fetch the session data and update data of session
		HttpSession s = request.getSession();
		Register r = (Register)s.getAttribute("currentUser");
		r.setEmail(email);
		r.setName(name);
		r.setPassword(password);
		r.setAbout(about);
		//r.setProfile(imageName);
		
		//now update data in database
		RegisterDao re = new RegisterDao(ConnectionProvider.getConnection());
		boolean ans = re.updateUserInfo(r);
		
		if(ans)
		{
			System.out.println("updated");
		}
		else
		{
			System.out.println("error");
		}
	}

}
