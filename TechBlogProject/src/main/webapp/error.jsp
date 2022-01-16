<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page isErrorPage="true" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Oops!! something went wrong</title>
 <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
 <link rel="stylesheet" href="css/styles.css">
 <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
 
</head>
<body>
 	<div class="container text-center">
 		<img src="image/error.png" class="img-fluid" width="400" height="400">
 		<h4 class="display-4">Oops!! Something Went Wrong</h4>
 		
 		<div ><%= exception %></div>
 		<a href="index.jsp" class="btn primary-back btn-lg mt-2 text-white">Home</a>
 	</div>
</body>
</html>