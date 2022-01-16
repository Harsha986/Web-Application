package com.blog.servlets;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.blog.dao.PostDao;
import com.blog.dao.RegisterDao;
import com.blog.entities.Post;
import com.blog.entities.Register;
import com.blog.helper.ConnectionProvider;

@MultipartConfig
@WebServlet("/AddPostServlet")
public class AddPostServlet extends HttpServlet {
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	   PrintWriter writer = response.getWriter();
		
	    int cid = Integer.parseInt(request.getParameter("cid")); 
		String ptitle = request.getParameter("ptitle");
		String pcontent = request.getParameter("pcontent");
		String pcode = request.getParameter("pcode");
		
		//getting current user Id
		HttpSession s = request.getSession();
		Register r = (Register)s.getAttribute("currentUser");
		int userid = r.getId();
		
		PostDao reg = new PostDao(ConnectionProvider.getConnection());
		Post p = new Post(ptitle,pcontent,pcode, null, cid ,userid);
		boolean b = reg.insertPost(p);
		
		if(b)
		{
			writer.println("done");
		}
		else
		{
			writer.println("error");
		}
	}

}
