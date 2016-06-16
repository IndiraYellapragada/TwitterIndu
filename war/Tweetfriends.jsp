<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.google.appengine.api.users.User" %>
<%@ page import="com.google.appengine.api.users.UserService" %>
<%@ page import="com.google.appengine.api.users.UserServiceFactory" %>
<%@ page import="com.google.appengine.api.datastore.DatastoreServiceFactory" %>
<%@ page import="com.google.appengine.api.datastore.DatastoreService" %>
<%@ page import="com.google.appengine.api.datastore.Query" %>
<%@ page import="com.google.appengine.api.datastore.Entity" %>
<%@ page import="com.google.appengine.api.datastore.FetchOptions" %>
<%@ page import="com.google.appengine.api.datastore.Key" %>
<%@ page import="com.google.appengine.api.datastore.KeyFactory" %>
<%@ page import="com.google.appengine.api.datastore.Query.Filter"%>
<%@ page import="com.google.appengine.api.datastore.Query.FilterPredicate"%>
<%@ page import="com.google.appengine.api.datastore.Query.FilterOperator"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Facebook App</title>
<h1 align="center">Welcome to Tweet Application</h1>
</head>
<script src="https://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript">
function incr()
{
var table = document.getElementById("tblid");
var rows = table.getElementsByTagName("tr");
for (i = 0; i < rows.length; i++) {
        var currentRow = table.rows[i];
        var createHandler=
        function(row) 
            {
                return function() { 
                                        var cell = row.getElementsByTagName("td")[2];
                                        var id = cell.innerText;
                                        document.getElementById('keyid').value=id;
	   	                                                 
                };
            };
        currentRow.onclick = createHandler(currentRow);
    }
}


window.fbAsyncInit = function() {
	  FB.init({
	        appId : '825449767580680',
	        cookie : true, // enable cookies to allow the server to access 
	        xfbml : true, // parse social plugins on this page
	        version : 'v2.5' // use version 2.5
	  });


	  
	  function statusChangeCallback(response) {

	      console.log('statusChangeCallback');

	      console.log(response);


	      if (response.status === 'connected') {

	                FB.api('/me/friends?fields=name,id,picture',function(response){
	            	friends(response);
	            });
	            

	       } else if (response.status === 'not_authorized') {

	        
	             document.getElementById('status').innerHTML = 'Please log ' +'into this app.';

	       } else {

	        
	             document.getElementById('status').innerHTML = 'Please log ' + 'into Facebook.';

	       }

	}
	  
	  FB.getLoginStatus(function(response) {

	        statusChangeCallback(response);
	        FB.login(function (response){
	        			
	        		},{scope:'user_friends,email,user_birthday'});

	        });
};

(function(d, s, id) {

    var js, fjs = d.getElementsByTagName(s)[0];

    if (d.getElementById(id)) return;

    js = d.createElement(s); js.id = id;

    js.src = "//connect.facebook.net/en_US/sdk.js";

    fjs.parentNode.insertBefore(js, fjs);

}(document, 'script', 'facebook-jssdk'));


function friends(response)
{
	var friendsList = response.data;
	var size = friendsList.length;

	  var friendName;

	  var friendId;

	  var picture= response;

	 $(".friends").append("<p>"+size+"</p>");

	  for(var index=0;index<size;index++){
	  friendName= friendsList[index].name;

	  friendId = friendsList[index].id;

	  picture = friendsList[index].picture.data.url;

	   	var txt=  $("<table><tr><td id='names'></td></tr></table>").append(friendName);

	   	$("#userfriends").append(txt);
	    
	   	var img =  $("<img id='pic'>");

	   	img.attr('src',picture);

	   	img.appendTo("#userfriends");
	   	
	  }

}



</script>

<body>
<br> </br>

  
  <form  name="form1" action="/tweets" method="get">
  <input type="hidden"  id="zname" name="zname" value=""/>
      <input type="hidden"  id="uid" name="uid" value=""/>
      <input id="welcome2" type="submit" value="Tweetlist"  onclick="location.href='/tweets.jsp?'"/>    
    
 </form>
  <input id="welcome3" type="button" value="Friends" onclick="location.href='/friendstweet'"/>
<input id="welcome4" type="button" value="Top Tweets" onclick="location.href='/toptweets'"/>
  
   	<input type="hidden" id="friendname" name="friendname"/>
   	<input type="hidden" id="friendid" name="friendid"/>  
   	<div>
   	<h2 align="left"> Friends List</h2> 
   	</div>
   	<br> </br>	
   	<div id="friendslist"></div>
        <div id = "content"></div>
        <div>
        <table id="friendList">
        <tr>
        <td id="userfriends">
        </td>
        <td id="img">
        </td>
        </tr>
        </table>
		</div>
   	<h2 align="center">Tweets by Friends</h2>
   	<img id="image" name="image"/>
   <%
   		String name=(String)session.getAttribute("username");
		DatastoreService ds= DatastoreServiceFactory.getDatastoreService();
		Filter key = new FilterPredicate("zombie",FilterOperator.NOT_EQUAL,name); 
		Query q= new Query("TweetsIndu").setFilter(key);
    	List<Entity> tweets= ds.prepare(q).asList(FetchOptions.Builder.withLimit(30));
   	%>
   	     <div style="height: 160px; overflow: auto">
   		 <table align="center" id="tblid">
   		  <tr><td>TweetMessage</td><td>Username</td></tr>
   		 <% 
   		   for(Entity tweet: tweets)
   			{ 
  				  String message=(String)tweet.getProperty("status");
  				  String usrname=(String)tweet.getProperty("zombie"); 
   	  
  	   	  %>
            	<tr> 
  				<td>
  				<%=message %>
  				</td>
  				<td>
  				<%=usrname %>
  			   </td>
  			   <td hidden="true">
                <%= KeyFactory.keyToString(tweet.getKey()) %>   </td>
  			   <td>
  			   <input type="checkbox" value="view" id="bid" onclick="incr();"/>
  			   </td>
  			   </tr>
        <%  }  %>
      
        </tbody>
        </table>
        
        </div>
        
 <!-- <form id="updateform" action="/updatecount" method="post">
 <input type="text" id="keyid" name="keyid"/>
 <input type="submit" id="updatecount" name="updatecount"  >  </form> -->
 <script src="https://code.jquery.com/jquery-latest.min.js"></script>
</body>
</html>
