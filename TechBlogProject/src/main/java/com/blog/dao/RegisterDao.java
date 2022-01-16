package com.blog.dao;
import java.sql.*;

import com.blog.entities.Post;
import com.blog.entities.Register;

public class RegisterDao {
	private Connection con;

	public RegisterDao(Connection con) {
		this.con = con;
	}
	//method to insert user data to database
	public boolean insertData(Register regis)
	{
		boolean f =false;
		try
		{
			
			String query ="insert into techblog.register(name,email,password,gender,about ) values(?,?,?,?,?)";
			//prepare statement
			PreparedStatement prep = this.con.prepareStatement(query);
			//pass data to ?
			prep.setString(1, regis.getName());
			prep.setString(2, regis.getEmail());
			prep.setString(3, regis.getPassword());
			prep.setString(4, regis.getGender());
			prep.setString(5, regis.getAbout());
			//execute query
			prep.executeUpdate();
			f=true;
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		return f;
	}

	//get user by email and password
	public Register getDataByEmailandPassword(String email, String password)
	{
		Register r = null;
		try
		{
			String query = "select * from techblog.register where email=? and password=?";
			//Prepare statement
			PreparedStatement prep = con.prepareStatement(query);
			//put data to ?
			prep.setString(1, email);
			prep.setString(2, password);
			//execute query return resultset
			ResultSet set = prep.executeQuery();
			if(set.next())
			{
				r = new Register(); //new obj of user
				String name = set.getString("name"); //getdata from resultset
				r.setName(name); //set data to r object
				r.setId(set.getInt("id"));
				r.setEmail(set.getString("email"));
				r.setPassword(set.getString("password"));
				r.setAbout(set.getString("about"));
				r.setGender(set.getString("gender"));
				r.setProfile(set.getString("profile"));
			}
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		return r;
	}

	
	//update user info from editServlet
	public boolean updateUserInfo(Register r)
	{
		String query = "update techblog.register set name=? , email=? , password=?, about=?  where id=?";
		boolean b = false;
		try
		{
			PreparedStatement perp = con.prepareStatement(query);
			//place data
			perp.setString(1, r.getName());
			perp.setString(2, r.getEmail());
			perp.setString(3, r.getPassword());
			perp.setString(4, r.getAbout());
			//perp.setString(5, r.getProfile());
			perp.setInt(5, r.getId());
			
			perp.executeUpdate();
			b = true;
		}
		catch(Exception e) 
		{
			e.printStackTrace();
		}
		return b;
	}
   //fetch user details by user id
	public Register getUserDetails(int uid) {
		Register r =null;
		try {
			String query = "select * from techblog.register where id=?";
			
			PreparedStatement prep = con.prepareStatement(query);
			prep.setInt(1, uid);
			ResultSet set = prep.executeQuery();
			
			if(set.next()) {
				String name = set.getString("name");
				String email = set.getString("email");
				String gender = set.getString("gender");
				String about = set.getString("about");
				
				r = new Register(uid,name,email,gender,about);
			}
		}
		catch(Exception e) {
			
		}
		return r;
	}
	
}
