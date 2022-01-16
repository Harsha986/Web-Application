/**
 * 
 */

function doLike(pid, uid)
{
	console.log(pid + "," + uid)
	//use ajax to sen data to servlet
	
	//create object to store all data
	const data = {
		uid : uid,
		pid : pid,
		operation : 'like'
	}
	
	$.ajax({
		url : "LikeServlet",
		method : "GET",
		data : data,
		success: function(data , textStatus ,jqXHR){
			console.log(data);
			if(data.trim() === 'true')
			{
				
				let c = $(".count-like").html(); //to increase like count by one
				c++;
				
				//code to wait....to show like
				$(".like-btn").hide();
				$(".dislike-btn").show();
				$(".dislike").html(c);
			}
		},
		error: function(jqXHR, textStatus, errorThrown){
			console.log(data);
		}
		
	});
}

function doDislike(pid, uid)
{
	console.log(pid + "," + uid)
	//use ajax to sen data to servlet
	
	//create object to store all data
	const data = {
		uid : uid,
		pid : pid,
		operation : 'dislike'
	}
	
	$.ajax({
		url : "LikeServlet",
		method : "GET",
		data : data,
		success: function(data , textStatus ,jqXHR){
			console.log(data);
			if(data.trim() === 'true')
			{
				
				let c = $(".dislike").html(); //to increase like count by one
				c--;
				//code to wait....to show like
				$(".like-btn").show();
				$(".dislike-btn").hide();
				$(".count-like").html(c);
			}
		},
		error: function(jqXHR, textStatus, errorThrown){
			console.log(data);
		}
		
	});
}