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
<%@ page import="com.google.appengine.api.datastore.Query.SortDirection" %>
<html>
<script>
function checkLoginState() {
    FB.getLoginStatus(function(response) {

          statusChangeCallback(response);
    });
}

function statusChangeCallback(response) {
    console.log('statusChangeCallback');
    console.log(response);
    if (response.status === 'connected') {
    	friendslist();
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



	  function friendslist() {
          FB.api("/me/friends", 
                  function (response) {
        	  document.getElementById('listfriends').innerHTML=response.id;
             });
          }
function ftwt()
{
	  document.getElementById('fname').innerHTML=response.id;
	}

		</script>

<body>
<h2> Welcome to Twitter Indira Application</h2>

  <form  name="form1" action="/tweets" method="get">
  <input type="hidden"  id="zname" name="zname" value=""/>
      <input type="hidden"  id="uid" name="uid" value=""/>
      <input id="welcome2" type="submit" value="Tweetlist"  onclick="location.href='/tweets.jsp?'"/>    
    
 </form>
<input id="welcome3" type="button" value="Friends" onclick="location.href='/friendstweet'"/>
<input id="welcome4" type="button" value="Top Tweets" onclick="location.href='/toptweets'"/>

 
<%
DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
Query q = new Query("TweetsIndu").addSort("count", SortDirection.DESCENDING);
List<Entity> toptwts = datastore.prepare(q).asList(FetchOptions.Builder.withLimit(25));
   %>
   <table>
   <tr><td>TweetMessage</td><td>Username</td><td>Count</td></tr>
    <% for(Entity toptwt:toptwts){ 
    	 		
        %>
        <tr>
<td> <%= toptwt.getProperty("status") %></td>
<td> <%= toptwt.getProperty("zombie") %></td>
<td><%= toptwt.getProperty("count") %></td>
</tr>
        <% } %>
     </table>  
        </body></html>