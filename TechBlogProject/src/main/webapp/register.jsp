<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="com.blog.servlets.RegisterServlet"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Registration Page</title>
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

<main class="primary-back ban-back" style="padding-bottom: 80px">
	<div class="container">
		<div class="col-md-6 offset-md-3">
			<div class="card">
				 <div class="card-header text-center primary-back text-white">
				 <span class="fa fa-user-plus fa-3x"></span>
				  <p style="font-size:3vh"><bold>Register Here</bold></p>
				 </div>
				 <div class="card-body">
				 <form action="RegisterServlet" method="post" id="form">
				      <div class="form-group">
					    <label for="name">User Name</label>
					    <input type="text" class="form-control" name="user_name"  aria-describedby="emailHelp" placeholder="Enter Name">
					  </div>
					  <div class="form-group">
					    <label for="email">Email address</label>
					    <input type="email" class="form-control" name="user_email" aria-describedby="emailHelp" placeholder="Enter email">
					    <small id="emailHelp" class="form-text text-muted ">We'll never share your email with anyone else.</small>
					  </div>
					  <div class="form-group">
					    <label for="password">Password</label>
					    <input type="password" class="form-control" name="user_pass" placeholder="Password">
					  </div>
					  <div class="form-group">
					    <label for="gender">Select Gender</label><br>
					    <input type="radio" id="gender" name="gender" value="Male">Male
					    <input type="radio" id="gender" name="gender" value="Female">Female
					  </div>
					  <div class="form-group">
					    <textarea rows="5" class="form-control" name="user_about" id="" placeholder="Enter something about yourself"></textarea>
					  </div>
					  <!--  <div class="form-check">
					    <input name="check" value="on" type="checkbox" class="form-check-input">
					     <label class="form-check-label" for="exampleCheck1">Agree Terms And Conditions</label>
					  </div> -->
					  <div class="text-center" id="loader" style="display: none">
					   <span class="fa fa-hourglass-start fa-spin"></span>
					   <h4>Please Wait.......</h4>
					  </div>
					  <br>
					  <button type="submit" id="submit-btn" class="btn btn-primary">Submit</button>
				</form>
				 </div>
			
			</div>
		</div>
	</div>
</main>


<script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
 <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
 <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.5.0/jquery.min.js" integrity="sha256-xNzN2a4ltkB44Mc/Jz3pT4iU1cmeR0FkXs4pru/JxaQ=" crossorigin="anonymous"></script>

<!-- alert cdn -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.js"></script>
<script>
   	$(document).ready(function(){
   		console.log("ready");
   		
   		$('#form').on('submit', function(event){
   			//we will stop page to go to servlet page
   			event.preventDefault();
   			//submit all the data to servlet page from here only
   			let forms = new FormData(this);
   			
   			$('#submit-btn').hide();
   			$('#loader').show();
   			//send through ajax
   			$.ajax({
   				url: "RegisterServlet",
   			    type : 'post',
   			    data : forms,
	   			success: function (data, textStatus, jqXHR){
	   				console.log("inserted");
	   				
	   				$('#submit-btn').show();
	   	   			$('#loader').hide();
	   	   			
	   	       if(data.trim() === 'done')
	   	    	   {
	   	    	swal("signup successfull")
	   	   	     .then((value) => {
	   	   	           window.location="login.jsp"
	   	   	        });
  				
	   	    	   }
	   	       else
	   	    	   {
	   	    	   swal(data)
	   	    	   }
	   			},
	   			error : function (jqXHR, textStatus, errorThrown){
	   				$('#submit-btn').show();
	   	   			$('#loader').hide();
	   				swal("Something went wrong..try again");
	   			},
	   			processData : false,
	   			contentType : false
   			}); //ajax close
   		}); //form close
   	}); //ready close
   </script>
</body>
   
</html>