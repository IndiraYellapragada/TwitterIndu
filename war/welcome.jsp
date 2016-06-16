
    <!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <title>Twitter Indira Application</title>
  </head>

  <script>


	 
  function statusChangeCallback(response) {
        console.log('statusChangeCallback');
        console.log(response);
        if (response.status === 'connected') {
		twtusr();
			} else if (response.status === 'not_authorized') {
               document.getElementById('status').innerHTML = 'Please log ' +'into this app.';
         } else {
               document.getElementById('status').innerHTML = 'Please log ' + 'into Facebook.';
         }
  }
  function testAPI() {
      console.log('Welcome! Fetching your information.... ');
      FB.api('/me?fields=name,birthday', function(response) {
            console.log('Successful login for: ' + response.name);
            document.getElementById('status').innerHTML ='Thanks for logging in, ' + response.name +'!';
            document.getElementById("welcome1").style.visibility="visible";  
            document.getElementById("welcome2").style.visibility="visible" ;   
            document.getElementById("welcome3").style.visibility="visible";  
            document.getElementById("welcome4").style.visibility="visible" ;
            document.getElementById("loginbuton").style.visibility="hidden";  

      });

}
  
  function checkLoginState() {
         FB.getLoginStatus(function(response) {

               statusChangeCallback(response);
         });
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

  function testMessageCreate() {
	  console.log('Posting a message to user feed.... '); 
	  //first must ask for permission to post and then will have call back function defined right inline code
	  // to post the message.
	  FB.login(function(){
	        var typed_text = document.getElementById("message_text").value;
	         FB.api('/me/feed', 'post', {message: typed_text});
	         document.getElementById('theText').innerHTML = 'Thanks for posting the message' + typed_text;
	    }, {scope: 'publish_actions'});
	 }

  function twtusr(){
	 
                  	  FB.api("/me",function (response) {
                 	 
         	  			 document.getElementById('zname').value = response.name ;
         	  			 document.getElementById('uid').value = response.id ;
         	  			 
         	  		  });
       }

</script>

<body >
 <fb:login-button  scope="public_profile,email,user_friends" onlogin="checkLoginState();">

  </fb:login-button> 

 <h1 id="welcome1">Welcome to Twitter Indira Application </h1>
<!-- <input id="welcome2" type="button" value="Tweet"  onclick="location.href='tweets'"/>    
 -->

 
  <form  name="form1" action="/tweets" method="get">
  <input type="hidden"  id="zname" name="zname" value=""/>
      <input type="hidden"  id="uid" name="uid" value=""/>
      <input id="welcome2" type="submit" value="Tweetlist"  onclick="location.href='/tweets.jsp?'"/>    
    
 </form>
<input id="welcome3" type="button" value="Friends" onclick="location.href='/friendstweet'"/>
<input id="welcome4" type="button" value="Top Tweets" onclick="location.href='/toptweets'"/>
 
 </body>

</html>

    