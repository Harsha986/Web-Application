package com.blog.dao;
import java.sql.*;
import java.util.ArrayList;

import com.blog.entities.Category;
import com.blog.entities.Post;

public class PostDao {
	Connection con;
	
	public PostDao(Connection con) {
		this.con = con;
	}
	//fetch all category table details
	public ArrayList<Category> getCategories(){
		ArrayList<Category> list = new ArrayList<>();
		
		//fetch all data from DB and store in list
		try {
			String query = "select * from techblog.categories";
			//
			Statement stat = con.createStatement();
			ResultSet set = stat.executeQuery(query);
			
			while(set.next())
			{
				int cid = set.getInt("cid");
				String cname = set.getString("cname");
				String cdescription = set.getString("cdescription");
				
				Category c = new Category(cid,cname,cdescription);
				list.add(c);
			}
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		return list;
	}

	public boolean insertPost(Post p) {
		boolean f = false;
		
		try {
			String query = "insert into techblog.posts(ptitle, pcontent, pcode, cid, userid) values(?,?,?,?,?)";
			
			PreparedStatement perp = con.prepareStatement(query);
			perp.setString(1, p.getPtitle());
			perp.setString(2, p.getPcontent());
			perp.setString(3, p.getPcode());
			perp.setInt(4, p.getCid());
			perp.setInt(5, p.getUserid());
			
			perp.executeUpdate();
			f = true;
		}
		catch(Exception e) {
			
		}
		return f;
	}

	//fetch all post
    public ArrayList<Post> getAllPost(){
    	ArrayList<Post> list = new ArrayList<>();
    	
    	try {
    		String query = "select * from techblog.posts order by pdate";
    		PreparedStatement prep = con.prepareStatement(query);
    		
    		ResultSet set = prep.executeQuery();
    		while(set.next()) {
    			int pid = set.getInt("pid");
    			String pname = set.getString("ptitle");
    			String pcontent = set.getString("pcontent");
    			String pcode = set.getString("pcode");
    			Timestamp pdate = set.getTimestamp("pdate");
    			int cid = set.getInt("cid");
    			int userid = set.getInt("userid");
    			
    			Post p = new Post(pid,pname,pcontent,pcode,pdate,cid,userid);
    			list.add(p);
    		}
    	}
    	catch(Exception e) {
    		e.printStackTrace();
    	}
    	return list;
    	
    }
  //fetch all post for specific id
    public ArrayList<Post> getPostByCid(int cid){
    	ArrayList<Post> list = new ArrayList<>();
    	
    	try {
    		String query = "select * from techblog.posts where cid=?";
            PreparedStatement prep = con.prepareStatement(query);
    		
            prep.setInt(1, cid);
            
    		ResultSet set = prep.executeQuery();
    		while(set.next()) {
    			int pid = set.getInt("pid");
    			String pname = set.getString("ptitle");
    			String pcontent = set.getString("pcontent");
    			String pcode = set.getString("pcode");
    			Timestamp pdate = set.getTimestamp("pdate");
    			int userid = set.getInt("userid");
    			
    			Post p = new Post(pid,pname,pcontent,pcode,pdate,cid,userid);
    			list.add(p);
    		}
    	}
    	catch(Exception e) {
    		e.printStackTrace();
    	}
    	return list;
    	
    }

    //fetch post details by pid
    public Post getPostByPid(int pid){
    	Post p = null;
    	try {
    		String query = "select * from techblog.posts where pid=?";
            PreparedStatement prep = con.prepareStatement(query);
    		
            prep.setInt(1, pid);
            
    		ResultSet set = prep.executeQuery();
    		if(set.next()) {
    			String pname = set.getString("ptitle");
    			String pcontent = set.getString("pcontent");
    			String pcode = set.getString("pcode");
    			Timestamp pdate = set.getTimestamp("pdate");
    			int cid = set.getInt("cid");
    			int userid = set.getInt("userid");
    			
    			p = new Post(pid,pname,pcontent,pcode,pdate,cid,userid);
    			
    		}
    	}
    	catch(Exception e) {
    		e.printStackTrace();
    	}
    	return p;
    }

}
