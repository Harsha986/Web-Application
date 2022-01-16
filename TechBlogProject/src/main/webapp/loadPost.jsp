<%@page import="com.blog.entities.Post"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.blog.helper.ConnectionProvider"%>
<%@page import="com.blog.dao.PostDao"%>

<div class="row"></div>
<%
   Thread.sleep(1000); //take 1sec to load
   PostDao d = new PostDao(ConnectionProvider.getConnection());
   //fetch catid value here
   int cid =  Integer.parseInt(request.getParameter("cid"));
   ArrayList<Post> l = null;
   if(cid == 0){
     l = d.getAllPost();
   }
   else{
	 l = d.getPostByCid(cid);
   }
   if(l.size() == 0)
   {
	   out.println("<h3 class='display-4 text-center'>no post in this category</h3>");
	   return;
   }
   for(Post p : l){
   %>
   
   <div class="col-md-12 mt-2 " style="Float:none">
   	<div class="card">
   		<div class="card-body">
   		 	<h4><%= p.getPtitle() %></h4>
   		 	<p><%= p.getPcontent() %></p>
   		 	<!-- <pre><%= p.getPcode() %></pre> -->
   		 	
   		</div>
   		
   		<div class="card-footer text-center primary-back">
   		   
   			<a href="show_postPage.jsp?post_id=<%= p.getPid() %>" class="btn btn-outline-light btn-sm">Read More...</a>
   			
   		</div>
   	</div>
   </div>
   
   <%
   }

   %>

</div>