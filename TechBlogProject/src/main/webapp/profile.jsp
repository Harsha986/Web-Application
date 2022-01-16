<%@page import="com.blog.entities.Category"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.blog.helper.ConnectionProvider"%>
<%@page import="com.blog.dao.PostDao"%>
<%@page import="com.blog.entities.Register" %>
<%@page errorPage="error.jsp" %>
<%
   Register r = (Register)session.getAttribute("currentUser");
   if(r == null)
   {
	   response.sendRedirect("login.jsp"); //if user is not login
   }
%> 


<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>User Profile</title>

 <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
 <link rel="stylesheet" href="css/styles.css">
 <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
  <style>
 .ban-back{
 clip-path: polygon(30% 0%, 70% 0%, 100% 0, 100% 92%, 70% 100%, 33% 93%, 0 100%, 0 0);
 }
 </style>
</head>
<body>
 <!-- print data of user in navbar-->
	 <nav class="navbar navbar-expand-lg navbar-light primary-back ">
	  <a class="navbar-brand" href="#"><span class="fa fa-asterisk fa-spin"></span>Tech Blog</a>
	  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
	    <span class="navbar-toggler-icon"></span>
	  </button>
	
	  <div class="collapse navbar-collapse" id="navbarSupportedContent">
	    <ul class="navbar-nav mr-auto">
	      <li class="nav-item active">
	        <a class="nav-link text-white" href="index.jsp">Home <span class="sr-only">(current)</span></a>
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
<!-- navbar ends -->
<!-- main section start -->
<div class="container">
	<div class="row mt-4">
		<div class="col-md-4">
		   <!-- category section -->
		   <div class="list-group">
			  <a href="#" onclick="getPosts(0, this)" class="list-group-item list-group-item-action active c-link">
			    All Post
			  </a>
			  <%
			   PostDao d = new PostDao(ConnectionProvider.getConnection());
			   ArrayList<Category> list2 = d.getCategories();
			   for(Category cc : list2)
			   {
			  %>
			  <a href="#" onclick="getPosts(<%= cc.getCid() %>, this)" class="list-group-item list-group-item-action c-link"><%= cc.getCname() %>
			  </a>
			  <% } %>
		   </div>
		</div>
		<div class="col-md-8" >
			<!-- post section -->
			<div class="container text-center" id="post-loader">
			 <span class="fa fa-refresh fa-3x fa-spin"></span>
			 <h3 class="mt-3">Loading....</h3>
			</div>
			
			<div class="container-fluid" id="post-section">
			</div>
		</div>
	</div>
</div>
<!-- main section ends -->
<!-- modal section -->

	<div class="modal fade" id="profile-Modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
	  <div class="modal-dialog" role="document">
	    <div class="modal-content">
	      <div class="modal-header primary-back text-white text-center">
	        <h5 class="modal-title" id="exampleModalLabel">WELCOME to Tech Blog</h5>
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
	          <span aria-hidden="true">&times;</span>
	        </button>
	      </div>
	      <div class="modal-body">
	        <div class="container text-center">
	            <img src="Profile_pics/<%= r.getProfile() %>" class="img-fluid" style="border-radius:50%; max-width:150px">
	        	<h6 class="modal-title" id="exampleModalLabel"><%= r.getName() %></h6>
	        	<!-- //profile details -->
	        	<div id="profile-detail">
		        	<table class="table">
					  <tbody>
					    <tr>
					      <th scope="row">ID:</th>
					      <td><%= r.getId() %></td>
					     
					    </tr>
					    <tr>
					      <th scope="row">Email:</th>
					      <td><%= r.getEmail() %></td>
					     
					    </tr>
					      <tr>
					      <th scope="row">Gender:</th>
					      <td><%= r.getGender() %></td>
					     
					    </tr>
					    <tr>
					      <th scope="row">Status:</th>
					      <td><%= r.getAbout() %></td>
					     
					    </tr>
					  </tbody>
					</table>
				</div>
				<!-- //profile edit -->
				<div id="profile-edit" style="display: none">
				 	<form action="EditServlet" method="post" enctype="multipart/form-data" id="profile-form" >
				 		<table class="table">
				 			<tr>
				 				<th scope="row">ID:</th>
					            <td><%= r.getId() %></td>
				 			</tr>
				 			<tr>
				 				<th scope="row">Email:</th>
					            <td><input type="email" class="form-control" name="email" value="<%= r.getEmail() %>"></td>
				 			</tr>
				 			<tr>
				 				<th scope="row">Name:</th>
					            <td><input type="text" class="form-control" name="name" value="<%= r.getName() %>"></td>
				 			</tr>
				 			<tr>
				 				<th scope="row">Password:</th>
					            <td><input type="password" class="form-control" name="password" value="<%= r.getPassword() %>"></td>
				 			</tr>
				 			<tr>
				 				<th scope="row">Gender:</th>
					            <td><%= r.getGender().toUpperCase() %></td>
				 			</tr>
				 			<tr>
				 				<th scope="row">About:</th>
					            <td><textarea class="form-control" name="about"><%= r.getAbout() %></textarea></td>
				 			</tr>
				 			 <tr>
				 				<th scope="row">Profile Pic:</th>
					            <td><input type="file" name="image" class="form-control"></td>
				 			</tr>  
				 		</table>
				 		<div class="text-center" id="loader" style="display: none">
					      <span class="fa fa-hourglass-start fa-spin"></span>
					      <h4>Please Wait.......</h4>
					    </div>
					    <br>
				 		
				 		<div class="container">
				 			<button type="submit" id="change_btn" class="btn btn-outline-primary">Save Changes</button>
				 		</div>
				 	</form>
				</div>
	        </div>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
	        <button type="button" id="edit-profile-button" class="btn btn-primary">Edit Profile</button>
	    </div>
	    <div class="col-md-8">
		</div>
	    </div>
	  </div>
	</div>
<!-- modal section -->
 
<!-- post modal start -->
 
<div class="modal fade" id="post-Modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">Provide Post Details </h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
      	<form action="AddPostServlet" method="post" id="add-post-form">
      	    <div class="form-group">
      	    	<select class="form-control" name="cid">
      	    		<option selected disabled="disabled">---Select Category---</option>
      	    		<!-- fetch the categories from DB table categories -->
      	    		<% PostDao post = new PostDao(ConnectionProvider.getConnection());
      	    		   ArrayList<Category> list = post.getCategories();
      	    		   for(Category c : list)
      	    		   {
      	    		%>
      	    		<option  value="<%= c.getCid() %>"><%= c.getCname() %></option>
      	    		<% } %>
      	    	</select>
      	    </div>
      		<div class="form-group">
      			<input type="text" placeholder="Enter Post Title" name="ptitle" class="form-control">
      		</div>
      		<div class="form-group">
      			<textarea placeholder="Enter your Content" name="pcontent" class="form-control"></textarea>
      		</div>
      		<div class="form-group">
      			<textarea placeholder="Enter your Program (if any)" name="pcode" class="form-control"></textarea>
      		</div>
      		 <!-- you can add pic field also -->
      		 <div class="container text-center ">
      		 <button id="post-btn" type="submit" class="btn primary-back text-white">Add Post</button>
      		 </div>
      	</form>
      </div>
      
    </div>
  </div>
</div>
<!-- post modal ends -->


<!-- java script section -->
  <script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
  
  <script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.js"></script>
  <script type="text/javascript">
  
	 $(document).ready(function(){
		  //toggle
		  let editStatus = false;  
		  
		 $("#edit-profile-button").click(function(){
			if(editStatus == false)
				{
				  $("#profile-detail").hide()
				  $("#profile-edit").show()
				  
				  editStatus = true;
				  $(this).text("Back")
				}
			else
				{
				  $("#profile-edit").hide()
				  $("#profile-detail").show()
				  $(this).text("Edit Profile")
				}
		    })
	 }); 
    //send data to servlet page from here with ajax and jquery
    $('#profile-form').on('submit', function(event){
		 event.preventDefault(); //default way of sending form is stop
		 
		 $("#change_btn").hide()
		 $("#loader").show()
		 let form  = new FormData(this);
		 
		 $.ajax({
			 url : "EditServlet",
		     data : form,
		     type : "post",
		     success : function(data, textStatus, jqXHR){
		    	 $("#loader").hide()
		    	 $("#change_btn").show()
		    	 
		    	
		     },
		     error : function (jqXHR, textStatus, errorThrown){
		    	 console.log(data)
		    	 $("#loader").hide()
		    	 $("#change_btn").show()
		     },
		     processData : false,
	   		 contentType : false
		 })
	 })
   </script>
   <!-- script to add post using javascript -->
   <script>
    	$(document).ready(function(){
    		$("#add-post-form").on("submit",function(event){
    			event.preventDefault(); //stop synchronous sending of data
    			console.log("submitted");
    			let form = new FormData(this);
    			
    			$.ajax({
    				url : "AddPostServlet",
    				type : "post",
    				data : form,
    				success : function(data, textStatus, jqXHR){
    					$("#post-btn").hide();
    					if(data.trim() == 'done')
    						{
    						swal("Good job!", "Your post added!", "success");
    						}
    					else
    						{
    						swal("Error", "something went wrong!", "error");
    						}
    				},
    				error : function (jqXHR, textStatus, errorThrown){
    					swal("Error", "something went wrong!", "error");
    			    },
    			    processData : false,
    		   		contentType : false
    			})
    		})
    	});
   </script>
   <!-- script to load post from loadPost.jsp using ajax-->
   <script type="text/javascript">
   
    function getPosts(catid,temp){ //temp store reference of c-link
    	$("#post-loader").show();
		$("#post-section").hide();
		
		$(".c-link").removeClass('active') //default active class has been deactivated
		
    	$.ajax({
 		   url: "loadPost.jsp",
 		   data : {cid : catid},
 		   success : function(data, textStatus, jqXHR){
 			   console.log(data);
 			  $(temp).addClass('active'); //now active class will be activated on clicked link
 			   $("#post-loader").hide();
 			  
 			  $("#post-section").show();
 			   $("#post-section").html(data);
 			   
 			   
 		   }
 	   })
    }
   $(document).ready(function(e){
	   
	   let allPostRef = $(".c-link")[0]
	   getPosts(0,allPostRef)
   });
   </script>
<!-- java script section -->
</body>
</html>