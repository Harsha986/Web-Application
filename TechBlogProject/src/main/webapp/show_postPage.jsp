<%@page import="com.blog.dao.LikeDao"%>
<%@page import="java.text.DateFormat"%>
<%@page import="com.blog.dao.RegisterDao"%>
<%@page import="com.blog.entities.Register"%>
<%@page import="com.blog.entities.Post"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.blog.helper.ConnectionProvider"%>
<%@page import="com.blog.dao.PostDao"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
 <%@page errorPage="error.jsp" %>
<%
   Register r = (Register)session.getAttribute("currentUser");
   if(r == null)
   {
	   response.sendRedirect("login.jsp"); //if user is not login
   }
%> 
 <%
    //we can directlt user request obj in jsp
    int post_id = Integer.parseInt(request.getParameter("post_id"));
    PostDao p = new PostDao(ConnectionProvider.getConnection());
    Post pp =   p.getPostByPid(post_id);
    
    RegisterDao regs = new RegisterDao(ConnectionProvider.getConnection());
    Register user = regs.getUserDetails(pp.getUserid());
    
 %>
  
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title><%= pp.getPtitle() %></title>

 <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
 <link rel="stylesheet" href="css/styles.css">
 <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
  <style>
  body{
    background: url("image/bg1.jpg");
    background-size: cover;
    background-attachment:  fixed;
  }
.ban-back {
	clip-path: polygon(30% 0%, 70% 0%, 100% 0, 100% 92%, 70% 100%, 33% 93%, 0 100%, 0 0
		);
}

.post-title {
	font-weight: 100;
	font-size: 30px;
}

.post-content {
	font-weight: 100;
	font-size: 24px;
}

.post-date {
	font-style: italic;
	font-weight: bold;
}
.row-post{
    border: 1px solid #e2e2e2;
    padding-top: 15px;
}
.like-btn{
	background-color: green;
	color: white;
}
.dislike-btn{
	background-color: red;
	color: white;
}
</style>
</head>
<body>
  
 <!-- navbar -->
  <nav class="navbar navbar-expand-lg navbar-light primary-back ">
	  <a class="navbar-brand" href="#"><span class="fa fa-asterisk fa-spin"></span>Tech Blog</a>
	  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
	    <span class="navbar-toggler-icon"></span>
	  </button>
	
	  <div class="collapse navbar-collapse" id="navbarSupportedContent">
	    <ul class="navbar-nav mr-auto">
	      <li class="nav-item active">
	        <a class="nav-link text-white" href="profile.jsp">My Profile <span class="sr-only">(current)</span></a>
	      </li>
	      <li class="nav-item">
	        <a class="nav-link text-white" href="#">Contact</a>
	      </li>
	      <li class="nav-item dropdown">
	        <a class="nav-link dropdown-toggle text-white" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
	          Category
	        </a>
	        <div class="dropdown-menu" aria-labelledby="navbarDropdown">
	          <a class="dropdown-item" href="#">Action</a>
	          <a class="dropdown-item" href="#">Another action</a>
	          <div class="dropdown-divider"></div>
	          <a class="dropdown-item" href="#">Something else here</a>
	        </div>
	      </li>
	       <li class="nav-item">
	        <a class="nav-link text-white" href="#!" data-toggle="modal" data-target="#post-Modal">Add Post</a>
	      </li>
	    </ul>
	    <ul class="navbar-nav mr-right">
	        <!--  as soon we click on name then window should pop with all the details of user -->
	         <li class="nav-item">
	        <a class="nav-link text-white" href="#!" data-toggle="modal" data-target="#profile-Modal"><span class="fa fa-user-circle"></span><%= r.getName() %></a>
	        </li>
	          <li class="nav-item">
	        <a class="nav-link text-white" href="LogoutServlet"><span class="fa fa-sign-out"></span>Logout</a>
	      </li>
	    </ul>
	  </div>
	</nav>
  <!-- navbar -->
  
  <!-- get the id of single post on which Read more is clicked -->
  <div class="container">
  	<div class="row my-4">
  		<div class="col-md-8 offset-md-2">
  		  <div class="card">
  		  
  		  	<div class="card-header">
  		  		<h4 class="post-title"><%= pp.getPtitle() %></h4>
  		  	</div>
  		  	
  		  	<div class="card-body">
  		  	   <div class="row mt-2 row-post">
  		  		<div class="col-md-8 ">
  		  			<p> <a href="#!" data-toggle="modal" data-target="#exampleModal"><%= user.getName() %></a>&nbsp; has posted:</p>
  		  		</div>
  		  		<div class="col-md-4">
  		  		    
  		  			<p class="post-date"><%= DateFormat.getDateTimeInstance().format(pp.getpDate()) %></p>
  		  		</div>
  		  	   </div>
  		  		<p class="post-content"><%= pp.getPcontent() %></p>
  		  		<div class="post-code"><pre><%= pp.getPcode() %></pre></div>
  		  	</div>
  		  	<%
  		  		LikeDao like = new LikeDao(ConnectionProvider.getConnection());
  		  	    
  		  	%>
  		  	<div class="card-footer primary-back">
  		  	    <a href="#!" onclick="doLike(<%=pp.getPid() %>,<%= user.getId() %>)" class="btn btn-outline-light btn-sm like-btn" ><i class="fa fa-thumbs-o-up"></i> <span class="count-like"><%= like.countLike(pp.getPid()) %></span></a>
   			     <a href="#!" onclick="doDislike(<%=pp.getPid() %>,<%= user.getId() %>)" class="btn btn-outline-light btn-sm dislike-btn" style="display: none"><i class="fa fa-thumbs-o-down"></i> <span class="dislike"><%= like.countLike(pp.getPid()) %></span></a>
   			    <a href="profile.jsp" class="btn btn-outline-light btn-sm">Read Less...</a>
   			    <a href="#!" class="btn btn-outline-light btn-sm"><i class="fa fa-commenting-o"></i> <span>20</span></a>
  		  	</div>
  		  </div>
  		</div>
  	</div>
  </div>
 <!-- modal section for user details -->
  <!-- Button trigger modal -->
<!-- Modal -->
<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">User Details</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
         <table class="table">
			  <tbody>
			    <tr>
			      <th scope="row">Email: </th>
			      <td><%= user.getEmail() %></td>
			     
			    </tr>
			    <tr>
			      <th scope="row">Gender</th>
			      <td><%= user.getGender() %></td>
			     
			    </tr>
			    <tr>
			      <th scope="row">About</th>
			      <td><%= user.getAbout() %></td>
			      
			    </tr>
			  </tbody>
		 </table>
      </div> 
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div>
 <!-- modal section for user details -->
 
  <script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
  <script src="js/myjs.js" type="text/javascript"></script>
</body>
</html>