<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@page language="java" session="true" %>
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
<%@ page import="com.google.appengine.api.datastore.Query.Filter" %>
<%@ page import ="com.google.appengine.api.datastore.Query.FilterPredicate"  %>
<%@ page import ="com.google.appengine.api.datastore.Query.FilterOperator" %>
<%@ page import ="com.google.appengine.api.datastore.Query.CompositeFilter"  %>
<%@ page import="com.google.appengine.api.datastore.Query.CompositeFilterOperator" %>
<%@page import ="com.google.appengine.api.datastore.Transaction"%>
<html>
  
<script>

function Posttwt() {
	  console.log('Posting a message to user feed.... '); 
	  FB.login(function(){
	        var typed_text = document.getElementById("content").value;
	         FB.api('/me/feed', 'post', {message: typed_text});
	         document.getElementById('theText').innerHTML = 'Thanks for posting the message' + typed_text;
	    }, {scope: 'publish_actions'});
	 }


function Indun() {
    FB.api("/me",
            function (response) {
  	  			 document.getElementById('zombie').value = response.name ;
  	  			 document.getElementById('userid').value = response.id ;
  	  		     });
    }

function statusChangeCallback(response) {
    console.log('statusChangeCallback');
    console.log(response);
    if (response.status === 'connected') {
        Indun();
     } else if (response.status === 'not_authorized') {
           document.getElementById('status').innerHTML = 'Please log ' +'into this app.';
     } else {
           document.getElementById('status').innerHTML = 'Please log ' + 'into Facebook.';
     }
}
window.fbAsyncInit = function() {

	  FB.init({
	        appId : '825449767580680',
	        cookie : true, // enable cookies to allow the server to access 
	        xfbml : true, // parse social plugins on this page
	        version : 'v2.1' // use version 2.1
	  });
	  FB.getLoginStatus(function(response) {
	        statusChangeCallback(response);
	        });
	  };

	  (function(d, s, id) {
	        var js, fjs = d.getElementsByTagName(s)[0];
	        if (d.getElementById(id)) return;
	        js = d.createElement(s); js.id = id;
	        js.src = "//connect.facebook.net/en_US/sdk.js";
	        fjs.parentNode.insertBefore(js, fjs);
	  }(document, 'script', 'facebook-jssdk'));

	  function sendTwt() {
		     
	  FB.ui({
		  method: 'send',
		  link:  'https://developers.facebook.com/docs/',
	  });
	  }
	  function deleteTweet()
	   {
	   var table = document.getElementById("tblid");
	   var rows = table.getElementsByTagName("tr");
	   for (i = 0; i < rows.length; i++) {
	           var currentRow = table.rows[i];
	           var createHandler=
	           function(row) 
	               {
	                   return function() { 
	                                           var cell = row.getElementsByTagName("td")[3];
	                                           var id = cell.innerText;
	                                           document.getElementById('keyid').value=id;
	   	   	                                                 
	                   };
	               };
	           currentRow.onclick = createHandler(currentRow);
	       }
	   }
	  
 </script>
  <body >

 
	  

  <form  name="form1" action="/tweets" method="get">
  <input type="hidden"  id="zname" name="zname" value=""/>
      <input type="hidden"  id="uid" name="uid" value=""/>
      <input id="welcome2" type="submit" value="Tweetlist"  onclick="location.href='/tweets.jsp?'"/>    
    
 </form>
<input id="welcome3" type="button" value="Friends" onclick="location.href='/friendstweet'"/>
<input id="welcome4" type="button" value="Top Tweets" onclick="location.href='/toptweets'"/>




 
    <form  name="formtest" action="/tweets" method="post">
      <div><textarea name="content" id="content" rows="3" cols="60"></textarea></div>
     <input type="hidden"  id="zombie" name="zombie" value="<%=(String)session.getAttribute("username")%>"/>
      <input type="hidden"  id="userid" name="userid" value=""/>
   
      <div><input type="submit" value="Post Tweet"  onclick="Posttwt()"/></div>
    <div><input type="submit" value="Send Tweet"  onclick="sendTwt()"/></div>
   
   </form>
        
<%  
 DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
 String username= (String)session.getAttribute("username");


Filter zmb =
  new FilterPredicate("zombie",
                      FilterOperator.EQUAL,
                      username);

Query q = new Query("TweetsIndu")
                .setFilter(zmb);

List<Entity> tweets = datastore.prepare(q).asList(FetchOptions.Builder.withLimit(25));

Transaction txn = datastore.beginTransaction();
%> 

  <div style="overflow: auto;height: 100px; width: 320px;">
  
  <table id="tblid">
  <tr><td>TweetMessage</td><td>Username</td></tr>
       <% for(Entity tweet:tweets){ %>
    
<tr>

 <td> <input type="checkbox" id="chkbx" name="chkbx" onclick="deleteTweet()"> </td>


  
  <td> <%= tweet.getProperty("status") %></td>
  <td> <%= tweet.getProperty("zombie") %></td>
  <td hidden="true"> <%= KeyFactory.keyToString(tweet.getKey()) %> </td>
  <%} %>

  </tr>
  </table></div>
            
         

<form id="delete_form" action="/tweetlist" method="post">
  <input type="hidden"  id="keyid" name="keyid" value=""/>
   
 <input type="submit" id="delete" name="delete" value="Delete"> 
 </form>
   
<div id="theText"></div> 
  </body>
</html>