<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
 <%@page import="com.blog.servlets.LoginServlet"%>
 <%@page import="com.blog.entities.MessagePage" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Login Page</title>
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

<%@ include file="navbarPage.jsp" %>

<main class="d-flex align-items-center primary-back ban-back" style="height:80vh">
	<div class="container">
		<div class="row">
			<div class="col-md-4 offset-md-4">
				<div class="card">
					<div class="card-header primary-back text-white text-center">
					<span class="fa fa-user-plus fa-3x"></span>
					<p style="font-size:4vh"><bold>Register Here</bold></p>
					</div>
					
					<!-- show error alert -->
				   <%
				     MessagePage m =(MessagePage)session.getAttribute("currentMessage");
				    if(m!= null)
				    {
				    %>
				    <div class="alert <%= m.getCssClass() %>" role="alert">
				      <%= m.getContent() %>
                    </div>
				    <% 
				      session.removeAttribute("currentMessage");
				    }
				   
				   %>
					
					<div class="card-body">
					<form action="LoginServlet" method="post">
						  <div class="form-group">
						    <label for="exampleInputEmail1">Email address</label>
						    <input type="email" name="email" required="required" class="form-control" id="Email1" aria-describedby="emailHelp" placeholder="Enter email">
						    <small id="emailHelp" class="form-text text-muted">We'll never share your email with anyone else.</small>
						  </div>
						  <div class="form-group">
						    <label for="exampleInputPassword1">Password</label>
						    <input type="password"name="password" required="required" class="form-control" id="Password1" placeholder="Password">
						  </div>
						  
						  <div class="container text-center">
						   <button type="submit" class="btn btn-primary">Submit</button>
						  </div>
						  
					</form>
					</div>
				</div>
			</div>
		</div>
	</div>
</main>


<script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
 <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
 <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
</body>
</html>