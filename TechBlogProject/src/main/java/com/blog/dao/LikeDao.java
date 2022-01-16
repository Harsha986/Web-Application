package com.blog.dao;

import java.sql.*;

public class LikeDao {
	Connection con;
	
	public LikeDao(Connection con) {
		this.con = con;
	}
	
	
	public boolean insertLike(int pid , int uid) {
		boolean b = false;
		try {
			String query = "insert into techblog.likes(pid,uid) values(?,?)";
			PreparedStatement prep = con.prepareStatement(query);
			prep.setInt(1, pid);
			prep.setInt(2, uid);
			prep.executeUpdate();
			b = true;
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return b;
	}
	public int countLike(int pid) {
		int like = 0;
		try {
			String query = "select count(*) from techblog.likes where pid=?";
			PreparedStatement prep = con.prepareStatement(query);
			prep.setInt(1, pid);
			
			ResultSet set = prep.executeQuery();
		    if(set.next())
		    {
		    	like = set.getInt("count(*)");
		    }
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		return like;
	}
	
	//if already user liked a post return true
	public boolean alreadyLikeByUser(int pid, int uid) {
		boolean like = false;
		try {
			String query = "select * from techblog.likes where pid=? and uid=?";
			PreparedStatement prep = con.prepareStatement(query);
			prep.setInt(1, pid);
			prep.setInt(2, uid);
			
			ResultSet set = prep.executeQuery();
		    if(set.next())
		    {
		    	//means user already liked the code
		    	like = true;
		    }
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		return like;
	}
	
	//if alreadyLikeByUser() method return true then dislike and reduce like count
	public boolean deleteLike(int pid, int uid) {
		boolean b = false;
		try {
			String query = "delete from techblog.likes where pid=? and uid=?";
			PreparedStatement prep = con.prepareStatement(query);
			prep.setInt(1, pid);
			prep.setInt(2, uid);
			
			prep.executeUpdate();
			b = true;
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		return b;
	}
}
